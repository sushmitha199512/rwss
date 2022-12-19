package nic.watersoft.scheduler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.works.WorksData1;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class ScheduleJob_Tot_Transactions implements Job {
	
	public void customExcecute(){
		Statement stmt = null;
	    Connection conn = null;
	    ResultSet rs = null;                
	    try
	    {
	    	 conn = RwsOffices.getConn();
	    	 WorksData1 data1 = new WorksData1();
	    	 int cyear = Calendar.getInstance().get(Calendar.YEAR);
	    	 int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
	    	 int lMonth = Calendar.getInstance().get(Calendar.MONTH);
	    	// int day = Calendar.getInstance().get(Calendar.DATE);
	    	 String currentMonth = data1.getCurrentMonth(month);
	    	 String lastMonth = "";
	    	 if (currentMonth.equals("JAN")) {
	    	 	lastMonth = "DEC-" + (cyear - 1);
	    	 } else {
	    	 	lastMonth = data1.getCurrentMonth(lMonth) + "-" + cyear;
	    	 }
	    	/* String cDate = day + "-" + currentMonth + "-" + cyear;
	    	 int yearStart = 0;
	    	 int yearEnd = 0;
	    	 if (month <= 3) {
	    	 	yearStart = cyear - 1;
	    	 	yearEnd = cyear;
	    	 } else {
	    	 	yearStart = cyear;
	    	 	yearEnd = cyear + 1;
	    	 }*/
	    	 lastMonth = lastMonth.toUpperCase() ;
	    	 currentMonth = currentMonth.toUpperCase();
	    	 String currentMonYear=currentMonth.toUpperCase()+ "-" + cyear;
	    	 /* =========HABITATIONS============= */    			
	     	int totalHabs=0,curMonthHabs=0,prevMonthHabs=0;    
	     	String habQry="select nvl(sum(case when to_char(Update_Date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthHabs,nvl(sum(case when to_char(Update_Date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthHabs ,count(*) as totalHabs from Rws_Complete_Hab_Dyna_View a,Rws_Habitation_Dir_Dyna_Tbl b where A.Panch_Code=B.Hab_Code ";
	     		//	System.out.println("\n"+habQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(habQry);
	 	  	if(rs.next()){
	 	  		totalHabs=rs.getInt("totalHabs");
	 	  		curMonthHabs=rs.getInt("curMonthHabs");
	 	  		prevMonthHabs=rs.getInt("prevMonthHabs");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String habInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Habitations','HabDetails',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		PreparedStatement ps=conn.prepareStatement(habInsertQry);
	 		ps.setInt(1, curMonthHabs);
	 		ps.setInt(2,prevMonthHabs);
	 		ps.setInt(3,totalHabs);
	 		int s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("HabDetails inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* =========HABITATIONS Supply============= */    			
	     	int totalHabSuply=0,curMonthHabSuply=0,prevMonthHabSuply=0;    
	     	String habSuplyQry="select nvl(sum(case when to_char(Update_Date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthHabSuply,nvl(sum(case when to_char(Update_Date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthHabSuply ,count(*) as totalHabSuply from Rws_Complete_Hab_Dyna_View a,Rws_Hab_Supply_Status_Tbl b where A.Panch_Code=B.Hab_Code ";
	     			//System.out.println("\n"+habSuplyQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(habSuplyQry);
	 	  	if(rs.next()){
	 	  		totalHabSuply=rs.getInt("totalHabSuply");
	 	  		curMonthHabSuply=rs.getInt("curMonthHabSuply");
	 	  		prevMonthHabSuply=rs.getInt("prevMonthHabSuply");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String habSuplyInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Habitations','Habitation Supply',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(habSuplyInsertQry);
	 		ps.setInt(1,curMonthHabSuply);
	 		ps.setInt(2,prevMonthHabSuply);
	 		ps.setInt(3,totalHabSuply);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("HabSupplyDetails inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========ASSETS============ */
	 		int totalAssets=0,curMonthAssets=0,prevMonthAssets=0;    
	     	String assetQry="select nvl(sum(case when to_char(Update_Date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthAssets,nvl(sum(case when to_char(Update_Date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthAssets ,count(*) as totalAssets from Rws_Asset_Mast_Tbl a,Rws_District_Tbl b where substr(A.Asset_Code,5,2)=B.dcode ";
	     			//System.out.println("\n"+assetQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(assetQry);
	 	  	if(rs.next()){
	 	  		totalAssets=rs.getInt("totalAssets");
	 	  		curMonthAssets=rs.getInt("curMonthAssets");
	 	  		prevMonthAssets=rs.getInt("prevMonthAssets");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String assetsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Assets','Assets',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(assetsInsertQry);
	 		ps.setInt(1, curMonthAssets);
	 		ps.setInt(2,prevMonthAssets);
	 		 ps.setInt(3,totalAssets);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("AssetDetails inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========ASSET IMAGES============ */
	 		int totalAstImgs=0,curMonthAstImgs=0,prevMonthAstImgs=0;    
	     	String assetImgQry="select nvl(sum(case when to_char(c.Update_Date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthAstImgs,nvl(sum(case when to_char(c.Update_Date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthAstImgs ,count(*) as totalAstImgs from Rws_Asset_Mast_Tbl a,Rws_District_Tbl b,Rws_Asset_Image_Tbl c where substr(A.Asset_Code,5,2)=B.dcode and A.Asset_Code=C.Asset_Code";
	     			//System.out.println("\n"+assetQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(assetImgQry);
	 	  	if(rs.next()){
	 	  		totalAstImgs=rs.getInt("totalAstImgs");
	 	  		curMonthAstImgs=rs.getInt("curMonthAstImgs");
	 	  		prevMonthAstImgs=rs.getInt("prevMonthAstImgs");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String AstImgsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Assets','Images Captured',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(AstImgsInsertQry);
	 		ps.setInt(1, curMonthAstImgs);
	 		ps.setInt(2,prevMonthAstImgs);
	 		ps.setInt(3,totalAstImgs);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Asset Image Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========COMPONENTS============ */
	 				/* ===========Sources============ */
	 		int totalSources=0,curMonthSources=0,prevMonthSources=0;    
	 		String SourceQry="select nvl(sum(case when to_char(c.Update_Date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthSources,nvl(sum(case when to_char(c.Update_Date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthSources ,count(*) as totalSources from Rws_Asset_Mast_Tbl a,Rws_District_Tbl b,Rws_Source_Tbl c where substr(A.Asset_Code,5,2)=B.dcode and A.Asset_Code=C.Asset_Code";
	     			//System.out.println("\n"+SourceQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(SourceQry);
	 	  	if(rs.next()){
	 	  		totalSources=rs.getInt("totalSources");
	 	  		curMonthSources=rs.getInt("curMonthSources");
	 	  		prevMonthSources=rs.getInt("prevMonthSources");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String SourcesInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Components','Sources',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(SourcesInsertQry);
	 		ps.setInt(1, curMonthSources);
	 		ps.setInt(2,prevMonthSources);
	 		ps.setInt(3,totalSources);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("SourceDetails inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========COMPONENT IMAGES============ */
	 		int totalCompImgs=0,curMonthCompImgs=0,prevMonthCompImgs=0;    
	     	String CompImgQry="select nvl(sum(case when to_char(c.Update_Date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthCompImgs,nvl(sum(case when to_char(c.Update_Date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthCompImgs ,count(*) as totalCompImgs from Rws_Asset_Mast_Tbl a,Rws_District_Tbl b,Rws_Asset_Component_Image_Tbl c where substr(A.Asset_Code,5,2)=B.dcode and A.Asset_Code=C.Asset_Code";
	     			//System.out.println("\n"+CompImgQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(CompImgQry);
	 	  	if(rs.next()){
	 	  		totalCompImgs=rs.getInt("totalCompImgs");
	 	  		curMonthCompImgs=rs.getInt("curMonthCompImgs");
	 	  		prevMonthCompImgs=rs.getInt("prevMonthCompImgs");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String CompImgsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Components','Images Captured',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(CompImgsInsertQry);
	 		ps.setInt(1, curMonthCompImgs);
	 		ps.setInt(2,prevMonthCompImgs);
	 		ps.setInt(3,totalCompImgs);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Component Image Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========OHSR============ */
	 		/* int totalOHSRs=0,curMonthOHSRs=0,prevMonthOHSRs=0;    
	 		String OHSRQry="select nvl(sum(case when to_char(c.Update_Date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthOHSRs,nvl(sum(case when to_char(c.Update_Date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthOHSRs ,count(*) as totalOHSRs from Rws_Asset_Mast_Tbl a,Rws_District_Tbl b,RWS_AST_OHSR_SC_PARAM_TBL c where substr(A.Asset_Code,5,2)=B.dcode and A.Asset_Code=C.Asset_Code";
	     			//System.out.println("\n"+OHSRQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(OHSRQry);
	 	  	if(rs.next()){
	 	  		totalOHSRs=rs.getInt("totalOHSRs");
	 	  		curMonthOHSRs=rs.getInt("curMonthOHSRs");
	 	  		prevMonthOHSRs=rs.getInt("prevMonthOHSRs");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String OHSRsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Components','OHSRDetails','"+curMonthOHSRs+"','"+prevMonthOHSRs+"','"+totalOHSRs+"',sysdate)";
	 		stmt=conn.createStatement();
	 		s=stmt.executeUpdate(OHSRsInsertQry);
	 		if(s==1)
	 		{
	 			System.out.println("OHSRDetails inserted successfully");
	 		}	
	 		stmt.close(); */
	 		
	 		/* ===========Works============ */
	 			/* ===========Admin Works============ */
	 		int totalWorks=0,curMonthWorks=0,prevMonthWorks=0;  
	 		String workQry="select nvl(sum(case when to_char(ADMIN_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthWorks,nvl(sum(case when to_char(ADMIN_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthWorks ,count(*) as totalWorks from RWS_WORK_ADMN_TBL where WORK_CANCEL_DT is null";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(workQry);
	 	  	if(rs.next()){
	 	  		totalWorks=rs.getInt("totalWorks");
	 	  		curMonthWorks=rs.getInt("curMonthWorks");
	 	  		prevMonthWorks=rs.getInt("prevMonthWorks");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String WorksInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Works','a.Admin Sanctioned',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(WorksInsertQry);
	 		ps.setInt(1, curMonthWorks);
	 		ps.setInt(2,prevMonthWorks);
	 		ps.setInt(3,totalWorks);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("WorkDetails inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========Technical Works============ */
	 		int totaltechWorks=0,curMonthtechWorks=0,prevMonthtechWorks=0;  
	 		String techworkQry="select nvl(sum(case when to_char(b.TS_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthtechWorks,nvl(sum(case when to_char(b.TS_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthtechWorks ,count(*) as totaltechWorks from RWS_WORK_ADMN_TBL a,Rws_New_Est_Tbl b where WORK_CANCEL_DT is null and a.work_id=b.work_id and TS_DATE is not null";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(techworkQry);
	 	  	if(rs.next()){
	 	  		totaltechWorks=rs.getInt("totaltechWorks");
	 	  		curMonthtechWorks=rs.getInt("curMonthtechWorks");
	 	  		prevMonthtechWorks=rs.getInt("prevMonthtechWorks");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String techWorksInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Works','b.Technical Sanctioned',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(techWorksInsertQry);
	 		ps.setInt(1, curMonthtechWorks);
	 		ps.setInt(2,prevMonthtechWorks);
	 		ps.setInt(2,totaltechWorks);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Work Technical Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		
	 		/* ===========Source Identification Works============ */
	 		int totalsouIdeWorks=0,curMonthsouIdeWorks=0,prevMonthsouIdeWorks=0;  
	 		String souIdeworkQry="select nvl(sum(case when to_char(b.SITE_IDENT_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthsouIdeWorks,nvl(sum(case when to_char(b.SITE_IDENT_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthsouIdeWorks ,count(*) as totalsouIdeWorks from RWS_WORK_ADMN_TBL a,Rws_Source_Iden_Fin_Tbl b where WORK_CANCEL_DT is null and a.work_id=b.work_id and SITE_IDENT_DATE is not null";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(souIdeworkQry);
	 	  	if(rs.next()){
	 	  		totalsouIdeWorks=rs.getInt("totalsouIdeWorks");
	 	  		curMonthsouIdeWorks=rs.getInt("curMonthsouIdeWorks");
	 	  		prevMonthsouIdeWorks=rs.getInt("prevMonthsouIdeWorks");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String souIdeWorksInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Works','c.Source Identification',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(souIdeWorksInsertQry);
	 		ps.setInt(1, curMonthsouIdeWorks);
	 		ps.setInt(2,prevMonthsouIdeWorks);
	 		ps.setInt(3,totalsouIdeWorks);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Work Sourece Identification Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		
	 		/* ===========Contractor Selection Works============ */
	 		int totalConSelWorks=0,curMonthConSelWorks=0,prevMonthConSelWorks=0;  
	 		String ConSelworkQry="select nvl(sum(case when to_char(b.AGREEMENT_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthConSelWorks,nvl(sum(case when to_char(b.AGREEMENT_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthConSelWorks ,count(*) as totalConSelWorks from RWS_WORK_ADMN_TBL a,Rws_Contractor_Selection_Tbl b where WORK_CANCEL_DT is null and a.work_id=b.work_id and AGREEMENT_DATE is not null";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(ConSelworkQry);
	 	  	if(rs.next()){
	 	  		totalConSelWorks=rs.getInt("totalConSelWorks");
	 	  		curMonthConSelWorks=rs.getInt("curMonthConSelWorks");
	 	  		prevMonthConSelWorks=rs.getInt("prevMonthConSelWorks");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String ConSelWorksInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Works','d.Co"
	 	  			+ "actor Selection',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(ConSelWorksInsertQry);
	 		ps.setInt(1, curMonthConSelWorks);
	 		ps.setInt(2,prevMonthConSelWorks);
	 		ps.setInt(3,totalConSelWorks);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Work Contractor Selection Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========Commenced Works============ */
	 		int totalGrouWorks=0,curMonthGrouWorks=0,prevMonthGrouWorks=0;  
	 		String GrouworkQry="select nvl(sum(case when to_char(b.GROUNDING_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthGrouWorks,nvl(sum(case when to_char(b.GROUNDING_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthGrouWorks ,count(*) as totalGrouWorks from RWS_WORK_ADMN_TBL a,Rws_Work_Commencement_Tbl b where WORK_CANCEL_DT is null and a.work_id=b.work_id and GROUNDING_DATE is not null";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(GrouworkQry);
	 	  	if(rs.next()){
	 	  		totalGrouWorks=rs.getInt("totalGrouWorks");
	 	  		curMonthGrouWorks=rs.getInt("curMonthGrouWorks");
	 	  		prevMonthGrouWorks=rs.getInt("prevMonthGrouWorks");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String GrouWorksInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Works','e.Grounded' ,?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(GrouWorksInsertQry);
	 		ps.setInt(1, curMonthGrouWorks);
	 		ps.setInt(2,prevMonthGrouWorks);
	 		ps.setInt(3,totalGrouWorks);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Work Grounding Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========Completed Works============ */
	 		int totalCompWorks=0,curMonthCompWorks=0,prevMonthCompWorks=0;  
	 		String CompworkQry="select nvl(sum(case when to_char(b.DATE_OF_COMPLETION,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthCompWorks,nvl(sum(case when to_char(b.DATE_OF_COMPLETION,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthCompWorks ,count(*) as totalCompWorks from RWS_WORK_ADMN_TBL a,Rws_Work_Completion_Tbl b where WORK_CANCEL_DT is null and a.work_id=b.work_id and DATE_OF_COMPLETION is not null";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(CompworkQry);
	 	  	if(rs.next()){
	 	  		totalCompWorks=rs.getInt("totalCompWorks");
	 	  		curMonthCompWorks=rs.getInt("curMonthCompWorks");
	 	  		prevMonthCompWorks=rs.getInt("prevMonthCompWorks");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String CompWorksInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Works','f.Completed',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(CompWorksInsertQry);
	 		ps.setInt(1, curMonthCompWorks);
	 		ps.setInt(2,prevMonthCompWorks);
	 		ps.setInt(3,totalCompWorks);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Work Completed Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========Financial Completed Works============ */
	 		int totalFinCompWorks=0,curMonthFinCompWorks=0,prevMonthFinCompWorks=0;  
	 		String FinCompworkQry="select nvl(sum(case when to_char(b.DT_FIN_COMPLETION,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthFinCompWorks,nvl(sum(case when to_char(b.DT_FIN_COMPLETION,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthFinCompWorks ,count(*) as totalFinCompWorks from RWS_WORK_ADMN_TBL a,Rws_Work_Completion_Tbl b where WORK_CANCEL_DT is null and a.work_id=b.work_id and DT_FIN_COMPLETION is not null";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(FinCompworkQry);
	 	  	if(rs.next()){
	 	  		totalFinCompWorks=rs.getInt("totalFinCompWorks");
	 	  		curMonthFinCompWorks=rs.getInt("curMonthFinCompWorks");
	 	  		prevMonthFinCompWorks=rs.getInt("prevMonthFinCompWorks");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String FinCompWorksInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Works','g.Financially Completed',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(FinCompWorksInsertQry);
	 		ps.setInt(1, curMonthFinCompWorks);
	 		ps.setInt(2,prevMonthFinCompWorks);
	 		ps.setInt(3, totalFinCompWorks);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Work Financially Completed Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========Commissioned Works============ */
	 		int totalCommWorks=0,curMonthCommWorks=0,prevMonthCommWorks=0;  
	 		String CommworkQry="select nvl(sum(case when to_char(b.DATE_OF_COMM,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthCommWorks,nvl(sum(case when to_char(b.DATE_OF_COMM,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthCommWorks ,count(*) as totalCommWorks from RWS_WORK_ADMN_TBL a,Rws_Work_Completion_Tbl b where WORK_CANCEL_DT is null and a.work_id=b.work_id and DATE_OF_COMM is not null";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(CommworkQry);
	 	  	if(rs.next()){
	 	  		totalCommWorks=rs.getInt("totalCommWorks");
	 	  		curMonthCommWorks=rs.getInt("curMonthCommWorks");
	 	  		prevMonthCommWorks=rs.getInt("prevMonthCommWorks");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String CommWorksInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Works','h.Commissioned',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(CommWorksInsertQry);
	 		ps.setInt(1, curMonthCommWorks);
	 		ps.setInt(2,prevMonthCommWorks);
	 		ps.setInt(3, totalCommWorks);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Work Commissioned Completed Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========FUND============ */
	 		double totalFund=0,curMonthFund=0,prevMonthFund=0;
	 		double totalBank=0,curMonthBank=0,prevMonthBank=0;  
	 		double totalPao=0,curMonthPao=0,prevMonthPao=0;  
	 		String bankQry="select nvl(sum(case when to_char(BANK_SEND_DATE,'MON-YYYY')='"+currentMonYear+"' then BILL_AMOUNT_CENTRAL else 0 end),0) as curMonthBank,nvl(sum(case when to_char(BANK_SEND_DATE,'MON-YYYY')='"+lastMonth+"' then BILL_AMOUNT_CENTRAL else 0 end),0) as prevMonthBank ,nvl(sum(BILL_AMOUNT_CENTRAL),0) as totalBank from Rws_Bill_Bank_Bridge_Det_Tbl a,Rws_Work_Admn_Tbl b where A.work_id=B.Work_Id ";
	     	//System.out.println("\n"+bankQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(bankQry);
	 	  	if(rs.next()){
	 	  		totalBank=rs.getDouble("totalBank");
	 	  		curMonthBank=rs.getDouble("curMonthBank");
	 	  		prevMonthBank=rs.getDouble("prevMonthBank");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String paoQry="select nvl(sum(case when to_char(STATE_SEND_DATE,'MON-YYYY')='"+currentMonYear+"' then BILL_AMOUT_STATE else 0 end),0) as curMonthPao,nvl(sum(case when to_char(STATE_SEND_DATE,'MON-YYYY')='"+lastMonth+"' then BILL_AMOUT_STATE else 0 end),0) as prevMonthPao ,nvl(sum(BILL_AMOUT_STATE),0) as totalPao from Rws_Bill_Pao_Bridge_Det_Tbl a,Rws_Work_Admn_Tbl b where A.work_id=B.Work_Id ";
	 		//System.out.println("\n"+paoQry);	  	
	 		stmt=conn.createStatement();
	 		rs=stmt.executeQuery(paoQry);
	 		if(rs.next()){
	 			totalPao=rs.getDouble("totalPao");
	 			curMonthPao=rs.getDouble("curMonthPao");
	 			prevMonthPao=rs.getDouble("prevMonthPao");
	 		}
	 		rs.close();
	 		stmt.close();
	 		totalFund=totalBank+totalPao;
	 		curMonthFund=curMonthBank+curMonthPao;
	 		prevMonthFund=prevMonthBank+prevMonthPao;			
	 	  	String fundInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Funds','Fund Releases',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(fundInsertQry);
	 		ps.setDouble(1, curMonthFund);
	 		ps.setDouble(2,prevMonthFund);
	 		ps.setDouble(3, totalFund);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("FundDetails inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* =========WATER QUALITY============= */    			
	     	int totalWqPhy=0,curMonthWqPhy=0,prevMonthWqPhy=0;    
	     	String WqPhyQry="select nvl(sum(case when to_char(PREPARED_ON,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthWqPhy,nvl(sum(case when to_char(PREPARED_ON,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthWqPhy ,count(*) as totalWqPhy from RWS_WQ_TEST_RESULTS_TBL where TEST_CODE=1";
	     			//System.out.println("\n"+WqPhyQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(WqPhyQry);
	 	  	if(rs.next()){
	 	  		totalWqPhy=rs.getInt("totalWqPhy");
	 	  		curMonthWqPhy=rs.getInt("curMonthWqPhy");
	 	  		prevMonthWqPhy=rs.getInt("prevMonthWqPhy");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String WqPhyInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('WaterQuality','a.Physico Chemical Test',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(WqPhyInsertQry);
	 		ps.setInt(1, curMonthWqPhy);
	 		ps.setInt(2, prevMonthWqPhy);
	 		ps.setInt(3, totalWqPhy);
	 	    s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Physico chemical Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		int totalWqBact=0,curMonthWqBact=0,prevMonthWqBact=0;    
	 		String WqBactQry="select nvl(sum(case when to_char(PREPARED_ON,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthWqBact,nvl(sum(case when to_char(PREPARED_ON,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthWqBact ,count(*) as totalWqBact from RWS_WQ_TEST_RESULTS_TBL where TEST_CODE=2";
	 		//System.out.println("\n"+WqBactQry);	  	
	 		stmt=conn.createStatement();
	 		rs=stmt.executeQuery(WqBactQry);
	 		if(rs.next()){
	 			totalWqBact=rs.getInt("totalWqBact");
	 			curMonthWqBact=rs.getInt("curMonthWqBact");
	 			prevMonthWqBact=rs.getInt("prevMonthWqBact");
	 		}
	 		rs.close();
	 		stmt.close();
	 		String WqBacInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('WaterQuality','b.Bacteriological Test',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(WqBacInsertQry);
	 		ps.setInt(1,curMonthWqBact);
	 		ps.setInt(2,prevMonthWqBact);
	 		ps.setInt(3,totalWqBact);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Bacteriological TestDetails inserted successfully");
	 		}*/	
	 		stmt.close();  
	 		int totalWqftk=0,curMonthWqftk=0,prevMonthWqftk=0;    
	 		String WqftkQry="select nvl(sum(case when to_char(TEST_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthWqftk,nvl(sum(case when to_char(TEST_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthWqftk ,count(*) as totalWqftk from Rws_Ftk_Testing_Tbl";
	 		//System.out.println("\n"+WqftkQry);	  	
	 		stmt=conn.createStatement();
	 		rs=stmt.executeQuery(WqftkQry);
	 		if(rs.next()){
	 			totalWqftk=rs.getInt("totalWqftk");
	 			curMonthWqftk=rs.getInt("curMonthWqftk");
	 			prevMonthWqftk=rs.getInt("prevMonthWqftk");
	 		}
	 		rs.close();
	 		stmt.close();
	 		String WqFtkInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('WaterQuality','c.FTK Test',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(WqFtkInsertQry);
	 		ps.setInt(1, curMonthWqftk);
	 		ps.setInt(2,prevMonthWqftk);
	 		ps.setInt(3,totalWqftk);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("FTK test inserted successfully");
	 		}	*/
	 		stmt.close();
	 		/* ===========Schools============ */
	 		int totalSchools=0,curMonthSchools=0,prevMonthSchools=0;  
	 		String SchQry="select nvl(sum(case when to_char(Update_Date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthSchools,nvl(sum(case when to_char(Update_Date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthSchools ,count(*) as totalSchools from Rws_School_Master_Tbl a,Rws_Complete_Hab_View b where a.hab_code=b.panch_code";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(SchQry);
	 	  	if(rs.next()){
	 	  		totalSchools=rs.getInt("totalSchools");
	 	  		curMonthSchools=rs.getInt("curMonthSchools");
	 	  		prevMonthSchools=rs.getInt("prevMonthSchools");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String SchoolsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Schools','Schools',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(SchoolsInsertQry);
	 		ps.setInt(1,curMonthSchools);
	 		ps.setInt(2,prevMonthSchools);
	 		ps.setString(3,SchoolsInsertQry);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("School Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========Drought============ */
	 		int totalDrghtHab=0,curMonthDrghtHab=0,prevMonthDrghtHab=0;  
	 		String DrouHabQry="select nvl(sum(case when to_date('"+currentMonYear+"','MON-YYYY') between Frm_Date and To_Date then 1 else 0 end),0) as curMonthDrghtHab,nvl(sum(case when to_date('"+lastMonth+"','MON-YYYY') between Frm_Date and To_Date then 1 else 0 end),0) as prevMonthDrghtHab ,count(*) as totalDrghtHab from Rws_Drought_Habitation_Tbl a,Rws_Complete_Hab_View b where a.habcode=b.panch_code";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(DrouHabQry);
	 	  	if(rs.next()){
	 	  		totalDrghtHab=rs.getInt("totalDrghtHab");
	 	  		curMonthDrghtHab=rs.getInt("curMonthDrghtHab");
	 	  		prevMonthDrghtHab=rs.getInt("prevMonthDrghtHab");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String DrghtHabInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Drought','Drought Habitations',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(DrghtHabInsertQry);
	 		ps.setInt(1,curMonthDrghtHab);
	 		ps.setInt(2,prevMonthDrghtHab);
	 		ps.setInt(3,totalDrghtHab);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Drought Habs Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========Grievance============ */
	 		int totalGrievance=0,curMonthGrievance=0,prevMonthGrievance=0;  
	 		String GrievanceQry="select nvl(sum(case when to_char(COMPLAINT_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthGrievance,nvl(sum(case when to_char(COMPLAINT_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthGrievance ,count(*) as totalGrievance from Rws_Generic_Complaints_Reg_Tbl";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(GrievanceQry);
	 	  	if(rs.next()){
	 	  		totalGrievance=rs.getInt("totalGrievance");
	 	  		curMonthGrievance=rs.getInt("curMonthGrievance");
	 	  		prevMonthGrievance=rs.getInt("prevMonthGrievance");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String GrievanceInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Grievance','Grievance Monitoring',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(GrievanceInsertQry);
	 		ps.setInt(1,curMonthGrievance);
	 		ps.setInt(2,prevMonthGrievance);
	 		ps.setInt(3,totalGrievance);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Grievance Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========SMS============ */
	 			/* ===========SMS Push============ */
	 		int totalSmsPush=0,curMonthSmsPush=0,prevMonthSmsPush=0;  
	 		String SmsPushQry="select nvl(sum(case when to_char(SMS_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthSmsPush,nvl(sum(case when to_char(SMS_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthSmsPush ,count(*) as totalSmsPush from RWS_SMS_IN_OUT_STATUS_TBL";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(SmsPushQry);
	 	  	if(rs.next()){
	 	  		totalSmsPush=rs.getInt("totalSmsPush");
	 	  		curMonthSmsPush=rs.getInt("curMonthSmsPush");
	 	  		prevMonthSmsPush=rs.getInt("prevMonthSmsPush");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String SmsPushInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('SMS','a.PUSH',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(SmsPushInsertQry);
	 		ps.setInt(1, curMonthSmsPush);
	 		ps.setInt(2, prevMonthSmsPush);
	 		ps.setInt(3, totalSmsPush);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Sms  Push Details inserted successfully");
	 		}	*/
	 		stmt.close();
	 		/* ===========SMS Pull============ */
	 		int totalSmsPull=0,curMonthSmsPull=0,prevMonthSmsPull=0;  
	 		String SmsPullQry="select nvl(sum(case when to_char(SMS_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthSmsPull,nvl(sum(case when to_char(SMS_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthSmsPull ,count(*) as totalSmsPull from RWS_SCHEME_STATUS_SMS_TBL "
			  				+ " union "
			 				+ " select nvl(sum(case when to_char(TEST_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthSmsPull,nvl(sum(case when to_char(TEST_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthSmsPull ,count(*) as totalSmsPull from RWS_RESIDUAL_CHLORINE_SMS_TBL "
			 				+ " union "
			 				+ " select nvl(sum(case when to_char(TEST_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthSmsPull,nvl(sum(case when to_char(TEST_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthSmsPull ,count(*) as totalSmsPull from RWS_OHSR_GLSR_SMS_TBL "
			 				+ " union "
			 				+ " select nvl(sum(case when to_char(SEND_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthSmsPull,nvl(sum(case when to_char(SEND_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthSmsPull ,count(*) as totalSmsPull from RWS_DROUGHT_TANKER_SMS_TBL ";
				//System.out.println("\n"+SmsPullQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(SmsPullQry);
	 	  	while(rs.next()){
	 	  		totalSmsPull+=rs.getInt("totalSmsPull");
	 	  		curMonthSmsPull+=rs.getInt("curMonthSmsPull");
	 	  		prevMonthSmsPull+=rs.getInt("prevMonthSmsPull");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String SmsPullInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('SMS','b.PULL',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(SmsPullInsertQry);
	 		ps.setInt(1, curMonthSmsPull);
	 		ps.setInt(2,prevMonthSmsPull);
	 		ps.setInt(3, totalSmsPull);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Sms  Pull Details inserted successfully");
	 		}	*/
	 		stmt.close(); 		
	 		
	 		/* ===========NTR Sujala============ */
	 		int totalNtrSuj=0,curMonthNtrSuj=0,prevMonthNtrSuj=0;  
	 		String NtrSujQry="select nvl(sum(case when to_char(TEST_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthNtrSuj,nvl(sum(case when to_char(TEST_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthNtrSuj ,count(*) as totalNtrSuj from Rws_Ntr_Sujala_Master_Tbl";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(NtrSujQry);
	 	  	if(rs.next()){
	 	  		totalNtrSuj=rs.getInt("totalNtrSuj");
	 	  		curMonthNtrSuj=rs.getInt("curMonthNtrSuj");
	 	  		prevMonthNtrSuj=rs.getInt("prevMonthNtrSuj");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String NtrSujInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('NTR Sujala','NTR Sujala',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(NtrSujInsertQry);
	 		ps.setInt(1, curMonthNtrSuj);
	 		ps.setInt(2,prevMonthNtrSuj);
	 		ps.setInt(3, totalNtrSuj);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Sms  Push Details inserted successfully");
	 		}	*/
	 		stmt.close(); 
	 		/* ===========Pushkar============ */
	 		int totalPushkar=0,curMonthPushkar=0,prevMonthPushkar=0;  
	 		String PushkarQry="select nvl(sum(case when to_char(ADMIN_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthPushkar,nvl(sum(case when to_char(ADMIN_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthPushkar ,count(*) as totalPushkar from Rws_Pushkar_Work_Tbl";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(PushkarQry);
	 	  	if(rs.next()){
	 	  		totalPushkar=rs.getInt("totalPushkar");
	 	  		curMonthPushkar=rs.getInt("curMonthPushkar");
	 	  		prevMonthPushkar=rs.getInt("prevMonthPushkar");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String PushkarInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Pushkar','Works',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(PushkarInsertQry);
	 		ps.setInt(1,curMonthPushkar);
	 		ps.setInt(2,prevMonthPushkar);
	 		ps.setInt(3, totalPushkar);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Pushkar Work Details inserted successfully");
	 		}*/	
	 		stmt.close(); 
	 		/* ===========Pushkar Ghats============ */
	 		int totalGhat=0,curMonthGhat=0,prevMonthGhat=0;  
	 		String GhatQry="select 0 as curMonthGhat,0 as prevMonthGhat ,count(*) as totalGhat from Rws_Pushkar_Ghat_Tbl";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(GhatQry);
	 	  	if(rs.next()){
	 	  		totalGhat=rs.getInt("totalGhat");
	 	  		curMonthGhat=rs.getInt("curMonthGhat");
	 	  		prevMonthGhat=rs.getInt("prevMonthGhat");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String GhatInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Pushkar','Ghats',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(GhatInsertQry);
	 		ps.setInt(1, curMonthGhat);
	 		ps.setInt(2,prevMonthGhat);
	 		ps.setInt(3, totalGhat);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Ghat Details inserted successfully");
	 		}*/	
	 		stmt.close(); 
	 		/* ===========DPR Part A============ */
	 		int totalDPR=0,curMonthDPR=0,prevMonthDPR=0;  
	 		String DPRQry="select nvl(sum(case when to_char(UPDATEDATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthDPR,nvl(sum(case when to_char(UPDATEDATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthDPR ,count(*) as totalDPR from Rws_Notgroundworks_Status_Tbl";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(DPRQry);
	 	  	if(rs.next()){
	 	  		totalDPR=rs.getInt("totalDPR");
	 	  		curMonthDPR=rs.getInt("curMonthDPR");
	 	  		prevMonthDPR=rs.getInt("prevMonthDPR");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String DPRInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('DPR Part A','Part A Works',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(DPRInsertQry);
	 		ps.setInt(1, curMonthDPR);
	 		ps.setInt(2,prevMonthDPR);
	 		ps.setInt(3, totalDPR);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("DPR Work Details inserted successfully");
	 		}*/	
	 		stmt.close(); 
	 		/* ===========News Paper Clippings============ */
	 		int totalNewsClips=0,curMonthNewsClips=0,prevMonthNewsClips=0;  
	 		String NewsClipsQry="select nvl(sum(case when to_char(PAPER_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthNewsClips,nvl(sum(case when to_char(PAPER_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthNewsClips ,count(*) as totalNewsClips from RWS_DROUGHT_NEWSPAPER_ITEM_TBL";
	     			//System.out.println("\nNewsClipsQry :"+NewsClipsQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(NewsClipsQry);
	 	  	if(rs.next()){
	 	  		totalNewsClips=rs.getInt("totalNewsClips");
	 	  		curMonthNewsClips=rs.getInt("curMonthNewsClips");
	 	  		prevMonthNewsClips=rs.getInt("prevMonthNewsClips");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String NewsClipsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('News Paper Clippings','Clippings',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(NewsClipsInsertQry);
	 		ps.setInt(1, curMonthNewsClips);
	 		ps.setInt(2,prevMonthNewsClips);
	 		ps.setInt(3, totalNewsClips);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("News Paper Clipping Details inserted successfully");
	 		}*/
	 		stmt.close(); 
	 		/* ===========Tanker Movement============ */
	 		int totalTanker=0,curMonthTanker=0,prevMonthTanker=0;  
	 		String TankerQry="select nvl(sum(case when to_char(TANKER_TRIP_START_DATE_TIME,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthTanker,nvl(sum(case when to_char(TANKER_TRIP_START_DATE_TIME,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthTanker ,count(*) as totalTanker from RWS_TANKER_MOVEMENT_TBL";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(TankerQry);
	 	  	if(rs.next()){
	 	  		totalTanker=rs.getInt("totalTanker");
	 	  		curMonthTanker=rs.getInt("curMonthTanker");
	 	  		prevMonthTanker=rs.getInt("prevMonthTanker");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String TankerInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Tanker Movement','Trips',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(TankerInsertQry);
	 		ps.setInt(1, curMonthTanker);
	 		ps.setInt(2,prevMonthTanker);
	 		ps.setInt(3, totalTanker);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Tanker Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* added by subbu 17-10-2019 ==========start =====================================*/
	 		/* ===========Bills============ */
	 		int totalBills=0,curMonthBills=0,prevMonthBills=0;  
	 		String billsQry="select nvl(sum(case when to_char(bill_date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthBills,nvl(sum(case when to_char(bill_date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthBills,count(*) as totalBills from rws_work_bill_tbl ";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(billsQry);
	 	  	if(rs.next()){
	 	  		totalBills=rs.getInt("totalBills");
	 	  		curMonthBills=rs.getInt("curMonthBills");
	 	  		prevMonthBills=rs.getInt("prevMonthBills");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String billsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Works','i.bills',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(billsInsertQry);
	 		ps.setInt(1, curMonthBills);
	 		ps.setInt(2,prevMonthBills);
	 		ps.setInt(3, totalBills);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Tanker Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		
	 		/* ===========MOBILE APP -- SSTANK============ */
	 		int totalSSTanks=0,curMonthSSTanks=0,prevMonthSSTanks=0;  
	 		String ssTanksQry="select nvl(sum(case when to_char(update_date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthSSTanks,nvl(sum(case when to_char(update_date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthSSTanks,count(*) as totalSSTanks from RWS_DROUGHT_SSTANK_TBL";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(ssTanksQry);
	 	  	if(rs.next()){
	 	  		totalSSTanks=rs.getInt("totalSSTanks");
	 	  		curMonthSSTanks=rs.getInt("curMonthSSTanks");
	 	  		prevMonthSSTanks=rs.getInt("prevMonthSSTanks");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String ssTanksInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Mobile Apps','SS Tanks','"+curMonthSSTanks+"','"+prevMonthSSTanks+"','"+totalSSTanks+"',sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(ssTanksInsertQry);
	 		ps.setInt(1, curMonthSSTanks);
	 		ps.setInt(2,prevMonthSSTanks);
	 		ps.setInt(3, totalSSTanks);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Tanker Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		
	 		/* ===========MOBILE APP -- Water Quality============ */
	 		int totalTests=0,curMonthTests=0,prevMonthTests=0;  
	 		String testsQry="select  nvl(sum(case when to_char(test_date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthTests,nvl(sum(case when to_char(test_date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthTests,count(*) as totalTests from RWS_RESIDUAL_CHLORINE_SMS_TBL";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(testsQry);
	 	  	if(rs.next()){
	 	  		totalTests=rs.getInt("totalTests");
	 	  		curMonthTests=rs.getInt("curMonthTests");
	 	  		prevMonthTests=rs.getInt("prevMonthTests");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String testsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Mobile Apps','Water Quality RC',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(testsInsertQry);
	 		ps.setInt(1, curMonthTests);
	 		ps.setInt(2,prevMonthTests);
	 		ps.setInt(3, totalTests);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Tanker Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/* ===========MOBILE APP -- Inspection Details============ */
	 		int totalRepairs=0,curMonthRepairs=0,prevMonthRepairs=0;  
	 		String repairsQry="select nvl(sum(case when to_char(update_date,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthAssetsRepair,nvl(sum(case when to_char(update_date,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthAssetsRepair,count(*) as totalAssetsRepair from RWS_ASSET_COMPONENT_REPAIR_TBL";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(repairsQry);
	 	  	if(rs.next()){
	 	  		totalRepairs=rs.getInt("totalAssetsRepair");
	 	  		curMonthRepairs=rs.getInt("curMonthAssetsRepair");
	 	  		prevMonthRepairs=rs.getInt("prevMonthAssetsRepair");
	 	  	}
	 	  	rs.close();
	 	  	stmt.close();
	 	  	String repairsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('Mobile Apps','Inspection Details',?,?,?,sysdate)";
	 		stmt=conn.createStatement();
	 		ps=conn.prepareStatement(repairsInsertQry);
	 		ps.setInt(1, curMonthRepairs);
	 		ps.setInt(2,prevMonthRepairs);
	 		ps.setInt(3, totalRepairs);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Tanker Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		
	 		/* ===========Sujala Converted Assets============ */
	 		int totalSujalaAssets=0,curMonthSujalaAssets=0,prevMonthSujalaAssets=0;  
	 		String sujalaAssetsQry="select nvl(sum(case when to_char(SCHEME_CONVERT_DATE,'MON-YYYY')='"+currentMonYear+"' then 1 else 0 end),0) as curMonthSujalaAssets,nvl(sum(case when to_char(SCHEME_CONVERT_DATE,'MON-YYYY')='"+lastMonth+"' then 1 else 0 end),0) as prevMonthSujalaAssets,count(*) as totalSujalaAssets from RWS_NTR_SUJALA_HAB_IMPL_TBL a,RWS_AST_WTP_SC_PARAM_TBL b where a.asset_code is not null and a.scheme_convert_date is not null and a.wtpsc_code=b.wtpsc_code and a.asset_code=b.asset_code";
	     			//System.out.println("\n"+workQry);	  	
	 	  	stmt=conn.createStatement();
	 	  	rs=stmt.executeQuery(sujalaAssetsQry);
	 	  	if(rs.next()){
	 	  		totalSujalaAssets=rs.getInt("totalSujalaAssets");
	 	  		curMonthSujalaAssets=rs.getInt("curMonthSujalaAssets");
	 	  		prevMonthSujalaAssets=rs.getInt("prevMonthSujalaAssets");
	 	  	}
	 	  	rs.close();
	 	  	
	 	  	
	 	  	stmt.close();
	 	  	String sujalaAssetsInsertQry="insert into Rws_Transaction_Tbl(MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT,REPORT_DATE) values('NTR Sujala','Converted Assets',?,?,?,sysdate)";
	 	  	stmt=conn.createStatement();
	 		ps=conn.prepareStatement(sujalaAssetsInsertQry);
	 		ps.setInt(1,curMonthSujalaAssets);
	 		ps.setInt(2,prevMonthSujalaAssets);
	 		ps.setInt(3,totalSujalaAssets);
	 		s=ps.executeUpdate();
	 		/*if(s==1)
	 		{
	 			System.out.println("Tanker Details inserted successfully");
	 		}*/	
	 		stmt.close();
	 		/*=======================subbu added ended=============================*/
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
	    		if(rs!=null)
	    			rs.close();
	    	}
	    	catch(Exception e) {
	    		e.printStackTrace();
	    	}
	    }    

	
	}
	
	
	
	
    public void execute(JobExecutionContext context)
            throws JobExecutionException {
    	
    	try
        {
        	customExcecute();
        	//System.out.println("((((((*)))))))");
        } 
        catch(Exception e)
        {
        	e.printStackTrace();
        }
    }
}
