package nic.watersoft.works;
import java.sql.Connection;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.DAOMessage;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.fundAccounting.ConnectionManager;
import nic.watersoft.fundAccounting.Rws_BroDetailsBean;
import nic.watersoft.fundAccounting.Rws_BroProgDetailsBean;


public class Rws_progressReportData {
	
	DataSource dataSource;
	public Rws_progressReportData(){
		super();
	}
	public Rws_progressReportData(DataSource dataSource)
	{
		this.dataSource=dataSource;
	}
	
	public DAOMessage insertProgressReport(String dcode,String financialYear,String month,ArrayList progressReprotEntries)throws Exception
	{

	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        String message=null;
        boolean recordInserted=true;
        DAOMessage daoMessage=new DAOMessage();
        daoMessage.setOperationSussess(true);
        try
			{
	        	conn=connMgr.getConnection();
	        	conn.setAutoCommit(false);
	            connMgr.stmt=conn.createStatement();
	            /*
	            String query="select count(*) from RWS_MON_FIN_PHY_PROGRESS_TBL where dcode='"+dcode+"'";
	            //System.out.println("query is "+query);
	            connMgr.rs=connMgr.stmt.executeQuery(query);
	            
	            boolean recordAlreadyExists=false;
	            while(connMgr.rs.next())
	            {
	            	if(connMgr.rs.getInt(1)>0)
	            		recordAlreadyExists=true;
	            }
	            */
	            String sqlQuery = "delete from RWS_MON_FIN_PHY_PROGRESS_TBL " 
	            	+" where dcode='"+dcode+"' and FIN_YEAR='"+financialYear+"' " 
					+" and month='"+month+"'";
            	//System.out.println("query is "+sqlQuery);
            	connMgr.stmt.addBatch(sqlQuery);
	            	for(int i=0;i<progressReprotEntries.size();i++)
		            {
	            		Rws_progressReport_bean bean=(Rws_progressReport_bean)progressReprotEntries.get(i);
	            		
		            	
	            		sqlQuery = "INSERT INTO RWS_MON_FIN_PHY_PROGRESS_TBL(" 
	            		+"DCODE,PROGRAMME_CODE,FIN_YEAR,MONTH," 
						+"OP_BAL,EXPENDITURE_DUR_THE_MONTH," 
						+"SPILL_WORKS_NO,SPILL_BAL_COST,SPILL_BAL_HABS," 
						+"SPILL_BAL_IP_PH1_HABS,NEW_NO,NEW_COST,NEW_IP_PH1_HABS," 
						+"NEW_IP_PH2_HABS,PROGRESS_ENTRUSTED,PROGRESS_GROUNDED," 
						+"WORKS_COMP,COVERED_HABS,COVERED_IP_PH1_HABS," 
						+"COVERED_IP_PH2_HABS,RELEASES_DUR_MON,RELEASES_UPTO_MON,TOTAL_HABS," 
	            		+"COMMITMENT,PLAN_NONPLAN,NORMAL_OTHERS) values('"
						+ dcode+"','"+bean.getProgrammeCode()+"','"
						+financialYear+"','"+month+"','"+ bean.getOpeningBalance()+"','"
						+bean.getDuringTheMonth()+"','"+bean.getSpillOverWorksNo()+"','"
						+bean.getSpillOverWorksBalCost()+"','"
						+bean.getSpillOverWorksBalHabs()+"','"
						+bean.getSpillOverWorksBalIpPh1Habs()+"','"
						+bean.getNewWorksNo()+"','"
						+bean.getNewWorksCost()+"','"
						+bean.getNewWorksIpPh1Habs()+"','"
						+bean.getNewWorksIpPh2Habs()+"','"
						+bean.getProgressEntrusted()+"','"
						+bean.getProgressGrounded()+"','"
						+bean.getCompletedWorks()+"','"
						+bean.getCompletedCoveredHabs()+"','"
						+bean.getCompletedIpPh1Habs()+"','"
						+bean.getCompletedIpPh2Habs()+"','"
						+bean.getRelease()+"','"
						+bean.getReleasesUptoTheMonth()+"','"
						+bean.getNewWorksTotalHabs()+"','"
						+bean.getCommitment()+"','"
						+bean.getPlanNonPlan()+"','"
						+bean.getCatagory()
						+"')";
	            	//System.out.println("query is "+sqlQuery);
	            	connMgr.stmt.addBatch(sqlQuery);
		            }
	            	
	            	int res[]=connMgr.stmt.executeBatch();
	            	for(int i=1;i<res.length;i++)
	            	{
	            		if(res[i]<1)
	            		{
	            			daoMessage.setMessage("Record Cannot be Inserted");
	            			daoMessage.setOperationSussess(false);
	            		}
	            	}
	            	
	            	if(daoMessage.isOperationSussess())
	            	{
	            		daoMessage.setMessage("Request Processed Successfully");
	            		conn.commit();
	            		conn.setAutoCommit(true);
	            	}
		        
		        	
		 }catch(Exception e)
		 {
		 	//System.out.println("Exception in insertBroDetails is "+e);
		 	daoMessage.setOperationSussess(false);
		 	daoMessage.setMessage("Record Cannot be Inserted");
		 }
		 finally{connMgr.closeAll();}
		 return daoMessage;
	}
	public DAOMessage insertOpeningBalance(String dcode,String divCode,String financialYear,String programmeCode,String openingBalance,String closingBalance)throws Exception
	{

	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        String message=null;
        boolean recordExists=false;
        DAOMessage daoMessage=new DAOMessage();
        daoMessage.setOperationSussess(true);
        try
		{
        	conn=connMgr.getConnection();
        	conn.setAutoCommit(false);
        	connMgr.stmt=conn.createStatement();
        	String sqlQuery = "select count(*) from RWS_MON_PROGREES_OB_BAL " 
        		+ " where dcode='"+dcode+"' and DIVISION_OFFICE_CODE='"+divCode+"' and fin_year='"+financialYear+"' " 
				+ " and programme_code='"+programmeCode+"'";
        	//System.out.println("query is "+sqlQuery);
        	connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
        	
        	if(connMgr.rs.next())
        	{
        		//System.out.println("count is "+connMgr.rs.getInt(1));
        		if(connMgr.rs.getInt(1)>0)
        			recordExists=true;
        	}
        	if(recordExists)
        	{
        		sqlQuery= " update RWS_MON_PROGREES_OB_BAL" 
        			+ " set OP_BAL='"+openingBalance+"'," 
					+ " CL_BAL='"+closingBalance+"' where dcode='"+dcode+"'" 
					+ " and DIVISION_OFFICE_CODE='"+divCode+"' and programme_code='"+programmeCode+"' and " 
					+ " fin_year='"+financialYear+"'"; 
        
        	}
        	else
        	{
                //System.out.println("INSERTED DIVISION CODE"+divCode);
        		sqlQuery= " insert into RWS_MON_PROGREES_OB_BAL(" 
        			+ " DCODE,DIVISION_OFFICE_CODE,PROGRAMME_CODE,FIN_YEAR,OP_BAL,CL_BAL) values('" 
					+dcode+"','"+divCode+"','"+programmeCode+"','"+financialYear+"','"+openingBalance+"','"+closingBalance+"')";
        		
        	}
        	
        	//System.out.println("query is "+sqlQuery);
        	int rcount=connMgr.stmt.executeUpdate(sqlQuery);
        	
        	if(rcount<1)
        	{
        		daoMessage.setMessage("Record Cannot be Inserted");
        		daoMessage.setOperationSussess(false);
        	}
        	
        	if(daoMessage.isOperationSussess())
        	{
        		if(!recordExists)
        			daoMessage.setMessage("Record Inserted Successfully");
        		else
        			daoMessage.setMessage("Record Updated Successfully");
        		conn.commit();
        		conn.setAutoCommit(true);
        	}
		}catch(Exception e)
		{
			//System.out.println("Exception in insertOpeningBalance is "+e);
			daoMessage.setOperationSussess(false);
			daoMessage.setMessage("Record Cannot be Inserted");
		}
		 finally{connMgr.closeAll();}
		 return daoMessage;
	}
	 public ArrayList getProgressReport(String dcode,String divcode,String financialYear,String month)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	ArrayList progressReportEntries=new ArrayList();
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		String sqlQuery = "SELECT "
	 			+" DCODE,DIVISION_OFFICE_CODE,PROGRAMME_CODE,FIN_YEAR,MONTH," 
				
				+ "(select CL_BAL  from RWS_MON_PROGREES_OB_BAL " 
				+ " where DCODE ='"+dcode+"'  " 
				+ " and DIVISION_OFFICE_CODE='"+divcode+"'" 
				+ " t1.programme_code=programme_code and " 
				+ " FIN_YEAR ='"+getPreviousFinancialYear(financialYear)+"')as openingBalance,"
				
				
				+ " EXPENDITURE_DUR_THE_MONTH," 
				+" SPILL_WORKS_NO,SPILL_BAL_COST,SPILL_BAL_HABS," 
				+" SPILL_BAL_IP_PH1_HABS,NEW_NO,NEW_COST,NEW_IP_PH1_HABS," 
				+" NEW_IP_PH2_HABS,PROGRESS_ENTRUSTED,PROGRESS_GROUNDED," 
				+" WORKS_COMP,COVERED_HABS,COVERED_IP_PH1_HABS," 
				+" COVERED_IP_PH2_HABS,RELEASES_DUR_MON,TOTAL_HABS,COMMITMENT,PLAN_NONPLAN,NORMAL_OTHERS," 
				
				
				+"(select sum(RELEASES_DUR_MON) " 
				+"from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+"where  dcode='"+dcode+"'"
				+ " and DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+"and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and t1.programme_code=programme_code)as releasesUptoTheMonth,   " 
				
				
				+"(select sum(EXPENDITURE_DUR_THE_MONTH ) " 
				+"from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+"where  dcode='"+dcode+"' and DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+"and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and t1.programme_code=programme_code)as expUptoTheMonth   " 
				
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL t1 " 
				+" where dcode='"+dcode+"' and DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and month='"+month+"'"; 
	 		
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		
	 		while (connMgr.rs.next())
	 		{
	 			Rws_progressReport_bean bean=new Rws_progressReport_bean();
	 			bean.setProgrammeCode(connMgr.rs.getString("programme_code"));
	 			bean.setCommitment(connMgr.rs.getString("COMMITMENT"));
	 			bean.setPlanNonPlan(connMgr.rs.getString("PLAN_NONPLAN"));
	 			bean.setCatagoryList(getCatagoryList(connMgr.rs.getString("PLAN_NONPLAN")));
	 			bean.setCatagory(connMgr.rs.getString("NORMAL_OTHERS"));
	 			
	 			bean.setOpeningBalance(connMgr.rs.getString("openingBalance"));
	 			bean.setRelease(connMgr.rs.getString("RELEASES_DUR_MON"));
	 			bean.setReleasesUptoTheMonth(connMgr.rs.getString("releasesUptoTheMonth"));
	 			bean.setDuringTheMonth(connMgr.rs.getString("expenditure_dur_the_month"));
	 			bean.setUptoTheMonth(connMgr.rs.getString("expUptoTheMonth"));
	 			bean.setSpillOverWorksNo(connMgr.rs.getString("spill_works_no"));
	 			bean.setSpillOverWorksBalCost(connMgr.rs.getString("spill_bal_cost"));
	 			bean.setSpillOverWorksBalHabs(connMgr.rs.getString("spill_bal_habs"));
	 			bean.setSpillOverWorksBalIpPh1Habs(connMgr.rs.getString("spill_bal_ip_ph1_habs"));
	 			bean.setNewWorksNo(connMgr.rs.getString("new_no"));
	 			bean.setNewWorksCost(connMgr.rs.getString("new_cost"));
	 			bean.setNewWorksTotalHabs(connMgr.rs.getString("total_habs"));
	 			bean.setNewWorksIpPh1Habs(connMgr.rs.getString("new_ip_ph1_habs"));
	 			bean.setNewWorksIpPh2Habs(connMgr.rs.getString("new_ip_ph2_habs"));
	 			bean.setProgressEntrusted(connMgr.rs.getString("progress_entrusted"));
	 			bean.setProgressGrounded(connMgr.rs.getString("progress_grounded"));
	 			bean.setCompletedWorks(connMgr.rs.getString("works_comp"));
	 			bean.setCompletedCoveredHabs(connMgr.rs.getString("covered_habs"));
	 			bean.setCompletedIpPh1Habs(connMgr.rs.getString("COVERED_IP_PH1_HABS"));
	 			bean.setCompletedIpPh2Habs(connMgr.rs.getString("COVERED_IP_PH2_HABS"));
	 			progressReportEntries.add(bean);
	 		}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getProgrammeName" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return progressReportEntries;
	 }
	 public Rws_progressReport_bean getProgressReportEntry(String dcode,String divcode,String financialYear,String programmeCode,String month)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	Rws_progressReport_bean bean=new Rws_progressReport_bean();
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		String sqlQuery = "SELECT "
	 			+" DCODE,PROGRAMME_CODE,FIN_YEAR,MONTH," 
				
				+ "(select CL_BAL  from RWS_MON_PROGREES_OB_BAL " 
				+ " where DCODE ='"+dcode+"'  and " 
				+ " DIVISION_OFFICE_CODE='"+divcode+"' and t1.programme_code=programme_code and " 
				+ " FIN_YEAR ='"+getPreviousFinancialYear(financialYear)+"')as openingBalance,"
				
				
				+ " EXPENDITURE_DUR_THE_MONTH," 
				+" SPILL_WORKS_NO,SPILL_BAL_COST,SPILL_BAL_HABS," 
				+" SPILL_BAL_IP_PH1_HABS,NEW_NO,NEW_COST,NEW_IP_PH1_HABS," 
				+" NEW_IP_PH2_HABS,PROGRESS_ENTRUSTED,PROGRESS_GROUNDED," 
				+" WORKS_COMP,COVERED_HABS,COVERED_IP_PH1_HABS," 
				+" COVERED_IP_PH2_HABS,RELEASES_DUR_MON,TOTAL_HABS," 
				
				
				+"(select sum(RELEASES_DUR_MON) " 
				+"from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+"where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+"and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and t1.programme_code=programme_code and programme_code='"+programmeCode+"')as releasesUptoTheMonth,   " 
				
				
				+"(select sum(EXPENDITURE_DUR_THE_MONTH ) " 
				+"from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+"where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+"and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and t1.programme_code=programme_code and programme_code='"+programmeCode+"' )as expUptoTheMonth   " 
				
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL t1 " 
				+" where dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' and programme_code='"+programmeCode+"'" 
				+" and month='"+month+"'"; 
	 		
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		
	 		while (connMgr.rs.next())
	 		{
	 			
	 			bean.setProgrammeCode(connMgr.rs.getString("programme_code"));
	 			bean.setOpeningBalance(connMgr.rs.getString("openingBalance"));
	 			bean.setRelease(connMgr.rs.getString("RELEASES_DUR_MON"));
	 			bean.setReleasesUptoTheMonth(connMgr.rs.getString("releasesUptoTheMonth"));
	 			bean.setDuringTheMonth(connMgr.rs.getString("expenditure_dur_the_month"));
	 			bean.setUptoTheMonth(connMgr.rs.getString("expUptoTheMonth"));
	 			bean.setSpillOverWorksNo(connMgr.rs.getString("spill_works_no"));
	 			bean.setSpillOverWorksBalCost(connMgr.rs.getString("spill_bal_cost"));
	 			bean.setSpillOverWorksBalHabs(connMgr.rs.getString("spill_bal_habs"));
	 			bean.setSpillOverWorksBalIpPh1Habs(connMgr.rs.getString("spill_bal_ip_ph1_habs"));
	 			bean.setNewWorksNo(connMgr.rs.getString("new_no"));
	 			bean.setNewWorksCost(connMgr.rs.getString("new_cost"));
	 			bean.setNewWorksTotalHabs(connMgr.rs.getString("total_habs"));
	 			bean.setNewWorksIpPh1Habs(connMgr.rs.getString("new_ip_ph1_habs"));
	 			bean.setNewWorksIpPh2Habs(connMgr.rs.getString("new_ip_ph2_habs"));
	 			bean.setProgressEntrusted(connMgr.rs.getString("progress_entrusted"));
	 			bean.setProgressGrounded(connMgr.rs.getString("progress_grounded"));
	 			bean.setCompletedWorks(connMgr.rs.getString("works_comp"));
	 			bean.setCompletedCoveredHabs(connMgr.rs.getString("covered_habs"));
	 			bean.setCompletedIpPh1Habs(connMgr.rs.getString("COVERED_IP_PH1_HABS"));
	 			bean.setCompletedIpPh2Habs(connMgr.rs.getString("COVERED_IP_PH2_HABS"));
	 			
	 		}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getProgrammeName" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return bean;
	 }
	 public Rws_progressReport_bean getProgressReportEntry(String dcode,String divcode,String financialYear,String programmeCode,String month,String planNonPlan,String catagory)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	Rws_progressReport_bean bean=new Rws_progressReport_bean();
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		String sqlQuery = "SELECT "
	 			+" DCODE,PROGRAMME_CODE,FIN_YEAR,MONTH," 
				
				+ "(select CL_BAL  from RWS_MON_PROGREES_OB_BAL " 
				+ " where DCODE ='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and " 
				+ " t1.programme_code=programme_code and " 
				+ " FIN_YEAR ='"+getPreviousFinancialYear(financialYear)+"')as openingBalance,"
				
				
				+ " EXPENDITURE_DUR_THE_MONTH," 
				+" SPILL_WORKS_NO,SPILL_BAL_COST,SPILL_BAL_HABS," 
				+" SPILL_BAL_IP_PH1_HABS,NEW_NO,NEW_COST,NEW_IP_PH1_HABS," 
				+" NEW_IP_PH2_HABS,PROGRESS_ENTRUSTED,PROGRESS_GROUNDED," 
				+" WORKS_COMP,COVERED_HABS,COVERED_IP_PH1_HABS," 
				+" COVERED_IP_PH2_HABS,RELEASES_DUR_MON,TOTAL_HABS,COMMITMENT,PLAN_NONPLAN,NORMAL_OTHERS," 
				
				
				+"(select sum(RELEASES_DUR_MON) " 
				+"from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+"where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+"and getFinancialMonth(month)<getFinancialMonth('"+month+"') " 
				+"and PLAN_NONPLAN ='"+planNonPlan+"' and NORMAL_OTHERS='"+catagory+"' " 
				+" and t1.programme_code=programme_code and programme_code='"+programmeCode+"')as releasesUptoTheMonth,   " 
				
				
				+"(select sum(EXPENDITURE_DUR_THE_MONTH ) " 
				+"from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+"where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+"and getFinancialMonth(month)<getFinancialMonth('"+month+"') " 
				+"and PLAN_NONPLAN ='"+planNonPlan+"' and NORMAL_OTHERS='"+catagory+"' " 
				+" and t1.programme_code=programme_code and programme_code='"+programmeCode+"' )as expUptoTheMonth   " 
				
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL t1 " 
				+" where dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' and programme_code='"+programmeCode+"'" 
				+"and PLAN_NONPLAN ='"+planNonPlan+"' and NORMAL_OTHERS='"+catagory+"' " 
				+" and month='"+month+"'"; 
	 		
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		
	 		while (connMgr.rs.next())
	 		{
	 			
	 			//bean.setProgrammeCode(connMgr.rs.getString("programme_code"));
	 			bean.setProgrammeCode(programmeCode);
	 			bean.setCommitment(connMgr.rs.getString("COMMITMENT"));
	 			//bean.setPlanNonPlan(connMgr.rs.getString("PLAN_NONPLAN"));
	 			bean.setPlanNonPlan(planNonPlan);
	 			//bean.setCatagory(connMgr.rs.getString("NORMAL_OTHERS"));
	 			bean.setCatagory(catagory);
	 			bean.setCatagoryList(getCatagoryList(planNonPlan));
	 			
	 			bean.setOpeningBalance(connMgr.rs.getString("openingBalance"));
	 			bean.setRelease(connMgr.rs.getString("RELEASES_DUR_MON"));
	 			bean.setReleasesUptoTheMonth(connMgr.rs.getString("releasesUptoTheMonth"));
	 			bean.setDuringTheMonth(connMgr.rs.getString("expenditure_dur_the_month"));
	 			bean.setUptoTheMonth(connMgr.rs.getString("expUptoTheMonth"));
	 			bean.setSpillOverWorksNo(connMgr.rs.getString("spill_works_no"));
	 			bean.setSpillOverWorksBalCost(connMgr.rs.getString("spill_bal_cost"));
	 			bean.setSpillOverWorksBalHabs(connMgr.rs.getString("spill_bal_habs"));
	 			bean.setSpillOverWorksBalIpPh1Habs(connMgr.rs.getString("spill_bal_ip_ph1_habs"));
	 			bean.setNewWorksNo(connMgr.rs.getString("new_no"));
	 			bean.setNewWorksCost(connMgr.rs.getString("new_cost"));
	 			bean.setNewWorksTotalHabs(connMgr.rs.getString("total_habs"));
	 			bean.setNewWorksIpPh1Habs(connMgr.rs.getString("new_ip_ph1_habs"));
	 			bean.setNewWorksIpPh2Habs(connMgr.rs.getString("new_ip_ph2_habs"));
	 			bean.setProgressEntrusted(connMgr.rs.getString("progress_entrusted"));
	 			bean.setProgressGrounded(connMgr.rs.getString("progress_grounded"));
	 			bean.setCompletedWorks(connMgr.rs.getString("works_comp"));
	 			bean.setCompletedCoveredHabs(connMgr.rs.getString("covered_habs"));
	 			bean.setCompletedIpPh1Habs(connMgr.rs.getString("COVERED_IP_PH1_HABS"));
	 			bean.setCompletedIpPh2Habs(connMgr.rs.getString("COVERED_IP_PH2_HABS"));
	 			
	 		}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getProgrammeName" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return bean;
	 }
	 /*
	 //opening balance is not got from RWS_MON_FIN_PHY_PROGRESS_TBL  and not RWS_MON_PROGREES_OB_BAL
	 public ArrayList getProgressReport2(String dcode,String financialYear,String month)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	ArrayList progressReportEntries=new ArrayList();
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		String sqlQuery = "SELECT "
	 			+" DCODE,PROGRAMME_CODE,FIN_YEAR,MONTH," 
				
				+ "(select CL_BAL  from RWS_MON_PROGREES_OB_BAL " 
				+ " where DCODE ='"+dcode+"'  and " 
				+ " t1.programme_code=programme_code and " 
				+ " FIN_YEAR ='"+getPreviousFinancialYear(financialYear)+"')as openingBalance,"
				
				
				+" EXPENDITURE_DUR_THE_MONTH," 
				+" SPILL_WORKS_NO,SPILL_BAL_COST,SPILL_BAL_HABS," 
				+" SPILL_BAL_IP_PH1_HABS,NEW_NO,NEW_COST,NEW_IP_PH1_HABS," 
				+" NEW_IP_PH2_HABS,PROGRESS_ENTRUSTED,PROGRESS_GROUNDED," 
				+" WORKS_COMP,COVERED_HABS,COVERED_IP_PH1_HABS," 
				+" COVERED_IP_PH2_HABS,RELEASES_DUR_MON,TOTAL_HABS," 
				
				
				+" (select sum(RELEASES_DUR_MON) " 
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+" where  dcode='"+dcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and t1.programme_code=programme_code)as releasesUptoTheMonth,   " 
				
				
				+" (select sum(EXPENDITURE_DUR_THE_MONTH ) " 
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+" where  dcode='"+dcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and t1.programme_code=programme_code)as expUptoTheMonth   " 
				
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL t1 " 
				+" where dcode='"+dcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and month='"+month+"'"; 
	 		
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		
	 		while (connMgr.rs.next())
	 		{
	 			Rws_progressReport_bean bean=new Rws_progressReport_bean();
	 			bean.setProgrammeCode(connMgr.rs.getString("programme_code"));
	 			bean.setOpeningBalance(connMgr.rs.getString("openingBalance"));
	 			bean.setRelease(connMgr.rs.getString("RELEASES_DUR_MON"));
	 			bean.setReleasesUptoTheMonth(connMgr.rs.getString("releasesUptoTheMonth"));
	 			bean.setDuringTheMonth(connMgr.rs.getString("expenditure_dur_the_month"));
	 			bean.setUptoTheMonth(connMgr.rs.getString("expUptoTheMonth"));
	 			bean.setSpillOverWorksNo(connMgr.rs.getString("spill_works_no"));
	 			bean.setSpillOverWorksBalCost(connMgr.rs.getString("spill_bal_cost"));
	 			bean.setSpillOverWorksBalHabs(connMgr.rs.getString("spill_bal_habs"));
	 			bean.setSpillOverWorksBalIpPh1Habs(connMgr.rs.getString("spill_bal_ip_ph1_habs"));
	 			bean.setNewWorksNo(connMgr.rs.getString("new_no"));
	 			bean.setNewWorksCost(connMgr.rs.getString("new_cost"));
	 			bean.setNewWorksTotalHabs(connMgr.rs.getString("total_habs"));
	 			bean.setNewWorksIpPh1Habs(connMgr.rs.getString("new_ip_ph1_habs"));
	 			bean.setNewWorksIpPh2Habs(connMgr.rs.getString("new_ip_ph2_habs"));
	 			bean.setProgressEntrusted(connMgr.rs.getString("progress_entrusted"));
	 			bean.setProgressGrounded(connMgr.rs.getString("progress_grounded"));
	 			bean.setCompletedWorks(connMgr.rs.getString("works_comp"));
	 			bean.setCompletedCoveredHabs(connMgr.rs.getString("covered_habs"));
	 			bean.setCompletedIpPh1Habs(connMgr.rs.getString("COVERED_IP_PH1_HABS"));
	 			bean.setCompletedIpPh2Habs(connMgr.rs.getString("COVERED_IP_PH2_HABS"));
	 			progressReportEntries.add(bean);
	 		}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getProgrammeName" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return progressReportEntries;
	 }
	 */
	 public String getExpUptoTheMonth(String dcode,String divcode,String programmeCode,String financialYear,String month)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String uptoTheMonth="";
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		String sqlQuery = "select sum(EXPENDITURE_DUR_THE_MONTH ) as exp_upto_the_month  " 
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+" where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and programme_code='"+programmeCode+"'"; 
				 
	 		
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		while (connMgr.rs.next())
	 		{
	 			uptoTheMonth=connMgr.rs.getString("exp_upto_the_month");
	 		}
	 	} 
	 	catch (Exception e) 
		{
	 		//System.out.println("Exception occured in getProgrammeName" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return uptoTheMonth;
	 }
	 
	 public String getExpUptoTheMonth(String dcode,String divcode,String programmeCode,String financialYear,String month,String planNonPlan,String catagory)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String uptoTheMonth="";
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		String sqlQuery = "select sum(EXPENDITURE_DUR_THE_MONTH ) as exp_upto_the_month  " 
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+" where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and programme_code='"+programmeCode+"' and PLAN_NONPLAN ='"+planNonPlan+"' and NORMAL_OTHERS ='"+catagory+"'"; 
				 
	 		
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		while (connMgr.rs.next())
	 		{
	 			uptoTheMonth=connMgr.rs.getString("exp_upto_the_month");
	 		}
	 	} 
	 	catch (Exception e) 
		{
	 		//System.out.println("Exception occured in getProgrammeName" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return uptoTheMonth;
	 }
	 public String getReleasesUptoTheMonth(String dcode,String divcode,String programmeCode,String financialYear,String month)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String uptoTheMonth="";
	 	try
		{
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		String sqlQuery = " select sum(RELEASES_DUR_MON) as releasesUptoTheMonth  " 
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+" where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"'" 
				+" and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and programme_code='"+programmeCode+"'"; 
				 
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		while (connMgr.rs.next())
	 		{
	 			uptoTheMonth=connMgr.rs.getString("releasesUptoTheMonth");
	 		}
	 	} 
	 	catch (Exception e) 
		{
	 		//System.out.println("Exception occured in getReleasesUptoTheMonth" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return uptoTheMonth;
	 }
	 
	 
	 public String getReleasesUptoTheMonth(String dcode,String divcode,String programmeCode,String financialYear,String month,String planNonPlan,String catagory)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String uptoTheMonth="";
	 	try
		{
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		String sqlQuery = " select sum(RELEASES_DUR_MON) as releasesUptoTheMonth  " 
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+" where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"'" 
				+" and getFinancialMonth(month)<getFinancialMonth('"+month+"')" 
				+" and programme_code='"+programmeCode+"' and PLAN_NONPLAN  ='"+planNonPlan+"' and NORMAL_OTHERS ='"+catagory+"'"; 
				 
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		while (connMgr.rs.next())
	 		{
	 			uptoTheMonth=connMgr.rs.getString("releasesUptoTheMonth");
	 		}
	 	} 
	 	catch (Exception e) 
		{
	 		//System.out.println("Exception occured in getReleasesUptoTheMonth" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return uptoTheMonth;
	 }
	 
	 public String getOpeningBalance(String dcode,String divcode,String financialYear,String programmeCode)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String openingBalance="";
	 	try
		{
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		String sqlQuery = "select OP_BAL " 
				+" from RWS_MON_PROGREES_OB_BAL   " 
				+" where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and programme_code='"+programmeCode+"'  "; 
				 
	 		//System.out.println(sqlQuery);
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		while (connMgr.rs.next())
	 		{
	 			openingBalance=connMgr.rs.getString("OP_BAL");
	 		}
	 	} 
	 	catch (Exception e) 
		{
	 		//System.out.println("Exception occured in getOpeningBalance" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return openingBalance;
	 }
	 //this methods whether the data for the previous year exists
	 //if the data for the previous year exists it calculates opening balance from the previous year data
	 //if the previous year data not exists it gets the opening balance as closing balance from the opening balance table
	 //if closing balance for the previous year does not exists for the previous year in the opening balance table -
	 //it throws OpeningBalanceNotFoundException
	 public String getCalculatedOpeningBalance(String dcode,String divcode,String financialYear,String programmeCode,String planNonPlan,String catagory)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String openingBalance="";
	 	try
		{
	 		//if data for the previous year does not exists get the opening balance
	 		//from the opening balance table
	 		if(!isDataExists(dcode,getPreviousFinancialYear(financialYear),programmeCode,planNonPlan,catagory))
	 		{
	 			conn=connMgr.getConnection();
	 			connMgr.stmt=conn.createStatement();
	 			String sqlQuery = "select OP_BAL " 
	 				+" from RWS_MON_PROGREES_OB_BAL   " 
					+" where  dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and FIN_YEAR='"+getPreviousFinancialYear(financialYear)+"' " 
					+" and programme_code='"+programmeCode+"'  "; 
	 			
	 			//System.out.println(sqlQuery);
	 			connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 			
	 			while (connMgr.rs.next())
	 			{
	 				openingBalance=connMgr.rs.getString("OP_BAL");
	 			}
	 		}
	 		//if data for the previous financial year exists calculate the opening balance for the current financial year
	 		//as previous financial year opening balance + previous financial year total releases -previous financial year expenditure
	 		else
	 		{
	 			conn=connMgr.getConnection();
	        	conn.setAutoCommit(false);
	        	connMgr.stmt=conn.createStatement();
	        	float totalExpenditure=0;
	        	float totalReleases=0;
	        	String sqlQuery = "select sum(RELEASES_DUR_MON)as expTotal,sum(EXPENDITURE_DUR_THE_MONTH)releasesTotal  from RWS_MON_FIN_PHY_PROGRESS_TBL" 
	        		+ " where dcode='"+dcode+"' and fin_year='"+getPreviousFinancialYear(financialYear)+"' " 
					+ " and programme_code='"+programmeCode+"'";
	        	//System.out.println("query is "+sqlQuery);
	        	connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	        	
	        	if(connMgr.rs.next())
	        	{
	        		totalExpenditure=connMgr.rs.getFloat("expTotal");
	        		totalReleases=connMgr.rs.getFloat("releasesTotal");
	        	}
	        	sqlQuery = "select CL_BAL  from RWS_MON_PROGREES_OB_BAL" 
	        		+ " where dcode='"+dcode+"' DIVISION_OFFICE_CODE='"+divcode+"' and fin_year='"+getPreviousFinancialYear(getPreviousFinancialYear(financialYear))+"' " 
					+ " and programme_code='"+programmeCode+"'";
	        	//System.out.println("query is "+sqlQuery);
	        	connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	        	float closingBalance=0;
	        	boolean closingBalanceExists=false;
	        	if(connMgr.rs.next())
	        	{
	        		closingBalance=connMgr.rs.getFloat("cl_bal");
	        		closingBalanceExists=true;
	        		
	        	}
	        	float closingBalanceForThePreviousYear=closingBalance+totalReleases-totalExpenditure;
	        	//if closing balance in the balance table exists it calculates and returns closing balance for the previous year
	        	//if closing balance does not exists in the balance table it returns empty string.
	        	if(closingBalanceExists)
	        		openingBalance=closingBalanceForThePreviousYear+"";
	        	else
	        		openingBalance="";
	 		}
	 	} 
	 	catch (Exception e) 
		{
	 		//System.out.println("Exception occured in getOpeningBalance" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	//System.out.println("opening balance is "+openingBalance);
	 	return openingBalance;
	 }
	 
	 public boolean isDataExists(String dcode,String divCode,String financialYear,String programmeCode)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	boolean dataExists=false;
	 	try
		{
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		String sqlQuery = "select *" 
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+" where  dcode='"+dcode+"' and DIVISION_OFFICE_CODE='"+divCode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and programme_code='"+programmeCode+"'  "; 
				 
	 		//System.out.println(sqlQuery);
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		while (connMgr.rs.next())
	 		{
	 			dataExists=true;
	 		}
	 	} 
	 	catch (Exception e) 
		{
	 		//System.out.println("Exception occured in isDataExists" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return dataExists;
	 }
	 
	 public boolean isDataExists(String dcode,String financialYear,String programmeCode,String planNonPlan,String catagory)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	boolean dataExists=false;
	 	try
		{
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		String sqlQuery = "select *" 
				+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
				+" where  dcode='"+dcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and programme_code='"+programmeCode+"' " 
				+" and PLAN_NONPLAN='"+planNonPlan+"' and NORMAL_OTHERS='"+catagory+"'"; 
				 
	 		//System.out.println(sqlQuery);
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		while (connMgr.rs.next())
	 		{
	 			dataExists=true;
	 		}
	 	} 
	 	catch (Exception e) 
		{
	 		//System.out.println("Exception occured in isDataExists" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return dataExists;
	 }
	 public String getClosingBalance(String dcode,String programmeCode,String financialYear,String month)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String openingBalance="";
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		String sqlQuery = "select CL_BAL " 
				+" from RWS_MON_PROGREES_OB_BAL   " 
				+" where  dcode='"+dcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and programme_code='"+programmeCode+"'  "; 
				 
	 		
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		
	 		while (connMgr.rs.next())
	 		{
	 			openingBalance=connMgr.rs.getString("CL_BAL");
	 			
	 		}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getOpeningBalance" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return openingBalance;
	 }
	 public String getClosingBalance(String dcode,String programmeCode,String financialYear,String month,String planNonPlan,String catagory)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String openingBalance="";
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		
	 		/*
	 		String sqlQuery = "select CL_BAL " 
				+" from RWS_MON_PROGREES_OB_BAL   " 
				+" where  dcode='"+dcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and programme_code='"+programmeCode+"' " 
				+" and PLAN_NONPLAN='"+planNonPlan+"' and NORMAL_OTHERS='"+catagory+"'"; 
				 
	 		*/
	 		String sqlQuery = "select CL_BAL " 
				+" from RWS_MON_PROGREES_OB_BAL   " 
				+" where  dcode='"+dcode+"' and FIN_YEAR='"+financialYear+"' " 
				+" and programme_code='"+programmeCode+"' "; 
				
				 
	 		
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		
	 		while (connMgr.rs.next())
	 		{
	 			openingBalance=connMgr.rs.getString("CL_BAL");
	 			
	 		}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getOpeningBalance" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return openingBalance;
	 }
	 public ArrayList getOpeningBalances(String dcode,String divCode,String financialYear,String programmeCode,String openingBalance)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	ArrayList openingBalancesList=new ArrayList();
	 	nic.watersoft.fundAccounting.Rws_BroData broData=new nic.watersoft.fundAccounting.Rws_BroData(dataSource);
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		String sqlQuery = "select dcode,DIVISION_OFFICE_code,programme_code,fin_year,op_bal,cl_bal from RWS_MON_PROGREES_OB_BAL ";
	 		if(!dcode.equals("")||!programmeCode.equals("")||!financialYear.equals(""))
	 			sqlQuery+=" where dcode is not null ";
	 		if(!dcode.equals(""))
	 		{
	 			sqlQuery+="and dcode='"+dcode+"'";
	 			
	 		}
	 		if(!divCode.equals(""))
	 		{
	 			sqlQuery+="and DIVISION_OFFICE_CODE='"+divCode+"'";
	 			
	 		}
	 		if(!financialYear.equals(""))
	 			sqlQuery+=" and fin_year='"+financialYear+"'";
	 		if(!programmeCode.equals(""))
	 			sqlQuery+=" and programme_code='"+programmeCode+"'";
				 
	 		sqlQuery+=" order by dcode,DIVISION_OFFICE_CODE,programme_code,fin_year";
	 		//System.out.println(sqlQuery);
	 		
	 		connMgr.rs = connMgr.stmt.executeQuery(sqlQuery);
	 		
	 		Rws_progressReport_bean bean=null;
	 		RwsOffices rwsOffices=new RwsOffices(dataSource);
	 		while (connMgr.rs.next())
	 		{
	 			bean=new Rws_progressReport_bean();
	 			bean.setDistrict(connMgr.rs.getString("dcode"));
	 			bean.setDname(rwsOffices.getDistrictName(connMgr.rs.getString("dcode")));
	 			//System.out.println("Division Code in BEAN:"+divCode);
	 			bean.setDivision(divCode);
	 			bean.setDivisionName(rwsOffices.getDivisionOfficeName(dataSource,"1",dcode,connMgr.rs.getString("DIVISION_OFFICE_CODE")));
	 			bean.setProgrammeCode(connMgr.rs.getString("programme_code"));
	 			bean.setProgrammeName(broData.getProgrammeName(connMgr.rs.getString("programme_code")));
	 			bean.setFinancialYear(connMgr.rs.getString("fin_year"));
	 			bean.setOpeningBalance(connMgr.rs.getString("op_bal"));
	 			bean.setClosingBalance(connMgr.rs.getString("cl_bal"));
	 			openingBalancesList.add(bean);
	 		}
	 		
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getOpeningBalances" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return openingBalancesList;
	 }
	 
	 
	 
	 public String deleteOpeningBalances(String dcode,String divCode,String financialYear,String programmeCode)
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	ArrayList openingBalancesList=new ArrayList();
	 	String message="";
	 	nic.watersoft.fundAccounting.Rws_BroData broData=new nic.watersoft.fundAccounting.Rws_BroData(dataSource);
	 	try
		{
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		//System.out.println("Division Code in Delete query"+divCode);
	 		String sqlQuery = "delete from RWS_MON_PROGREES_OB_BAL  where dcode='"+dcode+"'"; 
	 			if (!(divCode.equals("")))
	 					{
	 				    sqlQuery+=" and division_office_code='"+divCode+"'";
	 					}
	 			 sqlQuery+=" and fin_year='"+financialYear+"' and programme_code='"+programmeCode+"'";
			//System.out.println(sqlQuery);
	 		
	 		int rcount = connMgr.stmt.executeUpdate(sqlQuery);
	 		
	 		if(rcount>0)
	 			message= "Record Deleted Successfully";
	 		else 
	 			message= "Record Cannot be Deleted";
	 		
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getOpeningBalances" +e );
	 		message="Record cannot be deleted";
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return message;
	 }
	 
	 String getOperationToPerform(String dcode,String financialYear,String programmeCode)
	 {
	 	String operation="";
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String previousFinancialYear=(Integer.parseInt(financialYear.substring(0,4))-1)+"-"+financialYear.substring(0,4);
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		String sqlQuery = "select count(*) " 
	 			+" from RWS_MON_PROGREES_OB_BAL   " 
				+" where  dcode='"+dcode+"' and FIN_YEAR='"+previousFinancialYear+"' " 
				+" and programme_code='"+programmeCode+"'  "; 
	 		//System.out.println("query is "+sqlQuery);
	 		connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	 		if(connMgr.rs.next())
	 			if(connMgr.rs.getInt(1)>0)
	 			{
	 				return "proceed";
	 			}
	 			
	 			else
	 			{
	 				sqlQuery = "select count(*) " 
	 					+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
						+" where  dcode='"+dcode+"' and FIN_YEAR='"+previousFinancialYear+"' " 
						+" and programme_code='"+programmeCode+"'  ";
	 				//System.out.println("query is "+sqlQuery);
	 				connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	 				
	 				if(connMgr.rs.next())
	 					if(connMgr.rs.getInt(1)>0)
	 					{
	 						return "insertClosingBalanceIntoBalanceTbl";
	 					}
	 					else
	 					{
	 						return "taskCannotBeCompleted";//entry does not exists in balance table and also in progress table
	 					}
	 			}
	 		
	 		
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getOperationToPerform" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return operation;
	 }
	 
	 String getOperationToPerform(String dcode,String financialYear,String programmeCode,String planNonPlan,String catagory)
	 {
	 	String operation="";
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String previousFinancialYear=(Integer.parseInt(financialYear.substring(0,4))-1)+"-"+financialYear.substring(0,4);
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		String sqlQuery = "select count(*) " 
	 			+" from RWS_MON_PROGREES_OB_BAL   " 
				+" where  dcode='"+dcode+"' and FIN_YEAR='"+previousFinancialYear+"' " 
				+" and programme_code='"+programmeCode+"' " 
				+" and PLAN_NONPLAN='"+planNonPlan+"' and NORMAL_OTHERS='"+catagory+"'";
					 
	 		//System.out.println("query is "+sqlQuery);
	 		connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	 		if(connMgr.rs.next())
	 			if(connMgr.rs.getInt(1)>0)
	 			{
	 				return "proceed";
	 			}
	 			
	 			else
	 			{
	 				sqlQuery = "select count(*) " 
	 					+" from RWS_MON_FIN_PHY_PROGRESS_TBL   " 
						+" where  dcode='"+dcode+"' and FIN_YEAR='"+previousFinancialYear+"' " 
						+" and programme_code='"+programmeCode+"'  ";
	 				//System.out.println("query is "+sqlQuery);
	 				connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	 				
	 				if(connMgr.rs.next())
	 					if(connMgr.rs.getInt(1)>0)
	 					{
	 						return "insertClosingBalanceIntoBalanceTbl";
	 					}
	 					else
	 					{
	 						return "taskCannotBeCompleted";//entry does not exists in balance table and also in progress table
	 					}
	 			}
	 		
	 		
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getOperationToPerform" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return operation;
	 }
	 
	 public String getCurrentFinancialYear()
	 {
	 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	String currentFinancialYear="";
	 	try
		{
	 		
	 		conn=connMgr.getConnection();
	 		connMgr.stmt=conn.createStatement();
	 		String sqlQuery = "select getFinancialYear(to_char(sysdate,'yyyy'),to_char(sysdate,'mm')) from dual";
	 		
			//System.out.println("query is "+sqlQuery);
	 		connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	 		if(connMgr.rs.next())
	 		{
	 			currentFinancialYear=connMgr.rs.getString(1);
	 		}
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getCurrentFinancialYear" +e );
		}
	 	finally
		{
	 		connMgr.closeAll();
		}
	 	return currentFinancialYear;
	 }
	 
	 public String getNextFinancialYear(String currentFinancialYear)
	 {
	 	String nextFinancialYear="";
	 	try
		{
	 		int startYear=Integer.parseInt(currentFinancialYear.substring(0,4));
	 		nextFinancialYear=(startYear+1)+"-"+(startYear+2);
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getNextFinancialYear" +e );
		}
	 	finally
		{
	 		
		}
	 	return nextFinancialYear;
	 }
	 
	 public DAOMessage insertClosingBalanceForPreviousYear(String dcode,String financialYear,String programmeCode)throws Exception
		{

		 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        String message=null;
	        float totalExpenditure=0;
	        float totalReleases=0;
	        float closingBalance=0;
	        DAOMessage daoMessage=new DAOMessage();
	        daoMessage.setOperationSussess(true);
	        try
			{
	        	conn=connMgr.getConnection();
	        	conn.setAutoCommit(false);
	        	connMgr.stmt=conn.createStatement();
	        	String sqlQuery = "select sum(RELEASES_DUR_MON)as expTotal,sum(EXPENDITURE_DUR_THE_MONTH)releasesTotal  from RWS_MON_FIN_PHY_PROGRESS_TBL" 
	        		+ " where dcode='"+dcode+"' and fin_year='"+getPreviousFinancialYear(financialYear)+"' " 
					+ " and programme_code='"+programmeCode+"'";
	        	//System.out.println("query is "+sqlQuery);
	        	connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	        	
	        	if(connMgr.rs.next())
	        	{
	        		totalExpenditure=connMgr.rs.getFloat("expTotal");
	        		totalReleases=connMgr.rs.getFloat("releasesTotal");
	        	}
	        	sqlQuery = "select CL_BAL  from RWS_MON_PROGREES_OB_BAL" 
	        		+ " where dcode='"+dcode+"' and fin_year='"+getPreviousFinancialYear(getPreviousFinancialYear(financialYear))+"' " 
					+ " and programme_code='"+programmeCode+"'";
	        	//System.out.println("query is "+sqlQuery);
	        	connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	        	
	        	if(connMgr.rs.next())
	        	{
	        		closingBalance=connMgr.rs.getFloat("cl_bal");
	        	}
	        	float closingBalanceForThePreviousYear=closingBalance+totalReleases-totalExpenditure;
	        	
	        		
	        		sqlQuery= " insert into RWS_MON_PROGREES_OB_BAL(" 
	        			+ " DCODE,PROGRAMME_CODE,FIN_YEAR,CL_BAL) values('" 
						+dcode+"','"+programmeCode+"','"+getPreviousFinancialYear(financialYear)+"','"+closingBalanceForThePreviousYear+"')";
	        	//System.out.println("query is "+sqlQuery);
	        	int rcount=connMgr.stmt.executeUpdate(sqlQuery);
	        	
	        	if(rcount<1)
	        	{
	        		daoMessage.setMessage("Closing balance for the previous year is not updated");
	        		daoMessage.setOperationSussess(false);
	        	}
	        	
	        	if(daoMessage.isOperationSussess())
	        	{
	        		daoMessage.setMessage("Closing balance for the previous\\n year updated");
	        		
	        		conn.commit();
	        		conn.setAutoCommit(true);
	        	}
			}catch(Exception e)
			{
				//System.out.println("Exception in insertClosingBalanceForPreviousYear is "+e);
				daoMessage.setOperationSussess(false);
				daoMessage.setMessage("Cannot update closing balance for the previous year");
			}
			 finally{connMgr.closeAll();}
			 return daoMessage;
		}
	 
	 
	 public DAOMessage insertClosingBalanceForPreviousYear(String dcode,String financialYear,String programmeCode,String planNonPlan,String catagory)throws Exception
		{

		 	ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        String message=null;
	        float totalExpenditure=0;
	        float totalReleases=0;
	        float closingBalance=0;
	        DAOMessage daoMessage=new DAOMessage();
	        daoMessage.setOperationSussess(true);
	        try
			{
	        	conn=connMgr.getConnection();
	        	conn.setAutoCommit(false);
	        	connMgr.stmt=conn.createStatement();
	        	String sqlQuery = "select sum(RELEASES_DUR_MON)as expTotal,sum(EXPENDITURE_DUR_THE_MONTH)releasesTotal  from RWS_MON_FIN_PHY_PROGRESS_TBL" 
	        		+ " where dcode='"+dcode+"' and fin_year='"+getPreviousFinancialYear(financialYear)+"' " 
					+ " and programme_code='"+programmeCode+"'" 
					+ " and PLAN_NONPLAN ='"+planNonPlan+"' and NORMAL_OTHERS ='"+catagory+"'";
	        	//System.out.println("query is "+sqlQuery);
	        	connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	        	
	        	if(connMgr.rs.next())
	        	{
	        		totalExpenditure=connMgr.rs.getFloat("expTotal");
	        		totalReleases=connMgr.rs.getFloat("releasesTotal");
	        	}
	        	sqlQuery = "select CL_BAL  from RWS_MON_PROGREES_OB_BAL" 
	        		+ " where dcode='"+dcode+"' and fin_year='"+getPreviousFinancialYear(getPreviousFinancialYear(financialYear))+"' " 
					+ " and programme_code='"+programmeCode+"'";
	        	//System.out.println("query is "+sqlQuery);
	        	connMgr.rs=connMgr.stmt.executeQuery(sqlQuery);
	        	
	        	if(connMgr.rs.next())
	        	{
	        		closingBalance=connMgr.rs.getFloat("cl_bal");
	        	}
	        	float closingBalanceForThePreviousYear=closingBalance+totalReleases-totalExpenditure;
	        	
	        		
	        		sqlQuery= " insert into RWS_MON_PROGREES_OB_BAL(" 
	        			+ " DCODE,PROGRAMME_CODE,FIN_YEAR,CL_BAL) values('" 
						+dcode+"','"+programmeCode+"','"+getPreviousFinancialYear(financialYear)+"','"+closingBalanceForThePreviousYear+"')";
	        	//System.out.println("query is "+sqlQuery);
	        	int rcount=connMgr.stmt.executeUpdate(sqlQuery);
	        	
	        	if(rcount<1)
	        	{
	        		daoMessage.setMessage("Closing balance for the previous year is not updated");
	        		daoMessage.setOperationSussess(false);
	        	}
	        	
	        	if(daoMessage.isOperationSussess())
	        	{
	        		daoMessage.setMessage("Closing balance for the previous\\n year updated");
	        		
	        		conn.commit();
	        		conn.setAutoCommit(true);
	        	}
			}catch(Exception e)
			{
				//System.out.println("Exception in insertClosingBalanceForPreviousYear is "+e);
				daoMessage.setOperationSussess(false);
				daoMessage.setMessage("Cannot update closing balance for the previous year");
			}
			 finally{connMgr.closeAll();}
			 return daoMessage;
		}
	 String getPreviousFinancialYear(String financialYear)
	 {
	 	return (Integer.parseInt(financialYear.substring(0,4))-1)+"-"+financialYear.substring(0,4);
	 }
	 
	 public ArrayList getCatagoryList(String planNonPlan)
		{
			ArrayList catagoryList = new ArrayList();
			LabelValueBean labelValueBean=null;
			try
			{
				
					if(planNonPlan.equals("PLAN"))
					{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NORMAL");
						labelValueBean.setLabel("Normal");
						catagoryList.add(labelValueBean);
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PROJECTS");
						labelValueBean.setLabel("Projects");
						catagoryList.add(labelValueBean);
						//labelValueBean = new LabelValueBean();
						//labelValueBean.setValue("OTHERS");
						//labelValueBean.setLabel("Other Programmes");
					}
					else if(planNonPlan.equals("NONPLAN"))
					{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NATURAL CALAMITIES");
						labelValueBean.setLabel("Natural Calamities");
						catagoryList.add(labelValueBean);
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("OPERN_MAINTENANCE");
						labelValueBean.setLabel("Operation And Maintenance");
						catagoryList.add(labelValueBean);
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("SC_HOST_RES_INST");
						labelValueBean.setLabel("Schools Hostels And Res Institutions");
						catagoryList.add(labelValueBean);
					}
				
			}
			catch(Exception e)
			{
				//System.out.println("Exception in getCatagoryList is "+e);
			}
			finally
			{	
				
			}
			return catagoryList;
		}
	 
	 public ArrayList getInitialList(String dcode,String divcode,String financialYear,String month)
		{
			
	 		ArrayList progressReportEntries=new ArrayList();
			Rws_progressReport_bean progressBean=new Rws_progressReport_bean();
			String expUptoTheMonth="";
			String releasesUptoTheMonth="";
			String openingBalance="";
			String programmeCode="";
			String planNonPlan="";
			String catagory="";
			
			programmeCode="19";
			planNonPlan="PLAN";
			catagory="NORMAL";
			
			progressBean.setProgrammeCode(programmeCode);
			progressBean.setPlanNonPlan(planNonPlan);
			progressBean.setCatagory(catagory);
			progressBean.setCatagoryList(getCatagoryList(planNonPlan));
			
			expUptoTheMonth=getExpUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			releasesUptoTheMonth=getReleasesUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			openingBalance=getCalculatedOpeningBalance(dcode,divcode,financialYear,programmeCode,planNonPlan,catagory);
			
			progressBean.setUptoTheMonth(expUptoTheMonth);
			progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
			progressBean.setOpeningBalance(openingBalance);
			
			progressReportEntries.add(progressBean);
			
			progressBean=new Rws_progressReport_bean();
			
			programmeCode="05";
			progressBean.setProgrammeCode(programmeCode);
			progressBean.setPlanNonPlan(planNonPlan);
			progressBean.setCatagory(catagory);
			progressBean.setCatagoryList(getCatagoryList(planNonPlan));

			expUptoTheMonth=getExpUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			releasesUptoTheMonth=getReleasesUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			openingBalance=getCalculatedOpeningBalance(dcode,divcode,financialYear,programmeCode,planNonPlan,catagory);
			
			
			progressBean.setUptoTheMonth(expUptoTheMonth);
			progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
			progressBean.setOpeningBalance(openingBalance);
			
			progressReportEntries.add(progressBean);
			
			progressBean=new Rws_progressReport_bean();
			programmeCode="03";
			progressBean.setProgrammeCode(programmeCode);
			progressBean.setPlanNonPlan(planNonPlan);
			progressBean.setCatagory(catagory);
			progressBean.setCatagoryList(getCatagoryList(planNonPlan));

			expUptoTheMonth=getExpUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			releasesUptoTheMonth=getReleasesUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			openingBalance=getCalculatedOpeningBalance(dcode,divcode,financialYear,programmeCode,planNonPlan,catagory);
			
			progressBean.setUptoTheMonth(expUptoTheMonth);
			progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
			progressBean.setOpeningBalance(openingBalance);
			
			progressReportEntries.add(progressBean);
			
			//PROJECTS
			catagory="PROJECTS";
			programmeCode="18";
			progressBean=new Rws_progressReport_bean();
			progressBean.setProgrammeCode(programmeCode);
			progressBean.setPlanNonPlan(planNonPlan);
			progressBean.setCatagoryList(getCatagoryList(planNonPlan));
			progressBean.setCatagory(catagory);

			expUptoTheMonth=getExpUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			releasesUptoTheMonth=getReleasesUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			
			openingBalance=getCalculatedOpeningBalance(dcode,divcode,financialYear,programmeCode,planNonPlan,catagory);
			
			progressBean.setUptoTheMonth(expUptoTheMonth);
			progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
			progressBean.setOpeningBalance(openingBalance);
			
			progressReportEntries.add(progressBean);
			
			programmeCode="11";
			progressBean=new Rws_progressReport_bean();
			progressBean.setProgrammeCode(programmeCode);
			progressBean.setPlanNonPlan(planNonPlan);
			progressBean.setCatagoryList(getCatagoryList(planNonPlan));
			progressBean.setCatagory(catagory);

			expUptoTheMonth=getExpUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			releasesUptoTheMonth=getReleasesUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			openingBalance=getCalculatedOpeningBalance(dcode,divcode,financialYear,programmeCode,planNonPlan,catagory);
			
			progressBean.setUptoTheMonth(expUptoTheMonth);
			progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
			progressBean.setOpeningBalance(openingBalance);
			
			progressReportEntries.add(progressBean);
			
			programmeCode="04";
			progressBean=new Rws_progressReport_bean();
			progressBean.setProgrammeCode(programmeCode);
			progressBean.setPlanNonPlan(planNonPlan);
			progressBean.setCatagoryList(getCatagoryList(planNonPlan));
			progressBean.setCatagory(catagory);

			expUptoTheMonth=getExpUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			releasesUptoTheMonth=getReleasesUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			openingBalance=getCalculatedOpeningBalance(dcode,divcode,financialYear,programmeCode,planNonPlan,catagory);
			
			progressBean.setUptoTheMonth(expUptoTheMonth);
			progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
			progressBean.setOpeningBalance(openingBalance);
			
			
			programmeCode="22";
			progressBean=new Rws_progressReport_bean();
			progressBean.setProgrammeCode(programmeCode);
			progressBean.setPlanNonPlan(planNonPlan);
			progressBean.setCatagoryList(getCatagoryList(planNonPlan));
			progressBean.setCatagory(catagory);

			expUptoTheMonth=getExpUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			releasesUptoTheMonth=getReleasesUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			openingBalance=getCalculatedOpeningBalance(dcode,divcode,financialYear,programmeCode,planNonPlan,catagory);
			
			progressBean.setUptoTheMonth(expUptoTheMonth);
			progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
			progressBean.setOpeningBalance(openingBalance);
			
			progressReportEntries.add(progressBean);
			
			programmeCode="09";
			progressBean=new Rws_progressReport_bean();
			progressBean.setProgrammeCode(programmeCode);
			progressBean.setPlanNonPlan(planNonPlan);
			progressBean.setCatagoryList(getCatagoryList(planNonPlan));
			progressBean.setCatagory(catagory);

			expUptoTheMonth=getExpUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			releasesUptoTheMonth=getReleasesUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			openingBalance=getCalculatedOpeningBalance(dcode,divcode,financialYear,programmeCode,planNonPlan,catagory);
			
			progressBean.setUptoTheMonth(expUptoTheMonth);
			progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
			progressBean.setOpeningBalance(openingBalance);
			
			progressReportEntries.add(progressBean);
			
			planNonPlan="NONPLAN";
			catagory="NATURAL CALAMITIES";
			programmeCode="21";
			progressBean=new Rws_progressReport_bean();
			progressBean.setProgrammeCode(programmeCode);
			progressBean.setPlanNonPlan(planNonPlan);
			progressBean.setCatagoryList(getCatagoryList(planNonPlan));
			progressBean.setCatagory(catagory);

			expUptoTheMonth=getExpUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			releasesUptoTheMonth=getReleasesUptoTheMonth(dcode,divcode,programmeCode,financialYear,month,planNonPlan,catagory);
			openingBalance=getCalculatedOpeningBalance(dcode,divcode,financialYear,programmeCode,planNonPlan,catagory);
			
			progressBean.setUptoTheMonth(expUptoTheMonth);
			progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
			progressBean.setOpeningBalance(openingBalance);
			
			progressReportEntries.add(progressBean);
			
			return progressReportEntries;
			
			
		}
	 public ArrayList getFinancialYearsBetween(String fromYear,String toYear)
	 {
//	 	this function gets the financialYears between two financialYears Inclusive of start and end years
		//System.out.println("fromYear is "+fromYear);
	 	//System.out.println("toYear is "+toYear);
	 	ArrayList financialYearsList=new ArrayList();
	 	int startYearInFromYear=Integer.parseInt(fromYear.substring(0,4));
	 	int endYearInFromYear=Integer.parseInt(fromYear.substring(5,9));
	 	
	 	int startYearInToYear=Integer.parseInt(toYear.substring(0,4));
	 	int endYearInToYear=Integer.parseInt(toYear.substring(5,9));
	 	LabelValueBean labelValueBean=null;
	 	//System.out.println("start year is "+startYearInFromYear+" and end year is "+endYearInToYear);
	 	//System.out.println("difference is "+(endYearInToYear-startYearInFromYear));
	 	for(int i=0;i<endYearInToYear-startYearInFromYear;i++)
	 	{
	 		//financialYearsList.add((startYearInFinancialYearStart+i)+"-"+(startYearInFinancialYearStart+i+1));
	 		labelValueBean = new LabelValueBean();
			labelValueBean.setValue((startYearInFromYear+i)+"-"+(startYearInFromYear+i+1));
			labelValueBean.setLabel((startYearInFromYear+i)+"-"+(startYearInFromYear+i+1));
			financialYearsList.add(labelValueBean);
	 	}
	 	return financialYearsList;
	 }
}
