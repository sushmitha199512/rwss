
package nic.watersoft.reports;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
 

import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;


import javax.sql.DataSource;



import nic.watersoft.reports.AssetCpwsReportBean;


public class CheckListMasterData {
	static Connection conn = null;
	static Statement stmt = null;
	static Statement stmt1 = null;
	static Statement stmt2=null;
	static Statement stmt3=null;
	static Statement stmt4=null;
	static ResultSet rs = null;
	static ResultSet rs1=null;
	static ResultSet rs2=null;
	static ResultSet rs3=null;
	static ResultSet rs4=null;
	static PreparedStatement ps = null;
	static PreparedStatement ps1 = null;
	static PreparedStatement ps2 = null;
	static PreparedStatement ps3 = null;
	static PreparedStatement ps4 = null;
	static PreparedStatement ps5 = null;
	static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	public static String errorMessage;
	public static void  closeAll() throws Exception
	{
		if (rs != null) 
		{
			try 
			{
				rs.close();
			}
			catch (Exception e) 
			{
				////System.out.println("The error in CheckListMasterData"+e);
			}
			rs = null;
		}
		if (rs1 != null) 
		{
			try 
			{
				rs1.close();
			}
			catch (Exception e) 
			{
				////System.out.println("The error in CheckListMasterData"+e);
			}
			rs1 = null;
		}
		if (rs2 != null) 
		{
			try 
			{
				rs2.close();
			}
			catch (Exception e) 
			{
				////System.out.println("The error in CheckListMasterData"+e);
			}
			rs2 = null;
		}
		if (rs3 != null) 
		{
			try 
			{
				rs3.close();
			}
			catch (Exception e) 
			{
				////System.out.println("The error in CheckListMasterData"+e);
			}
			rs3 = null;
		}
		if (rs4 != null) 
		{
			try 
			{
				rs4.close();
			}
			catch (Exception e) 
			{
				////System.out.println("The error in CheckListMasterData"+e);
			}
			rs4 = null;
		}
		if (stmt != null) 
		{
			try 
			{
				stmt.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			stmt = null;
		}
		if (stmt1 != null) 
		{
			try 
			{
				stmt1.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) 
		{
			try 
			{
				stmt2.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) 
		{
			try 
			{
				stmt3.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) 
		{
			try 
			{
				stmt4.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			stmt4 = null;
		}
		
		if (ps != null) 
		{
			try 
			{
				ps.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			ps = null;
		}
		if (ps1 != null) 
		{
			try 
			{
				ps1.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			ps1 = null;
		}
		if (ps2 != null) 
		{
			try 
			{
				ps2.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			ps2 = null;
		}
		if (ps3 != null) 
		{
			try 
			{
				ps3.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			ps3 = null;
		}
		if (ps4 != null) 
		{
			try 
			{
				ps4.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			ps4 = null;
		}
		if (ps5 != null) 
		{
			try 
			{
				ps5.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			ps5 = null;
		}
		if (conn != null) 
		{
			try 
			{
				conn.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			conn = null;
		}
}
	/*Checklist details */
	
	public static ArrayList getAssetCpwsPumpingMainReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws pipeline pumping main report");
	
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsPm;
		
		try
		{
			String finalQuery="select subCompTbl.PUMPINGMAIN_CODE ,subCompTbl.HAB_CODE  ,subCompTbl.LENGTH ,subCompTbl.MET_TYPE ," +
			"subCompTbl.FAIL_FREQ ,subCompTbl.FAIL_TYPE ,subCompTbl.FAIL_REASON ," +
			"subCompTbl.AIRVALVE_NO, " +
			"subCompTbl.AIRVALVEPIT_NO,subCompTbl.SCOUREVALVE ,subCompTbl.SR_VALVEPIT_NO ,subCompTbl.REFLEXVALVE ,subCompTbl.R_VALVEPIT_NO " +
			",subCompTbl.SLUICEVALVE,subCompTbl.SL_VALVEPIT_NO,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        conn = dataSource.getConnection();
	        PreparedStatement psmt1=conn.prepareStatement(finalQuery);
		    ResultSet rs=psmt1.executeQuery();
		     
		        try{
		        	String sno="1";
	        while(rs.next())
	        {
	        	 ////System.out.println("in while loop");
	        	 Statement stmt2 = conn.createStatement();
		    	    Statement stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("PUMPINGMAIN_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("PUMPINGMAIN_CODE")+"',1,14)=substr(panch_code,1,14)");
		           
		            cpwsPm=new ArrayList();
		            cpwsPm.add(sno);
		        	try{rs3.next();
		            
		        	cpwsPm.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	cpwsPm.add("");
		            	//System.out.println("Exception"+e);
		            	}
		        	try{rs4.next();
		        	cpwsPm.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e){
		        		cpwsPm.add("");
		        		//System.out.println("exception:"+e);}
		        	
		        	


		        cpwsPm.add(formatData(rs.getString("ASSET_NAME")));	
	        	cpwsPm.add(formatData(rs.getString("PUMPINGMAIN_CODE")));
	        	cpwsPm.add(formatData(rs.getInt("LENGTH")));
	        	cpwsPm.add(formatData(rs.getString("MET_TYPE"))+"");
	        	cpwsPm.add(formatData(rs.getString("FAIL_FREQ"))+"");
	        	cpwsPm.add(formatData(rs.getString("FAIL_TYPE"))+"");
	        	cpwsPm.add(formatData(rs.getString("FAIL_REASON"))+"");
	        	cpwsPm.add(formatData(rs.getInt("AIRVALVE_NO"))+"");
	        	cpwsPm.add(formatData(rs.getInt("AIRVALVEPIT_NO"))+"");
	        	cpwsPm.add(formatData(rs.getInt("SCOUREVALVE")));
	        	cpwsPm.add(formatData(rs.getInt("SR_VALVEPIT_NO")));
	        	cpwsPm.add(formatData(rs.getInt("REFLEXVALVE")));
	        	cpwsPm.add(formatData(rs.getInt("R_VALVEPIT_NO"))+"");
	        	cpwsPm.add(formatData(rs.getInt("SLUICEVALVE"))+"");
	        	cpwsPm.add(formatData(rs.getInt("SL_VALVEPIT_NO"))+"");
	        	cpwsReport.add(cpwsPm);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData in while catch"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();		
		        conn.close();
	            
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;
	}
	public static ArrayList getAssetCpwsDistributionReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws pipeline distribution main report");
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGm;
		
		try
		{
			String finalQuery="select  subCompTbl.LENGTH ,subCompTbl.TYPE ," +
			"subCompTbl.NO_OF_STAND_POSTS ,subCompTbl.NO_OF_HOUSE_CONNECTION ,subCompTbl.NO_OF_PIPE_LINES," +
			"subCompTbl.DISTRISC_CODE,ASSET_NAME" ;
			finalQuery=finalQuery+query;
	        
		
		    conn = dataSource.getConnection();
	    	stmt = conn.createStatement();
	    	
	      
		        ////System.out.println( finalQuery);
		        ResultSet rs=stmt.executeQuery( finalQuery);
		        ////System.out.println( finalQuery);
		        try{
		        	String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("DISTRISC_CODE")+"',1,14)=substr(panch_code,1,14)");
	            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("DISTRISC_CODE")+"',1,14)=substr(panch_code,1,14)");
	           
	            cpwsGm=new ArrayList();
	            cpwsGm.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGm.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsGm.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGm.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGm.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsGm.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGm.add(formatData(rs.getString("DISTRISC_CODE")));
	        	cpwsGm.add(formatData(rs.getString("TYPE")));
	        	cpwsGm.add(formatData(rs.getFloat("LENGTH")));
	        	cpwsGm.add(formatData(rs.getInt("NO_OF_STAND_POSTS"))+"");
	        	cpwsGm.add(formatData(rs.getInt("NO_OF_HOUSE_CONNECTION"))+"");
	        	cpwsGm.add(formatData(rs.getInt("NO_OF_PIPE_LINES"))+"");
	        	cpwsReport.add( cpwsGm);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();		
		        conn.close();
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsGravityMainReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws reservoirs gravity main  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsGm;
	
	try
	{
		String finalQuery="select  subCompTbl.GRAVITYMAIN_CODE ,subCompTbl.LENGTH ,subCompTbl.MET_TYPE, " +
		"subCompTbl.FAIL_FREQ ,subCompTbl.FAIL_TYPE ,subCompTbl.FAIL_REASON ," +
		"subCompTbl.AIRVALVE_NO, " +
		"subCompTbl.AIRVALVEPIT_NO,subCompTbl.SCOUREVALVE ,subCompTbl.SR_VALVEPIT_NO ,subCompTbl.REFLEXVALVE ,subCompTbl.R_VALVEPIT_NO " +
		",subCompTbl.SLUICEVALVE,subCompTbl.SL_VALVEPIT_NO,ASSET_NAME";
        finalQuery=finalQuery+query;
        
	
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	        ////System.out.println( finalQuery);
	        ResultSet rs=stmt.executeQuery( finalQuery);
	        ////System.out.println( finalQuery);
	        try{
	        	String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GRAVITYMAIN_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GRAVITYMAIN_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsGm=new ArrayList();
            cpwsGm.add(sno);
        	try{rs3.next();
            
        	cpwsGm.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsGm.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsGm.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsGm.add("");
        		//System.out.println("exception:"+e);}
        	cpwsGm.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsGm.add(formatData(rs.getString("GRAVITYMAIN_CODE")));
        	cpwsGm.add(formatData(rs.getString("LENGTH")));
        	cpwsGm.add(formatData(rs.getString("MET_TYPE")));
        	cpwsGm.add(formatData(rs.getString("FAIL_FREQ")));
        	cpwsGm.add(formatData(rs.getString("FAIL_TYPE")));
        	cpwsGm.add(formatData(rs.getString("FAIL_REASON")));
        	cpwsGm.add(formatData(rs.getString("AIRVALVE_NO")));
        	cpwsGm.add(formatData(rs.getString("AIRVALVEPIT_NO")));
        	cpwsGm.add(formatData(rs.getString("SCOUREVALVE")));
        	cpwsGm.add(formatData(rs.getString("SR_VALVEPIT_NO")));
        	cpwsGm.add(formatData(rs.getString("REFLEXVALVE")));
        	cpwsGm.add(formatData(rs.getString("R_VALVEPIT_NO")));
        	cpwsGm.add(formatData(rs.getString("SLUICEVALVE")));
        	cpwsGm.add(formatData(rs.getString("SL_VALVEPIT_NO")));
        	cpwsReport.add( cpwsGm);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();		
	        conn.close();
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;


	}
	
	public static ArrayList getAssetPwsGravityMainReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws reservoirs gravity main  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsGm;
	
	try
	{
		String finalQuery="select  subCompTbl.GRAVITYMAIN_CODE ,subCompTbl.LENGTH ,subCompTbl.MET_TYPE, " +
		"subCompTbl.FAIL_FREQ ,subCompTbl.FAIL_TYPE ,subCompTbl.FAIL_REASON ," +
		"subCompTbl.AIRVALVE_NO, " +
		"subCompTbl.AIRVALVEPIT_NO,subCompTbl.SCOUREVALVE ,subCompTbl.SR_VALVEPIT_NO ,subCompTbl.REFLEXVALVE ,subCompTbl.R_VALVEPIT_NO " +
		",subCompTbl.SLUICEVALVE,subCompTbl.SL_VALVEPIT_NO,ASSET_NAME";
        finalQuery=finalQuery+query;
        
	
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	        ////System.out.println( finalQuery);
	        ResultSet rs=stmt.executeQuery( finalQuery);
	        ////System.out.println( finalQuery);
	        try{
	        	String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GRAVITYMAIN_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GRAVITYMAIN_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsGm=new ArrayList();
            cpwsGm.add(sno);
        	try{rs3.next();
            
        	cpwsGm.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsGm.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsGm.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsGm.add("");
        		//System.out.println("exception:"+e);}
        	cpwsGm.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsGm.add(formatData(rs.getString("GRAVITYMAIN_CODE")));
        	cpwsGm.add(formatData(rs.getString("LENGTH")));
        	cpwsGm.add(formatData(rs.getString("MET_TYPE")));
        	cpwsGm.add(formatData(rs.getString("FAIL_FREQ")));
        	cpwsGm.add(formatData(rs.getString("FAIL_TYPE")));
        	cpwsGm.add(formatData(rs.getString("FAIL_REASON")));
        	cpwsGm.add(formatData(rs.getString("AIRVALVE_NO")));
        	cpwsGm.add(formatData(rs.getString("AIRVALVEPIT_NO")));
        	cpwsGm.add(formatData(rs.getString("SCOUREVALVE")));
        	cpwsGm.add(formatData(rs.getString("SR_VALVEPIT_NO")));
        	cpwsGm.add(formatData(rs.getString("REFLEXVALVE")));
        	cpwsGm.add(formatData(rs.getString("R_VALVEPIT_NO")));
        	cpwsGm.add(formatData(rs.getString("SLUICEVALVE")));
        	cpwsGm.add(formatData(rs.getString("SL_VALVEPIT_NO")));
        	cpwsReport.add( cpwsGm);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();		
	        conn.close();
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;


	}
	//Cpws Reservoirs
	public static ArrayList getAssetCpwsReservoirsOhsrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws reservoirs ohsr  report");
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsOhsr;
		try
		{
			String finalQuery="select subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC," +
					"subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES," +
					"subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,ASSET_NAME";
	        finalQuery=finalQuery+query;
		    conn = dataSource.getConnection();
	        PreparedStatement psmt1=conn.prepareStatement(finalQuery);	
	        ResultSet rs2=psmt1.executeQuery();
		       
		     try
			   {
		     
		     	
		     	String sno="1";
	            while(rs2.next())
	           { 
	            PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,14)=substr(panch_code,1,14)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where substr(?,1,14)=substr(panch_code,1,14)");
	            psmt2.setString(1,(String)rs2.getString("OHSR_CODE"));
	            psmt3.setString(1,(String)rs2.getString("OHSR_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet rs4=psmt3.executeQuery();
	            
	            
	            cpwsOhsr=new ArrayList();
	        	cpwsOhsr.add(sno);
	            try{
	            	rs3.next();
	            
	        	cpwsOhsr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsOhsr.add("");
	            	System.err.println("Exception"+e);
	            
	            	}
	        	try{rs4.next();
	        	cpwsOhsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsOhsr.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsOhsr.add(formatData(rs2.getString("ASSET_NAME")));
	            cpwsOhsr.add(formatData(rs2.getString("OHSR_CODE")));
	        	cpwsOhsr.add(formatData(rs2.getString("OHSR_LOC")));
	        	cpwsOhsr.add(formatData(rs2.getInt("OHSR_CAP_LTS"))+"");
	            cpwsOhsr.add(formatData(rs2.getInt("OHSR_NO_OF_FILLING"))+"");
	            cpwsOhsr.add(formatData(rs2.getFloat("OHSR_SATGES")));
	        	cpwsOhsr.add(formatData(rs2.getFloat("OHSR_LWL")));
	        	cpwsOhsr.add(formatData(rs2.getFloat("OHSR_MWL")));
	        	cpwsOhsr.add(formatData(rs2.getFloat("OHSR_FILL_HR")));
	        	cpwsOhsr.add(formatData(rs2.getFloat("OHSR_EMPTY_HR")));
	        	cpwsReport.add( cpwsOhsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
	            
		    }
		        catch(Exception e)
				 {
				 	System.err.println("error in adding data  to  arraylist  in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 	
				 }
		        psmt1.close();
		        stmt.close();
		        conn.close();
	        
		}
		 catch(Exception e)
		 {
		 	System.err.println("error in retriving data  in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

	}
	
	public static ArrayList getAssetCpwsReservoirsOhbrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws reservoirs ohbr  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsOhbr;
		
		try
		{
			
			
			String finalQuery="select subCompTbl.OHBR_CODE,subCompTbl.OHBR_LOC,subCompTbl.OHBR_CAP_LTS," +
			"subCompTbl.OHBR_SATGES,subCompTbl.OHBR_LWL,subCompTbl.OHBR_MWL,subCompTbl.OHBR_FILL_HR," +
			"subCompTbl.OHBR_EMPTY_HR,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        
		
		    conn = dataSource.getConnection();
	    	
	    	PreparedStatement psmt1=conn.prepareStatement( finalQuery);
	        ResultSet rs=psmt1.executeQuery();
		     
		        try{
		        	String sno="1";
	        while(rs.next())
	        {
	        	
	        	
	        	PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,14)=substr(panch_code,1,14)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where substr(?,1,14)=substr(panch_code,1,14)");
	            psmt2.setString(1,(String)rs.getString("OHBR_CODE"));
	            psmt3.setString(1,(String)rs.getString("OHBR_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet rs4=psmt3.executeQuery();
	        	cpwsOhbr=new ArrayList();
	        	cpwsOhbr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsOhbr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsOhbr.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsOhbr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsOhbr.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsOhbr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsOhbr.add(formatData(rs.getString("OHBR_CODE")));
	        	cpwsOhbr.add(formatData(rs.getString("OHBR_LOC")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_CAP_LTS")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_SATGES")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_LWL")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_MWL")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_FILL_HR")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_EMPTY_HR")));
	        	cpwsReport.add( cpwsOhbr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();		
		        conn.close();
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

	}
	public static ArrayList getAssetPwsReservoirsOhbrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws reservoirs ohbr  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsOhbr;
		
		try
		{
			
			 conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.OHBR_CODE,subCompTbl.OHBR_LOC,subCompTbl.OHBR_CAP_LTS," +
			"subCompTbl.OHBR_SATGES,subCompTbl.OHBR_LWL,subCompTbl.OHBR_MWL,subCompTbl.OHBR_FILL_HR," +
			"subCompTbl.OHBR_EMPTY_HR,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        
		    PreparedStatement psmt1=conn.prepareStatement(finalQuery);
		   
	    	stmt = conn.createStatement();
	    	
	      
		        
		        ResultSet rs= psmt1.executeQuery();
		  
		        try{
		        	String sno="1";
	        while(rs.next())
	        {
	        	PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,14)=substr(panch_code,1,14)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where substr(?,1,14)=substr(panch_code,1,14)");
	            psmt2.setString(1,(String)rs.getString("OHBR_CODE"));
	            psmt3.setString(1,(String)rs.getString("OHBR_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet rs4=psmt3.executeQuery();
	        	cpwsOhbr=new ArrayList();
	        	cpwsOhbr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsOhbr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsOhbr.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsOhbr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsOhbr.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsOhbr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsOhbr.add(formatData(rs.getString("OHBR_CODE")));
	        	cpwsOhbr.add(formatData(rs.getString("OHBR_LOC")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_CAP_LTS")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_SATGES")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_LWL")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_MWL")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_FILL_HR")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_EMPTY_HR")));
	        	cpwsReport.add( cpwsOhbr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();		
		        conn.close();
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsReservoirsrGlsrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws reservoirs glsr  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGlsr;
		try
		{
			conn = dataSource.getConnection();

			String finalQuery="select subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS," +
			"subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR," +
			"subCompTbl.GLSR_EMPTY_HR,subCompTbl.GLSR_NO_OF_FILLING,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        PreparedStatement psmt1=conn.prepareStatement(finalQuery);
		   
	        ResultSet rs= psmt1.executeQuery();
		 
		        try{String sno="1";
	        while(rs.next())
	        {
	        	PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,14)=substr(panch_code,1,14)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where substr(?,1,14)=substr(panch_code,1,14)");
	            psmt2.setString(1,(String)rs.getString("GLSR_CODE"));
	            psmt3.setString(1,(String)rs.getString("GLSR_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet rs4=psmt3.executeQuery();
	            cpwsGlsr=new ArrayList();
	            cpwsGlsr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGlsr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsGlsr.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlsr.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlsr.add(formatData(rs.getString("GLSR_CODE")));
	        	cpwsGlsr.add(formatData(rs.getString("GLSR_LOC")));
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_CAP_LTS")));
	        	cpwsGlsr.add(formatData(rs.getInt("GLSR_NO_OF_FILLING")));
	            cpwsGlsr.add(formatData(rs.getFloat("GLSR_SATGES")));
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_LWL")));
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_MWL")));
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_FILL_HR")));
	        	
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_EMPTY_HR")));
	        	
	        	
	            cpwsReport.add( cpwsGlsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();	
		        conn.close();  
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsReservoirsrGlbrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws reservoirs glbr  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGlbr;
		
		try
		{
			
			String finalQuery="select subCompTbl.GLBR_CODE,subCompTbl.GLBR_LOC,subCompTbl.GLBR_CAP_LTS," +
			"subCompTbl.GLBR_LWL,subCompTbl.GLBR_MWL,subCompTbl.GLBR_FILL_HR,subCompTbl.GLBR_EMPTY_HR,ASSET_NAME";
	        finalQuery=finalQuery+query;

		    conn = dataSource.getConnection();
	    	stmt = conn.createStatement();
	    	
	     
		 
		        ////System.out.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        ////System.out.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GLBR_CODE")+"',1,14)=substr(panch_code,1,14)");
	            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GLBR_CODE")+"',1,14)=substr(panch_code,1,14)");
	           
	            cpwsGlbr=new ArrayList();
	            cpwsGlbr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGlbr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsGlbr.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlbr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlbr.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsGlbr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlbr.add(formatData(rs.getString("GLBR_CODE")));
	        	cpwsGlbr.add(formatData(rs.getString("GLBR_LOC")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_CAP_LTS")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_LWL")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_MWL")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_FILL_HR")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_EMPTY_HR")));
	 	        cpwsReport.add( cpwsGlbr);
	 	        int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();	
		        conn.close();   
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

	}
	public static ArrayList getAssetPwsReservoirsrGlbrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws reservoirs glbr  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGlbr;
		
		try
		{
			
			String finalQuery="select subCompTbl.GLBR_CODE,subCompTbl.GLBR_LOC,subCompTbl.GLBR_CAP_LTS," +
			"subCompTbl.GLBR_LWL,subCompTbl.GLBR_MWL,subCompTbl.GLBR_FILL_HR,subCompTbl.GLBR_EMPTY_HR,ASSET_NAME";
	        finalQuery=finalQuery+query;

		    conn = dataSource.getConnection();
	    	stmt = conn.createStatement();
	    	
	     
		 
		        ////System.out.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        ////System.out.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GLBR_CODE")+"',1,14)=substr(panch_code,1,14)");
	            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GLBR_CODE")+"',1,14)=substr(panch_code,1,14)");
	           
	            cpwsGlbr=new ArrayList();
	            cpwsGlbr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGlbr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsGlbr.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlbr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlbr.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsGlbr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlbr.add(formatData(rs.getString("GLBR_CODE")));
	        	cpwsGlbr.add(formatData(rs.getString("GLBR_LOC")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_CAP_LTS")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_LWL")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_MWL")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_FILL_HR")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_EMPTY_HR")));
	 	        cpwsReport.add( cpwsGlbr);
	 	        int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();	
		        conn.close();   
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

	}
	
	public static ArrayList getAssetCpwsReservoirsBptReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws reservoirs bpt  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsBpt;
		
		try
		{
			String finalQuery="select subCompTbl.BPT_CODE,subCompTbl.CAPACITY,subCompTbl.STAGING," +
			"subCompTbl.MAXWL,subCompTbl.MINWL,ASSET_NAME";
	        finalQuery=finalQuery+query;
		
		
		    conn = dataSource.getConnection();
	    	stmt = conn.createStatement();
	    	
	      
		 
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        ////System.out.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("BPT_CODE")+"',1,14)=substr(panch_code,1,14)");
	            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("BPT_CODE")+"',1,14)=substr(panch_code,1,14)");
	           
	            cpwsBpt=new ArrayList();
	            cpwsBpt.add(sno);
	        	try{rs3.next();
	            
	        	cpwsBpt.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsBpt.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsBpt.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsBpt.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsBpt.add(formatData(rs.getString("ASSET_NAME")));
	        	 cpwsBpt.add(formatData(rs.getString("BPT_CODE")));
	        	 cpwsBpt.add(formatData(rs.getFloat("CAPACITY")));
	        	 cpwsBpt.add(formatData(rs.getFloat("STAGING")));
	        	 cpwsBpt.add(formatData(rs.getFloat("MAXWL")));
	        	 cpwsBpt.add(formatData(rs.getFloat("MINWL")));
	             cpwsReport.add(cpwsBpt);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();	
		        conn.close(); 
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

	}
	
	public static ArrayList getAssetPwsReservoirsBptReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws reservoirs bpt  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsBpt;
		
		try
		{
			String finalQuery="select subCompTbl.BPT_CODE,subCompTbl.CAPACITY,subCompTbl.STAGING," +
			"subCompTbl.MAXWL,subCompTbl.MINWL,ASSET_NAME";
	        finalQuery=finalQuery+query;
		
		
		    conn = dataSource.getConnection();
	    	stmt = conn.createStatement();
	    	
	      
		 
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        ////System.out.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("BPT_CODE")+"',1,14)=substr(panch_code,1,14)");
	            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("BPT_CODE")+"',1,14)=substr(panch_code,1,14)");
	           
	            cpwsBpt=new ArrayList();
	            cpwsBpt.add(sno);
	        	try{rs3.next();
	            
	        	cpwsBpt.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsBpt.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsBpt.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsBpt.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsBpt.add(formatData(rs.getString("ASSET_NAME")));
	        	 cpwsBpt.add(formatData(rs.getString("BPT_CODE")));
	        	 cpwsBpt.add(formatData(rs.getFloat("CAPACITY")));
	        	 cpwsBpt.add(formatData(rs.getFloat("STAGING")));
	        	 cpwsBpt.add(formatData(rs.getFloat("MAXWL")));
	        	 cpwsBpt.add(formatData(rs.getFloat("MINWL")));
	             cpwsReport.add(cpwsBpt);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();	
		        conn.close(); 
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

	}
	
//cpws HeadWorks
	public static ArrayList getAssetCpwsHeadWorksRcWellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
    ////System.out.println("getting data from CheckListMasterData for cpws headWorks raw water collction well  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRwcWell;
	
	try
	{
		String finalQuery="select subCompTbl.RW_COLLWELL_CODE,subCompTbl.DIAMETER,subCompTbl.DEPTH," +
		"subCompTbl.TYPE_OF_FLOORING,ASSET_NAME";
        finalQuery=finalQuery+query;
	
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	
	        ResultSet rs=stmt.executeQuery( finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("RW_COLLWELL_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("RW_COLLWELL_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsRwcWell=new ArrayList();
            cpwsRwcWell.add(sno);
        	try{rs3.next();
            
        	cpwsRwcWell.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsRwcWell.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsRwcWell.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRwcWell.add("");
        		//System.out.println("exception:"+e);}
        	cpwsRwcWell.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsRwcWell.add(formatData(rs.getString("RW_COLLWELL_CODE")));
        	cpwsRwcWell.add(formatData(rs.getFloat("DIAMETER")));
        	cpwsRwcWell.add(formatData(rs.getFloat("DEPTH")));
        	cpwsRwcWell.add(formatData(rs.getString("TYPE_OF_FLOORING")));
            cpwsReport.add(cpwsRwcWell);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	       
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;

	}
	
	//pws hw
	public static ArrayList getAssetPwsHeadWorksRcWellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
    ////System.out.println("getting data from CheckListMasterData for cpws headWorks raw water collction well  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRwcWell;
	
	try
	{
		String finalQuery="select subCompTbl.RW_COLLWELL_CODE,subCompTbl.DIAMETER,subCompTbl.DEPTH," +
		"subCompTbl.TYPE_OF_FLOORING,ASSET_NAME";
        finalQuery=finalQuery+query;
	
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	
	        ResultSet rs=stmt.executeQuery( finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("RW_COLLWELL_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("RW_COLLWELL_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsRwcWell=new ArrayList();
            cpwsRwcWell.add(sno);
        	try{rs3.next();
            
        	cpwsRwcWell.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsRwcWell.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsRwcWell.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRwcWell.add("");
        		//System.out.println("exception:"+e);}
        	cpwsRwcWell.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsRwcWell.add(formatData(rs.getString("RW_COLLWELL_CODE")));
        	cpwsRwcWell.add(formatData(rs.getFloat("DIAMETER")));
        	cpwsRwcWell.add(formatData(rs.getFloat("DEPTH")));
        	cpwsRwcWell.add(formatData(rs.getString("TYPE_OF_FLOORING")));
            cpwsReport.add(cpwsRwcWell);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	       
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;

	}
	public static ArrayList getAssetCpwsHeadWorksSSTankReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws headWorks ss Tank  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSsTank;
	
	try
	{
		String finalQuery="select subCompTbl.SSSC_CODE,subCompTbl.SS_SIZE,subCompTbl.CAPACITY_DAYS," +
				"subCompTbl.CAPACITY_MCUM,subCompTbl.TANK_ADEQACY,subCompTbl.LOCATION,subCompTbl.YIELD_CUM," +
				"subCompTbl.YIELD_TEST_DT,subCompTbl.POWER_CON,subCompTbl.POWER_HRS,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SSSC_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SSSC_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsSsTank=new ArrayList();
            cpwsSsTank.add(sno);
        	try{rs3.next();
            
        	cpwsSsTank.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsSsTank.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSsTank.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSsTank.add("");
        		//System.out.println("exception:"+e);}
        	cpwsSsTank.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsSsTank.add(formatData(rs.getString("SSSC_CODE")));
        	cpwsSsTank.add(formatData(rs.getInt("SS_SIZE"))+"");
        	cpwsSsTank.add(formatData(rs.getInt("CAPACITY_DAYS"))+"");
        	cpwsSsTank.add(formatData(rs.getFloat("CAPACITY_MCUM")));
        	cpwsSsTank.add(formatData(rs.getInt("TANK_ADEQACY"))+"");
        	cpwsSsTank.add(formatData(rs.getString("LOCATION")));
        	cpwsSsTank.add(formatData(rs.getFloat("YIELD_CUM")));
        	cpwsSsTank.add(formatData(rs.getString("YIELD_TEST_DT")));
        	cpwsSsTank.add(formatData(formatData(rs.getString("POWER_CON"))));
        	cpwsSsTank.add(formatData(rs.getInt("POWER_HRS"))+"");
            cpwsReport.add(cpwsSsTank);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksSSTankReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws headWorks ss Tank  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSsTank;
	
	try
	{
		String finalQuery="select subCompTbl.SSSC_CODE,subCompTbl.SS_SIZE,subCompTbl.CAPACITY_DAYS," +
				"subCompTbl.CAPACITY_MCUM,subCompTbl.TANK_ADEQACY,subCompTbl.LOCATION,subCompTbl.YIELD_CUM," +
				"subCompTbl.YIELD_TEST_DT,subCompTbl.POWER_CON,subCompTbl.POWER_HRS,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SSSC_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SSSC_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsSsTank=new ArrayList();
            cpwsSsTank.add(sno);
        	try{rs3.next();
            
        	cpwsSsTank.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsSsTank.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSsTank.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSsTank.add("");
        		//System.out.println("exception:"+e);}
        	cpwsSsTank.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsSsTank.add(formatData(rs.getString("SSSC_CODE")));
        	cpwsSsTank.add(formatData(rs.getInt("SS_SIZE"))+"");
        	cpwsSsTank.add(formatData(rs.getInt("CAPACITY_DAYS"))+"");
        	cpwsSsTank.add(formatData(rs.getFloat("CAPACITY_MCUM")));
        	cpwsSsTank.add(formatData(rs.getInt("TANK_ADEQACY"))+"");
        	cpwsSsTank.add(formatData(rs.getString("LOCATION")));
        	cpwsSsTank.add(formatData(rs.getFloat("YIELD_CUM")));
        	cpwsSsTank.add(formatData(rs.getString("YIELD_TEST_DT")));
        	cpwsSsTank.add(formatData(formatData(rs.getString("POWER_CON"))));
        	cpwsSsTank.add(formatData(rs.getInt("POWER_HRS"))+"");
            cpwsReport.add(cpwsSsTank);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksSSFilterReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws headWorks rs filter  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsSsFilter;
		
		try
		{
			String finalQuery="select subCompTbl.WTPSC_CODE ,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ," +
					"subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.SCRAPING_FEQ ," +
					"subCompTbl.BACKWASH_FEQ ,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,ASSET_NAME ";
			finalQuery=finalQuery+query;
		   conn = dataSource.getConnection();
	    	stmt = conn.createStatement();
	    	
	      
		  ////System.out.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        ////System.out.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
	            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
	           
	            cpwsSsFilter=new ArrayList();
	            cpwsSsFilter.add(sno);
	        	try{rs3.next();
	            
	        	cpwsSsFilter.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsSsFilter.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsSsFilter.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsSsFilter.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
	        	cpwsSsFilter.add(formatData(rs.getString("WTP_TYPW")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
	        	cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
	         	cpwsSsFilter.add(formatData(rs.getInt("SCRAPING_FEQ"))+"");
	        	cpwsSsFilter.add(formatData(rs.getFloat("BACKWASH_FEQ")));
	        	cpwsSsFilter.add(formatData(rs.getString("PERFORMANCE")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
	        	cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
	            cpwsReport.add(cpwsSsFilter);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();	
		        conn.close(); 
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;
	}
	
	public static ArrayList getAssetPwsHeadWorksSSFilterReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
		////System.out.println("getting data from CheckListMasterData for cpws headWorks rs filter  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsSsFilter;
		
		try
		{
			String finalQuery="select subCompTbl.WTPSC_CODE ,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ," +
					"subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.SCRAPING_FEQ ," +
					"subCompTbl.BACKWASH_FEQ ,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,ASSET_NAME ";
			finalQuery=finalQuery+query;
		   conn = dataSource.getConnection();
	    	stmt = conn.createStatement();
	    	
	      
		  ////System.out.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        ////System.out.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
	            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
	           
	            cpwsSsFilter=new ArrayList();
	            cpwsSsFilter.add(sno);
	        	try{rs3.next();
	            
	        	cpwsSsFilter.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsSsFilter.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsSsFilter.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsSsFilter.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
	        	cpwsSsFilter.add(formatData(rs.getString("WTP_TYPW")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
	        	cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
	         	cpwsSsFilter.add(formatData(rs.getInt("SCRAPING_FEQ"))+"");
	        	cpwsSsFilter.add(formatData(rs.getFloat("BACKWASH_FEQ")));
	        	cpwsSsFilter.add(formatData(rs.getString("PERFORMANCE")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
	        	cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
	            cpwsReport.add(cpwsSsFilter);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();	
		        conn.close(); 
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksRSFilterReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws headWorks rs filter  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRsFilter;
	
	try
	{
		String finalQuery="select subCompTbl.WTPSC_CODE ,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ," +
				"subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.SCRAPING_FEQ ," +
				"subCompTbl.BACKWASH_FEQ ,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,ASSET_NAME ";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsRsFilter=new ArrayList();
            cpwsRsFilter.add(sno);
        	try{rs3.next();
            
        	cpwsRsFilter.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsRsFilter.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsRsFilter.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRsFilter.add("");
        		//System.out.println("exception:"+e);}
        	cpwsRsFilter.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsRsFilter.add(formatData(rs.getString("WTPSC_CODE")));
        	cpwsRsFilter.add(formatData(rs.getString("WTP_TYPW")));
        	cpwsRsFilter.add(formatData(rs.getFloat("WTP_MLD")));
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
        	cpwsRsFilter.add(formatData(rs.getString("WTP_SIZE")));
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
        	cpwsRsFilter.add(formatData(rs.getInt("SCRAPING_FEQ"))+"");
        	cpwsRsFilter.add(formatData(rs.getFloat("BACKWASH_FEQ")));
        	cpwsRsFilter.add((rs.getString("PERFORMANCE")));
        	cpwsRsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
        	cpwsRsFilter.add((rs.getString("EXTENTION_SCOPE")));
            cpwsReport.add(cpwsRsFilter);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksRSFilterReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws headWorks rs filter  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRsFilter;
	
	try
	{
		String finalQuery="select subCompTbl.WTPSC_CODE ,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ," +
				"subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.SCRAPING_FEQ ," +
				"subCompTbl.BACKWASH_FEQ ,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,ASSET_NAME ";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsRsFilter=new ArrayList();
            cpwsRsFilter.add(sno);
        	try{rs3.next();
            
        	cpwsRsFilter.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsRsFilter.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsRsFilter.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRsFilter.add("");
        		//System.out.println("exception:"+e);}
        	cpwsRsFilter.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsRsFilter.add(formatData(rs.getString("WTPSC_CODE")));
        	cpwsRsFilter.add(formatData(rs.getString("WTP_TYPW")));
        	cpwsRsFilter.add(formatData(rs.getFloat("WTP_MLD")));
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
        	cpwsRsFilter.add(formatData(rs.getString("WTP_SIZE")));
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
        	cpwsRsFilter.add(formatData(rs.getInt("SCRAPING_FEQ"))+"");
        	cpwsRsFilter.add(formatData(rs.getFloat("BACKWASH_FEQ")));
        	cpwsRsFilter.add((rs.getString("PERFORMANCE")));
        	cpwsRsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
        	cpwsRsFilter.add((rs.getString("EXTENTION_SCOPE")));
            cpwsReport.add(cpwsRsFilter);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksSumpReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws headWorks Sump  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSump;
	
	try
	{
		String finalQuery="select subCompTbl.	SUMPCODE  ,subCompTbl.SUMP_TYPE  ,subCompTbl.SUMP_CAPACITY ," +
				"subCompTbl.FILLING_HR ,subCompTbl.EMPTY_TIME_HR ,DECODE(subCompTbl.SUMP_CONDITION,'G','GOOD','B','BAD')SUMP_CONDITION,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SUMPCODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SUMPCODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsSump=new ArrayList();
            cpwsSump.add(sno);
        	try{rs3.next();
            
        	cpwsSump.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsSump.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSump.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSump.add("");
        		//System.out.println("exception:"+e);}
        	cpwsSump.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsSump.add(formatData(rs.getString("SUMPCODE")));
        	cpwsSump.add(formatData(rs.getString("SUMP_TYPE")));
        	cpwsSump.add(formatData(rs.getInt("SUMP_CAPACITY"))+"");
        	cpwsSump.add(formatData(rs.getFloat("FILLING_HR")));
        	cpwsSump.add(formatData(rs.getFloat("EMPTY_TIME_HR")));
        	cpwsSump.add(formatData(rs.getString("SUMP_CONDITION")));
            cpwsReport.add(cpwsSump);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksSumpReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws headWorks Sump  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSump;
	
	try
	{
		String finalQuery="select subCompTbl.	SUMPCODE  ,subCompTbl.SUMP_TYPE  ,subCompTbl.SUMP_CAPACITY ," +
				"subCompTbl.FILLING_HR ,subCompTbl.EMPTY_TIME_HR ,DECODE(subCompTbl.SUMP_CONDITION,'G','GOOD','B','BAD')SUMP_CONDITION,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SUMPCODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SUMPCODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsSump=new ArrayList();
            cpwsSump.add(sno);
        	try{rs3.next();
            
        	cpwsSump.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsSump.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSump.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSump.add("");
        		//System.out.println("exception:"+e);}
        	cpwsSump.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsSump.add(formatData(rs.getString("SUMPCODE")));
        	cpwsSump.add(formatData(rs.getString("SUMP_TYPE")));
        	cpwsSump.add(formatData(rs.getInt("SUMP_CAPACITY"))+"");
        	cpwsSump.add(formatData(rs.getFloat("FILLING_HR")));
        	cpwsSump.add(formatData(rs.getFloat("EMPTY_TIME_HR")));
        	cpwsSump.add(formatData(rs.getString("SUMP_CONDITION")));
            cpwsReport.add(cpwsSump);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksFootPtahReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
     ////System.out.println("getting data from CheckListMasterData for cpws headWorks foot path bride  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSump;
	
	try
	{
		String finalQuery="select subCompTbl.BRIDGE_CODE,subCompTbl.BRIDGE_TYPE,subCompTbl.BRIDGE_LENGTH ," +
				"subCompTbl.BRIDGE_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH," +
				"subCompTbl.LENGTH_OF_THE_BRIDGE,subCompTbl.BRIDGE_SPAN_LENGTH,ASSET_NAME ";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("BRIDGE_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("BRIDGE_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsSump=new ArrayList();
            cpwsSump.add(sno);
        	try{rs3.next();
            
        	cpwsSump.add(rs3.getString("PNAME"));
        	
            }catch(Exception e){
            	cpwsSump.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSump.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSump.add("");
        		//System.out.println("exception:"+e);}
        	cpwsSump.add(formatData(rs.getString("ASSET_NAME")+""));
        	cpwsSump.add(formatData(rs.getString("BRIDGE_CODE")+""));
        	cpwsSump.add(formatData(rs.getString("BRIDGE_TYPE")+""));
        	cpwsSump.add(formatData(rs.getFloat("BRIDGE_LENGTH")+""));
        	cpwsSump.add(formatData(rs.getFloat("BRIDGE_WIDTH")+""));
        	cpwsSump.add(formatData(rs.getFloat("BRIDGE_WALK_WAY_WIDTH")+""));
        	cpwsSump.add(formatData(rs.getFloat("BRIDGE_SPAN_LENGTH")+""));
        	
            cpwsReport.add(cpwsSump);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksFootPtahReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
     ////System.out.println("getting data from CheckListMasterData for cpws headWorks foot path bride  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSump;
	
	try
	{
		String finalQuery="select subCompTbl.BRIDGE_CODE,subCompTbl.BRIDGE_TYPE,subCompTbl.BRIDGE_LENGTH ," +
				"subCompTbl.BRIDGE_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH," +
				"subCompTbl.LENGTH_OF_THE_BRIDGE,subCompTbl.BRIDGE_SPAN_LENGTH,ASSET_NAME ";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("BRIDGE_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("BRIDGE_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsSump=new ArrayList();
            cpwsSump.add(sno);
        	try{rs3.next();
            
        	cpwsSump.add(rs3.getString("PNAME"));
        	
            }catch(Exception e){
            	cpwsSump.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSump.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSump.add("");
        		//System.out.println("exception:"+e);}
        	cpwsSump.add(formatData(rs.getString("ASSET_NAME")+""));
        	cpwsSump.add(formatData(rs.getString("BRIDGE_CODE")+""));
        	cpwsSump.add(formatData(rs.getString("BRIDGE_TYPE")+""));
        	cpwsSump.add(formatData(rs.getFloat("BRIDGE_LENGTH")+""));
        	cpwsSump.add(formatData(rs.getFloat("BRIDGE_WIDTH")+""));
        	cpwsSump.add(formatData(rs.getFloat("BRIDGE_WALK_WAY_WIDTH")+""));
        	cpwsSump.add(formatData(rs.getFloat("BRIDGE_SPAN_LENGTH")+""));
        	
            cpwsReport.add(cpwsSump);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksPumpHouseReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
	////System.out.println("getting data from CheckListMasterData for cpws headWorks pump House  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwspumpHouse;
	
	try
	{
		
		String finalQuery="select subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.HEIGHT ," +
				"subCompTbl.PUMPHOUSE_CODE,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("PUMPHOUSE_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("PUMPHOUSE_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwspumpHouse=new ArrayList();
            cpwspumpHouse.add(sno);
        	try{rs3.next();
            
        	cpwspumpHouse.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwspumpHouse.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwspumpHouse.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwspumpHouse.add("");
        		//System.out.println("exception:"+e);}
        	cpwspumpHouse.add(formatData(rs.getString("ASSET_NAME")));
        	cpwspumpHouse.add(formatData(rs.getString("PUMPHOUSE_CODE")));
        	cpwspumpHouse.add(formatData(rs.getString("TYPE")));
        	cpwspumpHouse.add(formatData(rs.getFloat("AREA")));
        	cpwspumpHouse.add(formatData(rs.getFloat("HEIGHT")));
        	
        	cpwsReport.add(cpwspumpHouse);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksPumpHouseReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
	////System.out.println("getting data from CheckListMasterData for cpws headWorks pump House  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwspumpHouse;
	
	try
	{
		
		String finalQuery="select subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.HEIGHT ," +
				"subCompTbl.PUMPHOUSE_CODE,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("PUMPHOUSE_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("PUMPHOUSE_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwspumpHouse=new ArrayList();
            cpwspumpHouse.add(sno);
        	try{rs3.next();
            
        	cpwspumpHouse.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwspumpHouse.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwspumpHouse.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwspumpHouse.add("");
        		//System.out.println("exception:"+e);}
        	cpwspumpHouse.add(formatData(rs.getString("ASSET_NAME")));
        	cpwspumpHouse.add(formatData(rs.getString("PUMPHOUSE_CODE")));
        	cpwspumpHouse.add(formatData(rs.getString("TYPE")));
        	cpwspumpHouse.add(formatData(rs.getFloat("AREA")));
        	cpwspumpHouse.add(formatData(rs.getFloat("HEIGHT")));
        	
        	cpwsReport.add(cpwspumpHouse);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksWatchmanReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws headWorks watch Man report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwswatch;
	
	try
	{
		
		String finalQuery="select subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.NO_OF_QTRS ," +
				"subCompTbl.WATCHMAN_CODE,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WATCHMAN_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WATCHMAN_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwswatch=new ArrayList();
            cpwswatch.add(sno);
        	try{rs3.next();
            
        	cpwswatch.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwswatch.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwswatch.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwswatch.add("");
        		//System.out.println("exception:"+e);}
         	////System.out.println("2");
        	cpwswatch.add(formatData(rs.getString("ASSET_NAME")));
        	////System.out.println("3");
        	cpwswatch.add(formatData(rs.getString("WATCHMAN_CODE")));
        	////System.out.println("4");
        	cpwswatch.add(formatData(rs.getString("TYPE")));
        	////System.out.println("5");
        	cpwswatch.add(formatData(rs.getFloat("AREA")));
        	////System.out.println("6");
        	cpwswatch.add(formatData(rs.getInt("NO_OF_QTRS"))+"");
         	////System.out.println("7");	
        	cpwsReport.add(cpwswatch);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat inadding to arrayllsit"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksWatchmanReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{////System.out.println("getting data from CheckListMasterData for cpws headWorks watch Man report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwswatch;
	
	try
	{
		
		String finalQuery="select subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.NO_OF_QTRS ," +
				"subCompTbl.WATCHMAN_CODE,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WATCHMAN_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WATCHMAN_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwswatch=new ArrayList();
            cpwswatch.add(sno);
        	try{rs3.next();
            
        	cpwswatch.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwswatch.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwswatch.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwswatch.add("");
        		//System.out.println("exception:"+e);}
         	////System.out.println("2");
        	cpwswatch.add(formatData(rs.getString("ASSET_NAME")));
        	////System.out.println("3");
        	cpwswatch.add(formatData(rs.getString("WATCHMAN_CODE")));
        	////System.out.println("4");
        	cpwswatch.add(formatData(rs.getString("TYPE")));
        	////System.out.println("5");
        	cpwswatch.add(formatData(rs.getFloat("AREA")));
        	////System.out.println("6");
        	cpwswatch.add(formatData(rs.getInt("NO_OF_QTRS"))+"");
         	////System.out.println("7");	
        	cpwsReport.add(cpwswatch);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat inadding to arrayllsit"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksCWCWellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
	////System.out.println("getting data from CheckListMasterData for cpws headWorks cwc well  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsCwcWell;
	
	try
	{
		String finalQuery="select subCompTbl.CW_COLLWELL_CODE ,subCompTbl.DIAMETER,subCompTbl.DEPTH ," +
				"subCompTbl.TYPE_OF_FLOORING,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("CW_COLLWELL_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("CW_COLLWELL_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsCwcWell=new ArrayList();
            cpwsCwcWell.add(sno);
        	try{rs3.next();
            
        	cpwsCwcWell.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsCwcWell.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsCwcWell.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsCwcWell.add("");
        		//System.out.println("exception:"+e);}
        	cpwsCwcWell.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsCwcWell.add(formatData(rs.getString("CW_COLLWELL_CODE")));
        	cpwsCwcWell.add(formatData(rs.getFloat("DIAMETER")));
        	cpwsCwcWell.add(formatData(rs.getFloat("DEPTH")));
        	cpwsCwcWell.add(formatData(rs.getString("TYPE_OF_FLOORING")));
        	
        	cpwsReport.add(cpwsCwcWell);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksCWCWellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
	{
	////System.out.println("getting data from CheckListMasterData for cpws headWorks cwc well  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsCwcWell;
	
	try
	{
		String finalQuery="select subCompTbl.CW_COLLWELL_CODE ,subCompTbl.DIAMETER,subCompTbl.DEPTH ," +
				"subCompTbl.TYPE_OF_FLOORING,ASSET_NAME";
		finalQuery=finalQuery+query;
	   conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
      
	  ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("CW_COLLWELL_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("CW_COLLWELL_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsCwcWell=new ArrayList();
            cpwsCwcWell.add(sno);
        	try{rs3.next();
            
        	cpwsCwcWell.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsCwcWell.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsCwcWell.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsCwcWell.add("");
        		//System.out.println("exception:"+e);}
        	cpwsCwcWell.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsCwcWell.add(formatData(rs.getString("CW_COLLWELL_CODE")));
        	cpwsCwcWell.add(formatData(rs.getFloat("DIAMETER")));
        	cpwsCwcWell.add(formatData(rs.getFloat("DEPTH")));
        	cpwsCwcWell.add(formatData(rs.getString("TYPE_OF_FLOORING")));
        	
        	cpwsReport.add(cpwsCwcWell);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close(); 
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;
	}
    //cpws pumpesets
    public static ArrayList getAssetCpwsPumpDetailsReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
    {
    	////System.out.println("getting data from CheckListMasterData for cpws pumpset pumpDetails  report");
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGlsr;
		try
		{
			
        	

	String finalQuery="select  subCompTbl.PUMPDET_CODE," +
	"subCompTbl.PUMPCODE,subCompTbl.HP,subCompTbl.TYPE,subCompTbl.DUTY_CON," +
	"subCompTbl.HEAD_MTS,subCompTbl.DISCHARGE_LPM,subCompTbl.STANDBY_HP," +
	"subCompTbl.YEARS_USED,subCompTbl.FAILURE_FREQ,subCompTbl.AVG_HR_PUMPING_DAY," +
	"subCompTbl.REPAIR_COST_YEAR,DECODE(subCompTbl.CAPASITOR,'Y','YES','N','NO')CAPASITOR," +
	"DECODE(subCompTbl.CONTROL_PANEL,'Y','YES','N','NO')CONTROL_PANEL," +
	"subCompTbl.POWER_HOURS,subCompTbl.WORK_HRS,subCompTbl.QTY_WATER_CUM,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        
		   conn = dataSource.getConnection();
	       stmt = conn.createStatement();
		   ////System.out.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        ////System.out.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("PUMPDET_CODE")+"',1,14)=substr(panch_code,1,14)");
	            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("PUMPDET_CODE")+"',1,14)=substr(panch_code,1,14)");
	           
	            cpwsGlsr=new ArrayList();
	            cpwsGlsr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGlsr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsGlsr.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlsr.add("");
	        		//System.out.println("exception:"+e);}
	        	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlsr.add(formatData(rs.getString("PUMPDET_CODE")));
	        	cpwsGlsr.add(formatData(rs.getString("PUMPCODE")));
	        	cpwsGlsr.add(formatData(rs.getInt("HP"))+"");
	            cpwsGlsr.add(formatData(rs.getString("TYPE"))+"");
	        	cpwsGlsr.add(formatData(rs.getString("DUTY_CON"))+"");
	        	cpwsGlsr.add(formatData(rs.getInt("HEAD_MTS"))+"");
	        	cpwsGlsr.add(formatData(rs.getFloat("DISCHARGE_LPM")));
	        	cpwsGlsr.add(formatData(rs.getInt("STANDBY_HP"))+"");
	        	cpwsGlsr.add(formatData(rs.getInt("YEARS_USED"))+"");
	        	cpwsGlsr.add(formatData(rs.getString("FAILURE_FREQ")));
	        	cpwsGlsr.add(formatData(rs.getFloat("AVG_HR_PUMPING_DAY")));
	        	cpwsGlsr.add(formatData(rs.getFloat("REPAIR_COST_YEAR")));
	        	cpwsGlsr.add(formatData(rs.getString("CAPASITOR"))+"");
	        	cpwsGlsr.add(formatData(rs.getString("CONTROL_PANEL")));	
	        	cpwsGlsr.add(formatData(rs.getInt("POWER_HOURS"))+"");
	        	cpwsGlsr.add(formatData(rs.getInt("WORK_HRS"))+"");
	        	cpwsGlsr.add(formatData(rs.getFloat("QTY_WATER_CUM")));
	        	
	            cpwsReport.add( cpwsGlsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();	
		        conn.close();  
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;

    }
    public static AssetCpwsReportBean getSelectionCriteriaOfCheckList(  DataSource dataSource,AssetCpwsReportBean  reportBean)
    {  
    ////System.out.println("getting the selection criteria from checklistamster");
    AssetCpwsReportBean bean=new AssetCpwsReportBean();
    Statement stmt=null;
	ResultSet rs=null;
	try{
		Connection con=dataSource.getConnection();
        stmt=con.createStatement();
        rs=stmt.executeQuery("select circle_office_name from rws_circle_office_tbl " +
		"where circle_office_code='"+reportBean.getCircle()+"'");
		while(rs.next())
		{
			 bean.setCircle(rs.getString(1));
		}
	   rs=stmt.executeQuery("select division_office_name from rws_division_office_tbl" +
			" where circle_office_code='"+reportBean.getCircle()+"' and division_office_code='"+reportBean.getDivision()+"'");
	   while(rs.next())
	   {
	    bean.setDivision(rs.getString(1));
	   }
	rs=stmt.executeQuery("select subdivision_office_name from rws_subdivision_office_tbl where " +
			"circle_office_code='"+reportBean.getCircle()+"' and division_office_code='"+reportBean.getDivision()+"'" +
					" and subdivision_office_code='"+reportBean.getSubdivision()+"'");
	while(rs.next())
	{
		 bean.setSubdivision(rs.getString(1));
	}
	rs=stmt.executeQuery("select mname from rws_mandal_tbl where dcode=(select dcode from rws_district_tbl where " +
			"dname='"+reportBean.getDistrict()+"') and mcode='"+reportBean.getMandal()+"'");
	while(rs.next())
	{
		 bean.setMandal(rs.getString(1));
	}
	
	rs=stmt.executeQuery("select pname from rws_panchayat_tbl where dcode=(select dcode from rws_district_tbl where " +
			"dname='"+reportBean.getDistrict()+"') and mcode='"+reportBean.getMandal()+"' and pcode='"+reportBean.getPanchayat()+"'");
	while(rs.next())
	{
		 bean.setPanchayat(rs.getString(1));
	}
	rs=stmt.executeQuery("select vname from rws_village_tbl where dcode=(select dcode from rws_district_tbl where " +
			"dname='"+reportBean.getDistrict()+"') and mcode='"+reportBean.getMandal()+"' and pcode='"+reportBean.getPanchayat()+"' and " +
					"vcode='"+reportBean.getVillage()+"'");
	while(rs.next())
	{
		 bean.setVillage(rs.getString(1));
	}
	rs=stmt.executeQuery("select type_of_asset_name from rws_asset_type_tbl where " +
			"type_of_asset_code='"+reportBean.getAssetType()+"'");
	while(rs.next())
	{
		 bean.setAssetType(rs.getString(1));
	}
	//rs=stmt.executeQuery("select vname form rws_village_tbl where dcode=(select dcode from rws_district_tbl where 
	//dname='"+formBean.getDistrict()+"') and mcode='"+formBean.getMandal()+"' and pcode='"+formBean.getPanchayat()+"' and 
	//vcode='"+formBean.getVillage()+"'");
	//while(rs.next())
	{
		 bean.setHabitation(reportBean.getHabitation());
	}
	
	//rs=stmt.executeQuery("")
	//while(rs.next())
	/* {
		 bean.setSchemeCode(reportBean.getSchemeCode());
	}*/
	bean.setDistrict(reportBean.getDistrict());
	rs.close();
	stmt.close();
	con.close();
	}catch(Exception e){//System.out.println("Exception in Dynamic Query: getNames()"+e);}
	

	
	
   return   bean;
    }
    //grill down 
    public static ArrayList getDistrictcts(DataSource dataSource,String query)
    {
    	////System.out.println("getting data from CheckListMasterData for districts grill  report");
    	rws_asset_cpws_DrillDownBean cpwsGrill; 
		ArrayList cpwsReport=new ArrayList();
		int tot=0;
		try
		{    
		   conn = dataSource.getConnection();
	       stmt = conn.createStatement();
		   ////System.out.println(query);
		        ResultSet rs=stmt.executeQuery(query);
		        ////System.out.println(query);
		        try{String sno="1";
	        while(rs.next())
	         {     
	        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno(sno);
	        	cpwsGrill.setName(rs.getString("DNAME"));
	        	cpwsGrill.setTotal(rs.getString("COUNT"));
	        	tot=tot+Integer.parseInt(rs.getString("count"));
	            cpwsReport.add( cpwsGrill);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 }
		        
		        cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno("**");
	        	cpwsGrill.setName("Total");
	        	cpwsGrill.setTotal(Integer.toString(tot));
	        	cpwsReport.add(cpwsGrill);
		        stmt.close();	
		        conn.close();  
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;	
    }	
          public static ArrayList getMandals(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv)
         {
          	    ////System.out.println("getting data from CheckListMasterData for districts grill  report");
 	    	
    	        rws_asset_cpws_DrillDownBean cpwsGrill=null; 
		        ArrayList cpwsReport=new ArrayList();
    	     
		        String query="";
		        String q1="select count(*)COUNT,dname ,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
    			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
    			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
    			" and substr(a.hab_code,1,2) = man.dcode " +
    			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
    			" and d.dcode=man.dcode " +
    			"and man.dcode='"+Dcode+"'";
		        
		        String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
		        String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
    	        String q3= " group by dname,man.MNAME order by man.MNAME";
    	        if(!(Div.equals("")))
    	        {  
    	        	////System.out.println("in div block");
    	        	query=q1+q2;
    	        	 if(!(subDiv.equals("")))
    	        	 {
    	        	 query=query+q4;	
    	        	 }
    	        }  query=query+q3;
    	        if((Div.equals("")))
    	        {
    	          query=q1+q3;
    	        }
    	        int tot=0;
    			try
    			{    
    			   conn = dataSource.getConnection();
    		       stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    			   ////System.out.println(query);
    			        ResultSet rs=stmt.executeQuery(query);
    			        ////System.out.println(query);
    			        try{String sno="1";
    		        while(rs.next())
    		         {     
    		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
    		        	cpwsGrill.setSno(sno);
    		        	cpwsGrill.setName(rs.getString("Mandal"));
    		        	cpwsGrill.setTotal(rs.getString("COUNT"));
    		            tot=tot+Integer.parseInt(rs.getString("count"));
    		            
        		        ////System.out.println("Total Districts is "+tot);
    		            cpwsReport.add(cpwsGrill);
    		            int no=Integer.parseInt(sno);
    		        	no++;
    		            sno=""+no;
    		        	
    		         }
    		        
    		        
    			    }
    			        catch(Exception e)
    					 {
    					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    					 	java.util.Vector ExceptionReport =new java.util.Vector();
    					 	ExceptionReport.add(e);
    					 	cpwsReport.add(ExceptionReport);
    					 	return 	cpwsReport;
    					 }
    			     
    			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
        		        	cpwsGrill.setSno("**");
        		        	cpwsGrill.setName("Total");
        		        	cpwsGrill.setTotal(Integer.toString(tot));
        		        	cpwsReport.add(cpwsGrill);
        		        	        		        
    			        stmt.close();	
    			        conn.close();  
    			}
    			
    			 catch(Exception e)
    			 {
    			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    			 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
    			 }
    			 
    				
    				return  cpwsReport;	

     }
        public static String  getDcode(DataSource dataSource,String District)
        {
        	////System.out.println("in getDcode of checkListMasterdata");
        	////System.out.println("district is"+District);
    	  String dcode="";
    	try
    
		{
    	   conn = dataSource.getConnection();
	       stmt = conn.createStatement();
	       ResultSet  res=stmt.executeQuery("select dcode from rws_district_tbl where trim(dname)='"+District+"'");
	       		
	       res.next();
	       dcode=res.getString(1);
	       stmt.close();
		   conn.close();
	    }
    	catch(Exception e)
		{ 
    		//System.out.println("Exception in geting data fro dcode"+e);
		}
    	////System.out.println("XXXXXXXdcode is YYYYYYYY"+dcode);
    	return dcode;
     }
        public static String  getMcode(DataSource dataSource,String Mandal,String dcode)
        {
        	////System.out.println(" in getting data from check list master for mcode ");
    	  String mcode="";
    	try
    
		{
    		////System.out.println(Mandal);
    		////System.out.println(dcode);
    		
    		String query="select mcode from rws_mandal_tbl where trim(mname)='"+Mandal+"' And DCODE='"+dcode+"'";
    		////System.out.println(query);
    		
    	   conn = dataSource.getConnection();
	       stmt = conn.createStatement();
	       ResultSet  res=stmt.executeQuery(query);
	       		
	       res.next();
	       mcode=res.getString(1);
	       stmt.close();
		   conn.close();
	    }
    	catch(Exception e)
		{ 
    		//System.out.println("Exception in getting data from check list master for mcode "+e);
    		
		}
    	////System.out.println(mcode);
    	return mcode;
     }
        //code added
////    /HANDPUMPS SOURCE BOREWELL
    	public static ArrayList getAssetHandpumpsBorewellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
    	{
    		////System.out.println("getting data from CheckListMasterData for cpws source intakeWell  report");
    		ArrayList cpwsReport=new ArrayList();
    		ArrayList record;
    		try
    		{
    			String finalQuery="select panch_name, pp.pname pname, subCompTbl.LOCATION,subCompTbl.DRILL_YEAR,subCompTbl.DIAMETER" +
    			",subCompTbl.CASING,subCompTbl.STATUS,subCompTbl.GEN_CONDITION"+
    			",subCompTbl.GI_NO ,subCompTbl.PAINTED ,subCompTbl.STATIC_WL,subCompTbl.SUMMER_WL"+
    			",subCompTbl.P_COND ,subCompTbl.DRY_DURING,subCompTbl.SERVICE ,subCompTbl.SER_NO"+
    			",subCompTbl.SER_HRS "+
    			",subCompTbl.REPAIRS ,subCompTbl.PLATFORM_CONDITION,subCompTbl.DRAIN,subCompTbl.DRAIN_CONDITION "+
    			",subCompTbl.DRAIN_SD ,subCompTbl.DRAIN_LP,subCompTbl.HYGIENE ,subCompTbl.AVG_TIME"+
    			",subCompTbl.P_YEILD ,subCompTbl.PYEILD_LOCAL,subCompTbl.PERIOD ,subCompTbl.ASSET_CODE"+
    			",subCompTbl.DEPTH  ,subCompTbl.HP_CODE,ASSET_NAME";
    			finalQuery=finalQuery+query;
    	        
    		    ////System.out.println("final query is: "+finalQuery);
    			//String finalQuery="";/////
    			
    		    conn = dataSource.getConnection();
    	    	stmt = conn.createStatement();
    	    	// ohbr
    	    	    ResultSet rs2=stmt.executeQuery( finalQuery);
    		        ////System.out.println( finalQuery);
    		     try
    			   {
    		        String sno="1";
    		        
    		        
    	            while(rs2.next())
    	           { 
    	            	Statement stmt2 = conn.createStatement();
    		    	    Statement stmt3 = conn.createStatement();
    		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("HP_CODE")+"',1,14)=substr(panch_code,1,14)");
    		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("HP_CODE")+"',1,14)=substr(panch_code,1,14)");
    		           
    		            record=new ArrayList();
    		            record.add(sno);
    		        	try{rs3.next();
    		            
    		        	 record.add(rs3.getString("PNAME"));
    		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
    		            }catch(Exception e){
    		            	 record.add("");
    		            	//System.out.println("Exception"+e);
    		            	}
    		        	try{rs4.next();
    		        	 record.add(rs4.getString("PANCH_NAME"));
    		        	}
    		        	catch(Exception e){
    		        		 record.add("");
    		        		//System.out.println("exception:"+e);}
    	             record.add(formatData(rs2.getString("ASSET_NAME"))); 
    	             record.add(formatData(rs2.getString("HP_CODE")));  
    	             record.add(formatData(rs2.getString("LOCATION")));     
    				 record.add(formatData(rs2.getString("DRILL_YEAR")));    
    				 record.add(formatData(rs2.getFloat("DIAMETER")));    
    				 record.add(formatData(rs2.getString("CASING")));     
    				 record.add(formatData(rs2.getString("STATUS")));     
    				 record.add(formatData(rs2.getString("GEN_CONDITION")));     
    				 record.add(formatData(rs2.getInt("GI_NO"))+"");     
    				 record.add(formatData(rs2.getString("PAINTED")));     
    				 record.add(formatData(rs2.getFloat("STATIC_WL")));    
    				 record.add(formatData(rs2.getFloat("SUMMER_WL")));     
    				 record.add(formatData(rs2.getString("P_COND")));     
    				 record.add(formatData(rs2.getInt("DRY_DURING"))+"");   
    				 record.add(formatData(rs2.getString("SERVICE"))+"");    
    				 record.add(formatData(rs2.getInt("SER_NO"))+"");    
    				 record.add(formatData(rs2.getFloat("SER_HRS")));     
    				 record.add(formatData(rs2.getString("REPAIRS")));     
    				 record.add(formatData(rs2.getString("PLATFORM_CONDITION")));     
    				 record.add(formatData(rs2.getString("DRAIN")));   
    				 record.add(formatData(rs2.getString("DRAIN_CONDITION")));     
    				 record.add(formatData(rs2.getString("DRAIN_SD")));      
    				 record.add(formatData(rs2.getString("DRAIN_LP")));    
    				 record.add(formatData(rs2.getString("HYGIENE")));     
    				 record.add(formatData(rs2.getFloat("AVG_TIME")));    
    				 record.add(formatData(rs2.getInt("P_YEILD"))+"");    
    				 record.add(formatData(rs2.getString("PYEILD_LOCAL")));     
    				 record.add(formatData(rs2.getString("PERIOD")));     
    				 record.add(formatData(rs2.getString("ASSET_CODE")));    
    				 record.add(formatData(rs2.getFloat("DEPTH")));     
    				
                   	cpwsReport.add( record);
    	        	int no=Integer.parseInt(sno);
    	        	no++;
    	            sno=""+no;
    	           }
    		    }
    		        catch(Exception e)
    				 {
    				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    				 	java.util.Vector ExceptionReport =new java.util.Vector();
    				 	ExceptionReport.add(e);
    				 	cpwsReport.add(ExceptionReport);
    				 	return 	cpwsReport;
    				 }
    		        stmt.close();
    		       conn.close();
    	        
    		}
    		 catch(Exception e)
    		 {
    		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    		 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
    		 }
    			
    			return  cpwsReport;

    	}


    	
    	
    	
    	
    	
    	
    	////// Intakewell
    	public static ArrayList getAssetCpwsSourceIntakewellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
    	{
    		////System.out.println("getting data from CheckListMasterData for cpws source intakeWell  report");
    		ArrayList cpwsReport=new ArrayList();
    		ArrayList cpwsIntakeWell;
    		try
    		{
    			
    			

    			String finalQuery="select  subCompTbl.SOURCE_CODE,subCompTbl.SOURCE_NAME,subCompTbl.SOURCE_TYPE_CODE" +
    			",subCompTbl.SUBSOURCE_TYPE_CODE,subCompTbl.HAB_CODE,subCompTbl.NO_OF_HABITAITONS_COVERD"+
    			",subCompTbl.POPULATION_BENIFITED,subCompTbl.SEASONAL,subCompTbl.PRESENT_CONDITION,subCompTbl.WATER_QUALITY"+
    			",subCompTbl.STATIC_WATER_LEVEL,subCompTbl.SUMMER_WATER_LEVEL,subCompTbl.YIELD,subCompTbl.DIST_NEAR_PRIVATE_SOURCE"+
    			",subCompTbl.LOCATION";
    	        finalQuery=finalQuery+query;
    	        
    		    ////System.out.println("final query:  "+finalQuery);
    			//String finalQuery="";/////
    			
    		    conn = dataSource.getConnection();
    	    	stmt = conn.createStatement();
    	    	// ohbr
    	    	    ResultSet rs2=stmt.executeQuery( finalQuery);
    		        ////System.out.println( finalQuery);
    		     try
    			   {
    		        String sno="1";
    	            while(rs2.next())
    	           { 
    	            		            	

    	            	Statement stmt2 = conn.createStatement();
    		    	    Statement stmt3 = conn.createStatement();
    		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
    		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
    		           
    		            cpwsIntakeWell=new ArrayList();
    		            cpwsIntakeWell.add(sno);
    		        	try{rs3.next();
    		            
    		        	 cpwsIntakeWell.add(rs3.getString("PNAME"));
    		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
    		            }catch(Exception e){
    		            	 cpwsIntakeWell.add("");
    		            	//System.out.println("Exception"+e);
    		            	}
    		        	try{rs4.next();
    		        	 cpwsIntakeWell.add(rs4.getString("PANCH_NAME"));
    		        	}
    		        	catch(Exception e){
    		        		 cpwsIntakeWell.add("");
    		        		//System.out.println("exception:"+e);}
    	            cpwsIntakeWell.add(formatData(rs2.getString("SOURCE_CODE")));
    	            cpwsIntakeWell.add(formatData(rs2.getString("SOURCE_NAME")));
    	            cpwsIntakeWell.add(formatData(rs2.getInt("SOURCE_TYPE_CODE"))+"");
    	            cpwsIntakeWell.add(formatData(rs2.getInt("SUBSOURCE_TYPE_CODE"))+"");
    	            cpwsIntakeWell.add(formatData(rs2.getString("HAB_CODE")));
    	            cpwsIntakeWell.add(formatData(rs2.getInt("NO_OF_HABITAITONS_COVERD"))+"");
    	            cpwsIntakeWell.add(formatData(rs2.getInt("POULATION_BENIFITED"))+"");
    	            cpwsIntakeWell.add(formatData(rs2.getString("SEASONAL")));
    	            cpwsIntakeWell.add(formatData(rs2.getString("PRESENT_CONDITION")));
    	            cpwsIntakeWell.add(formatData(rs2.getString("WATER_QUALITY")));
    	            cpwsIntakeWell.add(formatData(rs2.getInt("STATIC_WATER_LEVEL"))+"");
    	            cpwsIntakeWell.add(formatData(rs2.getInt("SUMMER_WATER_LEVEL"))+"");
    	            cpwsIntakeWell.add(formatData(rs2.getString("YIELD")));
    	            cpwsIntakeWell.add(formatData(rs2.getInt("DIST_NEAR_PRIVATE_SOURCE"))+"");
    	            cpwsIntakeWell.add(formatData(rs2.getString("LOCATION")));
    	        	cpwsReport.add( cpwsIntakeWell);
    	        	int no=Integer.parseInt(sno);
    	        	no++;
    	            sno=""+no;
    	           }
    		    }
    		        catch(Exception e)
    				 {
    				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    				 	java.util.Vector ExceptionReport =new java.util.Vector();
    				 	ExceptionReport.add(e);
    				 	cpwsReport.add(ExceptionReport);
    				 	return 	cpwsReport;
    				 }
    		        stmt.close();
    		       conn.close();
    	        
    		}
    		 catch(Exception e)
    		 {
    		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    		 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
    		 }
    			
    			return  cpwsReport;

    	}

////    cpws source borewell
    	public static ArrayList getAssetCpwsSourceBorewellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
    	{
    		////System.out.println("getting data from CheckListMasterData for cpws source Borewell  report");
    		ArrayList cpwsReport=new ArrayList();
    		ArrayList cpwsBorewell;
    		try
    		{
    			
    			

    			String finalQuery="select   subCompTbl.SOURCE_CODE,subCompTbl.SOURCE_NAME,subCompTbl.SOURCE_TYPE_CODE" +
    					",subCompTbl.SUBSOURCE_TYPE_CODE,subCompTbl.HAB_CODE,subCompTbl.NO_OF_HABITAITONS_COVERD" +
    					",subCompTbl.POPULATION_BENIFITED,subCompTbl.SEASONAL,subCompTbl.PRESENT_CONDITION,subCompTbl.WATER_QUALITY"+
    					",subCompTbl.STATIC_WATER_LEVEL,subCompTbl.SUMMER_WATER_LEVEL,subCompTbl.YIELD,subCompTbl.DIST_NEAR_PRIVATE_SOURCE"+
    					",subCompTbl.LOCATION";
    	        finalQuery=finalQuery+query;
    	        ////System.out.println("final query is :"+finalQuery);
    	        
    		    
    			//String finalQuery="";/////
    			
    		    conn = dataSource.getConnection();
    	    	stmt = conn.createStatement();
    	    	// ohbr
    	    	    ResultSet rs2=stmt.executeQuery( finalQuery);
    		        ////System.out.println( finalQuery);
    		     try
    			   {
    		        String sno="1";
    	            while(rs2.next())
    	           { 
    	            		            	

    	            	Statement stmt2 = conn.createStatement();
    		    	    Statement stmt3 = conn.createStatement();
    		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
    		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
    		           
    		            cpwsBorewell=new ArrayList();
    		            cpwsBorewell.add(sno);
    		        	try{rs3.next();
    		            
    		        	cpwsBorewell.add(rs3.getString("PNAME"));
    		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
    		            }catch(Exception e){
    		            	cpwsBorewell.add("");
    		            	//System.out.println("Exception"+e);
    		            	}
    		        	try{rs4.next();
    		        	cpwsBorewell.add(rs4.getString("PANCH_NAME"));
    		        	}
    		        	catch(Exception e){
    		        		cpwsBorewell.add("");
    		        		//System.out.println("exception:"+e);}
    	            cpwsBorewell.add(formatData(rs2.getString("SOURCE_CODE")));
    	            cpwsBorewell.add(formatData(rs2.getString("SOURCE_NAME")));
    	            cpwsBorewell.add(formatData(rs2.getInt("SOURCE_TYPE_CODE"))+"");
    	            cpwsBorewell.add(formatData(rs2.getInt("SUBSOURCE_TYPE_CODE"))+"");
    	            cpwsBorewell.add(formatData(rs2.getString("HAB_CODE")));
    	            cpwsBorewell.add(formatData(rs2.getInt("NO_OF_HABITAITONS_COVERD"))+"");
    	            cpwsBorewell.add(formatData(rs2.getInt("POULATION_BENIFITED"))+"");
    	            cpwsBorewell.add(formatData(rs2.getString("SEASONAL")));
    	            cpwsBorewell.add(formatData(rs2.getString("PRESENT_CONDITION")));
    	            cpwsBorewell.add(formatData(rs2.getString("WATER_QUALITY")));
    	            cpwsBorewell.add(formatData(rs2.getInt("STATIC_WATER_LEVEL"))+"");
    	            cpwsBorewell.add(formatData(rs2.getInt("SUMMER_WATER_LEVEL"))+"");
    	            cpwsBorewell.add(formatData(rs2.getString("YIELD")));
    	            cpwsBorewell.add(formatData(rs2.getInt("DIST_NEAR_PRIVATE_SOURCE"))+"");
    	            cpwsBorewell.add(formatData(rs2.getString("LOCATION")));
    	        	cpwsReport.add( cpwsBorewell);
    	        	int no=Integer.parseInt(sno);
    	        	no++;
    	            sno=""+no;
    	           }
    		    }
    		        catch(Exception e)
    				 {
    				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    				 	java.util.Vector ExceptionReport =new java.util.Vector();
    				 	ExceptionReport.add(e);
    				 	cpwsReport.add(ExceptionReport);
    				 	return 	cpwsReport;
    				 }
    		        stmt.close();
    		       conn.close();
    	        
    		}
    		 catch(Exception e)
    		 {
    		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    		 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
    		 }
    			
    			return  cpwsReport;

    	}


    	
    	
////    cpws source borewell end
    	
    	
//////////    / cpws source infiltration well
    	public static ArrayList getAssetCpwsSourceInfiltrationwellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
    	{
    		////System.out.println("getting data from CheckListMasterData for cpws source infiltration well  report");
    		ArrayList cpwsReport=new ArrayList();
    		ArrayList cpwsInfiltrationwell;
    		try
    		{
    			
    			

    			String finalQuery="select  subCompTbl.SOURCE_CODE,subCompTbl.SOURCE_NAME,subCompTbl.SOURCE_TYPE_CODE" +
    					",subCompTbl.SUBSOURCE_TYPE_CODE,subCompTbl.HAB_CODE,subCompTbl.NO_OF_HABITAITONS_COVERD" +
    					",subCompTbl.POPULATION_BENIFITED,subCompTbl.SEASONAL,subCompTbl.PRESENT_CONDITION,subCompTbl.WATER_QUALITY"+
    					",subCompTbl.STATIC_WATER_LEVEL,subCompTbl.SUMMER_WATER_LEVEL,subCompTbl.YIELD,subCompTbl.DIST_NEAR_PRIVATE_SOURCE"+
    					",subCompTbl.LOCATION";
    	        finalQuery=finalQuery+query;
    	        ////System.out.println("final query is :"+finalQuery);
    	        
    		    
    			//String finalQuery="";/////
    			
    		    conn = dataSource.getConnection();
    	    	stmt = conn.createStatement();
    	    	// ohbr
    	    	    ResultSet rs2=stmt.executeQuery( finalQuery);
    		        ////System.out.println( finalQuery);
    		     try
    			   {
    		        String sno="1";
    	            while(rs2.next())
    	           { 
    	            		            	
    	            	Statement stmt2 = conn.createStatement();
    		    	    Statement stmt3 = conn.createStatement();
    		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
    		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
    		           
    		            cpwsInfiltrationwell=new ArrayList();
    		            cpwsInfiltrationwell.add(sno);
    		        	try{rs3.next();
    		            
    		        	cpwsInfiltrationwell.add(rs3.getString("PNAME"));
    		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
    		            }catch(Exception e){
    		            	cpwsInfiltrationwell.add("");
    		            	//System.out.println("Exception"+e);
    		            	}
    		        	try{rs4.next();
    		        	cpwsInfiltrationwell.add(rs4.getString("PANCH_NAME"));
    		        	}
    		        	catch(Exception e){
    		        		cpwsInfiltrationwell.add("");
    		        		//System.out.println("exception:"+e);}
    	            cpwsInfiltrationwell.add(formatData(rs2.getString("SOURCE_CODE")));
    	            cpwsInfiltrationwell.add(formatData(rs2.getString("SOURCE_NAME")));
    	            cpwsInfiltrationwell.add(formatData(rs2.getInt("SOURCE_TYPE_CODE"))+"");
    	            cpwsInfiltrationwell.add(formatData(rs2.getInt("SUBSOURCE_TYPE_CODE"))+"");
    	            cpwsInfiltrationwell.add(formatData(rs2.getString("HAB_CODE")));
    	            cpwsInfiltrationwell.add(formatData(rs2.getInt("NO_OF_HABITAITONS_COVERD"))+"");
    	            cpwsInfiltrationwell.add(formatData(rs2.getInt("POULATION_BENIFITED"))+"");
    	            cpwsInfiltrationwell.add(formatData(rs2.getString("SEASONAL")));
    	            cpwsInfiltrationwell.add(formatData(rs2.getString("PRESENT_CONDITION")));
    	            cpwsInfiltrationwell.add(formatData(rs2.getString("WATER_QUALITY")));
    	            cpwsInfiltrationwell.add(formatData(rs2.getInt("STATIC_WATER_LEVEL"))+"");
    	            cpwsInfiltrationwell.add(formatData(rs2.getInt("SUMMER_WATER_LEVEL"))+"");
    	            cpwsInfiltrationwell.add(formatData(rs2.getString("YIELD")));
    	            cpwsInfiltrationwell.add(formatData(rs2.getInt("DIST_NEAR_PRIVATE_SOURCE"))+"");
    	            cpwsInfiltrationwell.add(formatData(rs2.getString("LOCATION")));
    	        	cpwsReport.add( cpwsInfiltrationwell);
    	        	int no=Integer.parseInt(sno);
    	        	no++;
    	            sno=""+no;
    	           }
    		    }
    		        catch(Exception e)
    				 {
    				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    				 	java.util.Vector ExceptionReport =new java.util.Vector();
    				 	ExceptionReport.add(e);
    				 	cpwsReport.add(ExceptionReport);
    				 	return 	cpwsReport;
    				 }
    		        stmt.close();
    		       conn.close();
    	        
    		}
    		 catch(Exception e)
    		 {
    		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    		 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
    		 }
    			
    			return  cpwsReport;

    	}

////    /cpws source rotary borewell
    	public static ArrayList getAssetCpwsSourceRotaryBorewellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
    	{
    		////System.out.println("getting data from CheckListMasterData for cpws source Rotary bore well  report");
    		ArrayList cpwsReport=new ArrayList();
    		ArrayList cpwsRotaryBorewell;
    		try
    		{
    			
    			

    			String finalQuery="select subCompTbl.SOURCE_CODE,subCompTbl.SOURCE_NAME,subCompTbl.SOURCE_TYPE_CODE" +
    					",subCompTbl.SUBSOURCE_TYPE_CODE,subCompTbl.HAB_CODE,subCompTbl.NO_OF_HABITAITONS_COVERD" +
    					",subCompTbl.POPULATION_BENIFITED,subCompTbl.SEASONAL,subCompTbl.PRESENT_CONDITION,subCompTbl.WATER_QUALITY"+
    					",subCompTbl.STATIC_WATER_LEVEL,subCompTbl.SUMMER_WATER_LEVEL,subCompTbl.YIELD,subCompTbl.DIST_NEAR_PRIVATE_SOURCE"+
    					",subCompTbl.LOCATION";
    	        finalQuery=finalQuery+query;
    	        ////System.out.println("final query is :"+finalQuery);
    	        
    		    
    			//String finalQuery="";/////
    			
    		    conn = dataSource.getConnection();
    	    	stmt = conn.createStatement();
    	    	// ohbr
    	    	    ResultSet rs2=stmt.executeQuery( finalQuery);
    		        ////System.out.println( finalQuery);
    		     try
    			   {
    		        String sno="1";
    	            while(rs2.next())
    	           { 
    	            		            	
    	            	Statement stmt2 = conn.createStatement();
    		    	    Statement stmt3 = conn.createStatement();
    		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
    		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
    		           
    		            cpwsRotaryBorewell=new ArrayList();
    		            cpwsRotaryBorewell.add(sno);
    		        	try{rs3.next();
    		            
    		        	cpwsRotaryBorewell.add(rs3.getString("PNAME"));
    		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
    		            }catch(Exception e){
    		            	cpwsRotaryBorewell.add("");
    		            	//System.out.println("Exception"+e);
    		            	}
    		        	try{rs4.next();
    		        	cpwsRotaryBorewell.add(rs4.getString("PANCH_NAME"));
    		        	}
    		        	catch(Exception e){
    		        		cpwsRotaryBorewell.add("");
    		        		//System.out.println("exception:"+e);}
    	            cpwsRotaryBorewell.add(formatData(rs2.getString("PANCH_NAME")));
    	            cpwsRotaryBorewell.add(formatData(rs2.getString("SOURCE_CODE")));
    	            cpwsRotaryBorewell.add(formatData(rs2.getString("SOURCE_NAME")));
    	            cpwsRotaryBorewell.add(formatData(rs2.getInt("SOURCE_TYPE_CODE"))+"");
    	            cpwsRotaryBorewell.add(formatData(rs2.getInt("SUBSOURCE_TYPE_CODE"))+"");
    	            cpwsRotaryBorewell.add(formatData(rs2.getString("HAB_CODE")));
    	            cpwsRotaryBorewell.add(formatData(rs2.getInt("NO_OF_HABITAITONS_COVERD"))+"");
    	            cpwsRotaryBorewell.add(formatData(rs2.getInt("POULATION_BENIFITED"))+"");
    	            cpwsRotaryBorewell.add(formatData(rs2.getString("SEASONAL")));
    	            cpwsRotaryBorewell.add(formatData(rs2.getString("PRESENT_CONDITION")));
    	            cpwsRotaryBorewell.add(formatData(rs2.getString("WATER_QUALITY")));
    	            cpwsRotaryBorewell.add(formatData(rs2.getInt("STATIC_WATER_LEVEL"))+"");
    	            cpwsRotaryBorewell.add(formatData(rs2.getInt("SUMMER_WATER_LEVEL"))+"");
    	            cpwsRotaryBorewell.add(formatData(rs2.getString("YIELD")));
    	            cpwsRotaryBorewell.add(formatData(rs2.getInt("DIST_NEAR_PRIVATE_SOURCE"))+"");
    	            cpwsRotaryBorewell.add(formatData(rs2.getString("LOCATION")));
    	        	cpwsReport.add( cpwsRotaryBorewell);
    	        	int no=Integer.parseInt(sno);
    	        	no++;
    	            sno=""+no;
    	           }
    		    }
    		        catch(Exception e)
    				 {
    				 	//System.out.println("error in getig dat in Rotary borewell CheckListMasterData"+e);
    				 	java.util.Vector ExceptionReport =new java.util.Vector();
    				 	ExceptionReport.add(e);
    				 	cpwsReport.add(ExceptionReport);
    				 	return 	cpwsReport;
    				 }
    		        stmt.close();
    		       conn.close();
    	        
    		}
    		 catch(Exception e)
    		 {
    		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    		 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
    		 }
    			
    			return  cpwsReport;

    	}

    	
        
        //code added
    	
    	
    	
    	
    	public static ArrayList getCpwsSourceDistrictcts(DataSource dataSource,String source_type, String subSourceType)throws Exception
    	{
    		////System.out.println("getting data from CheckListMasterData for cpws source Rotary bore well  report");
    		ArrayList cpwsReport=new ArrayList();
    		ArrayList cpwsRotaryBorewell;
    		try
    		{
    			
    			

    			String finalQuery="select count(*)COUNT,dname from rws_district_tbl d,rws_source_tbl s where " +
    					"substr(s.hab_code,1,2)=d.dcode and source_type_code='"+source_type+"' and subsource_type_code='"+subSourceType+"'"+
    					" group by dname";
    	       
    	        ////System.out.println("final query is :"+finalQuery);
    	        
    		    
    			
    			
    		    conn = dataSource.getConnection();
    	    	stmt = conn.createStatement();
    	    	
    	    	    ResultSet rs2=stmt.executeQuery(finalQuery);
    	    	   ////System.out.println("final query is :"+finalQuery);
    		     try
    			   {
    		        String sno="1";
    	            while(rs2.next())
    	           { 
    	            ////System.out.println("in while");          	
    	            cpwsRotaryBorewell=new ArrayList();
    	            cpwsRotaryBorewell.add(sno);
    	            cpwsRotaryBorewell.add(rs2.getString("DNAME"));
    	            cpwsRotaryBorewell.add(rs2.getString("COUNT"));
    	            cpwsReport.add(cpwsRotaryBorewell);
    	        	int no=Integer.parseInt(sno);
    	        	no++;
    	            sno=""+no;
    	           }
    		    }
    		        catch(Exception e)
    				 {
    				 	//System.out.println("error in getig dat in Rotary borewell CheckListMasterData"+e);
    				 	java.util.Vector ExceptionReport =new java.util.Vector();
    				 	ExceptionReport.add(e);
    				 	cpwsReport.add(ExceptionReport);
    				 	return 	cpwsReport;
    				 }
    		        stmt.close();
    		       conn.close();
    	        
    		}
    		 catch(Exception e)
    		 {
    		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    		 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
    		 }
    			
    			return  cpwsReport;

    	}
    	
    	public static ArrayList getSourceMandals(DataSource dataSource,String source_type, String subSourceType, String dcode)throws Exception
    	{
    		////System.out.println("getting data from CheckListMasterData for cpws source Rotary bore well  report");
    		ArrayList cpwsReport=new ArrayList();
    		ArrayList cpwsRotaryBorewell;
    		try
    		{
    			
    			

    			String finalQuery="select count(*),trim(mname) from rws_mandal_tbl m," +
    					"rws_source_tbl s where substr(s.hab_code,1,2)=m.dcode and " +
    					"substr(s.hab_code,6,2)=m.mcode and source_type_code='"+source_type+"' and " +
						"substr(s.hab_code,1,2)='"+dcode+"'"+
    					" and subsource_type_code='"+subSourceType+"'group by mname";
    	        ////System.out.println("final query is :"+finalQuery);
    	        
    		    
    			//String finalQuery="";/////
    			
    		    conn = dataSource.getConnection();
    	    	stmt = conn.createStatement();
    	    	// ohbr
    	    	    ResultSet rs2=stmt.executeQuery( finalQuery);
    		        ////System.out.println( finalQuery);
    		     try
    			   {
    		        String sno="1";
    	            while(rs2.next())
    	           { 
    	            		            	
    	            cpwsRotaryBorewell=new ArrayList();
    	            cpwsRotaryBorewell.add(sno);
    	            cpwsRotaryBorewell.add(rs2.getString("MNAME"));
    	            cpwsRotaryBorewell.add(rs2.getString("COUNT"));
    	            cpwsReport.add(cpwsRotaryBorewell);
    	        	int no=Integer.parseInt(sno);
    	        	no++;
    	            sno=""+no;
    	           }
    		    }
    		        catch(Exception e)
    				 {
    				 	//System.out.println("error in getig dat in Rotary borewell CheckListMasterData"+e);
    				 	java.util.Vector ExceptionReport =new java.util.Vector();
    				 	ExceptionReport.add(e);
    				 	cpwsReport.add(ExceptionReport);
    				 	return 	cpwsReport;
    				 }
    		        stmt.close();
    		       conn.close();
    	        
    		}
    		 catch(Exception e)
    		 {
    		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
    		 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
    		 }
    			
    			return  cpwsReport;
    		
    	}
    	
    	//pws
    	public static ArrayList getAssetPwsReservoirsOhsrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
		{
			////System.out.println("getting data from CheckListMasterData for cpws reservoirs ohsr  report");
			ArrayList cpwsReport=new ArrayList();
			ArrayList cpwsOhsr;
			try
			{
				String finalQuery="select subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOCATION,subCompTbl.OHSR_CAP_LTS," +
						"subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_MADE," +
						"subCompTbl.OHSR_HT,subCompTbl.OHSR_COND,subCompTbl.OHSR_FILL_HRS" +
						",subCompTbl.OHSR_EMPTY,	decode(subCompTbl.OHSR_HYG,'G','GOOD'," +
						"'B','BAD')OHSR_HYG,decode(subCompTbl.OHSR_FEN,'Y','YES','N','NO')" +
						"OHSR_FEN,ASSET_NAME";
		        finalQuery=finalQuery+query;
			    conn = dataSource.getConnection();
		    	stmt = conn.createStatement();
		    	
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        ////System.out.println( finalQuery);
			     try
				   {
			     	
			     				     
			     	
			     	String sno="1";
		            while(rs2.next())
		           { 
		            	
		            Statement stmt2 = conn.createStatement();
		    	    Statement stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("OHSR_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("OHSR_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ////System.out.println(rs2.getString("OHSR_CODE"));
		            cpwsOhsr=new ArrayList();
		        	cpwsOhsr.add(sno);
		            try{rs3.next();
		            
		        	cpwsOhsr.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	cpwsOhsr.add("");
		            	//System.out.println("Exception"+e);
		            	}
		        	try{rs4.next();
		        	cpwsOhsr.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e){
		        		cpwsOhsr.add("");
		        		//System.out.println("exception:"+e);}
		        	 cpwsOhsr.add(formatData(rs2.getString("ASSET_NAME")));
		            cpwsOhsr.add(formatData(rs2.getString("OHSR_CODE")));
		        	cpwsOhsr.add(formatData(rs2.getString("OHSR_LOCATION")));
		        	cpwsOhsr.add(formatData(rs2.getFloat("OHSR_CAP_LTS")));
		            cpwsOhsr.add(formatData(rs2.getFloat("OHSR_NO_OF_FILLING")));
		            cpwsOhsr.add(formatData(rs2.getString("OHSR_MADE")));
		        	cpwsOhsr.add(formatData(rs2.getFloat("OHSR_HT")));
		        	cpwsOhsr.add(formatData(rs2.getString("OHSR_COND")));
		        	cpwsOhsr.add(formatData(rs2.getFloat("OHSR_FILL_HRS")));
		        	cpwsOhsr.add(formatData(rs2.getFloat("OHSR_EMPTY")));
		        	cpwsOhsr.add(formatData(rs2.getString("OHSR_HYG")));
		        	cpwsOhsr.add(formatData(rs2.getString("OHSR_FEN")));
		        	cpwsReport.add( cpwsOhsr);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			        stmt.close();
			       conn.close();
		        
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
				
				return  cpwsReport;

		}
    	
		
    	public static ArrayList getAssetPwsReservoirsGlsrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
		{
			////System.out.println("getting data from CheckListMasterData for pws Glsr  report");
			ArrayList cpwsReport=new ArrayList();
			ArrayList pwsOhsr;
			try
			{

	        	
	String finalQuery="select subCompTbl.GLSR_CODE," +
	"subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_NO,subCompTbl.GLSR_MADE," +
	"subCompTbl.GLSR_COND,subCompTbl.GLSR_FILL_HRS,subCompTbl.GLSR_EMPTY_HRS," +
	"DECODE(subCompTbl.GLSR_DRA_COND,'Y','YES','N','NO')GLSR_DRA_COND,DECODE(subCompTbl.GLSR_HYG,'G','GOOD','B','BAD')GLSR_HYG,ASSET_NAME";
		        finalQuery=finalQuery+query;
			    conn = dataSource.getConnection();
		    	stmt = conn.createStatement();
		    	
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        ////System.out.println( finalQuery);
			     try
				   {
			     
			     	
			     	String sno="1";
		            while(rs2.next())
		           { 
		            	
		            Statement stmt2 = conn.createStatement();
		    	    Statement stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("GLSR_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("GLSR_CODE")+"',1,14)=substr(panch_code,1,14)");
		            
		            pwsOhsr=new ArrayList();
		            pwsOhsr.add(sno);
		            try{rs3.next();
		            
		            pwsOhsr.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsOhsr.add("");
		            	//System.out.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        	    pwsOhsr.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsOhsr.add("");
		        		//System.out.println("exception:"+e);
		        	}
		        	pwsOhsr.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_CODE")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_LOC")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_CAP_LTS")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_NO")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_MADE")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_COND")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_FILL_HRS")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_EMPTY_HRS")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_DRA_COND")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_HYG")));
		        	cpwsReport.add( pwsOhsr);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			        stmt.close();
			       conn.close();
		        
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
				
				return  cpwsReport;

		}
    	
    	
		
		public static ArrayList getAssetPwsReservoirsCisternsReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
		{
			////System.out.println("getting data from CheckListMasterData for pws Glsr  report");
			ArrayList cpwsReport=new ArrayList();
			ArrayList pwsCistern;
			try
			{
				String finalQuery="select " +
				"subCompTbl.CISSC_CODE,subCompTbl.CIS_LOC,subCompTbl.CIS_CAP_LTS," +
				"subCompTbl.CIS_COND,decode(subCompTbl.CIS_PF,'Y','YES','N','NO')CIS_PF,DECODE(subCompTbl.CIS_PF_CON,'G','GOOD','B','BAD')CIS_PF_CON," +
				"DECODE(subCompTbl.CIS_DRAIN,'Y','YES','N','NO')CIS_DRAIN,subCompTbl.CIS_TAP,subCompTbl.CIS_TAP_COND," +
				"subCompTbl.CIS_HR,ASSET_NAME";
		        finalQuery=finalQuery+query;
			    conn = dataSource.getConnection();
		    	stmt = conn.createStatement();
		    	
		    	

		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        ////System.out.println( finalQuery);
			     try
				   {
			     
			     	
			     	String sno="1";
		            while(rs2.next())
		           { 
		            	
		            Statement stmt2 = conn.createStatement();
		    	    Statement stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("CISSC_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("CISSC_CODE")+"',1,14)=substr(panch_code,1,14)");
		            
		            pwsCistern=new ArrayList();
		            pwsCistern.add(sno);
		            try{rs3.next();
		            
		            pwsCistern.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsCistern.add("");
		            	//System.out.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		pwsCistern.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsCistern.add("");
		        		//System.out.println("exception:"+e);
		        	}
		        	
		        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsCistern.add(formatData(rs2.getString("CISSC_CODE")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_LOC")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_CAP_LTS")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_COND")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_PF")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_PF_CON")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_DRAIN")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_TAP")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_TAP_COND")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_HR")));
		        	cpwsReport.add( pwsCistern);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			        stmt.close();
			       conn.close();
		        
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
				
				return  cpwsReport;

		}
	
		public static ArrayList getAssetPwsPumpsetsPdReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
		{
			////System.out.println("getting data from CheckListMasterData for pws pump details  report");
			ArrayList cpwsReport=new ArrayList();
			ArrayList pwsCistern;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
			    conn = dataSource.getConnection();
		    	stmt = conn.createStatement();
		    	
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        ////System.out.println( finalQuery);
			     try
				   {
			     
			     	
			     	String sno="1";
		            while(rs2.next())
		           { 
		            	
		            Statement stmt2 = conn.createStatement();
		    	    Statement stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("PUMPDET_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("PUMPDET_CODE")+"',1,14)=substr(panch_code,1,14)");
		            
		            pwsCistern=new ArrayList();
		            pwsCistern.add(sno);
		            try{rs3.next();
		            
		            pwsCistern.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsCistern.add("");
		            	//System.out.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		pwsCistern.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsCistern.add("");
		        		//System.out.println("exception:"+e);
		        	}
		        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsCistern.add(formatData(rs2.getString("PUMPDET_CODE")));
		        	pwsCistern.add(formatData(rs2.getString("PUMPCODE")));
		        	pwsCistern.add(formatData(rs2.getString("HP")));
		        	pwsCistern.add(formatData(rs2.getString("TYPE")));
		        	pwsCistern.add(formatData(rs2.getString("HEAD_MTS")));
		        	pwsCistern.add(formatData(rs2.getString("DISCHARGE_LPM")));
		        	pwsCistern.add(formatData(rs2.getString("STANDBY_HP")));
		        	pwsCistern.add(formatData(rs2.getString("YEARS_USED")));
		        	pwsCistern.add(formatData(rs2.getString("FAILURE_FREQ")));
		        	pwsCistern.add(formatData(rs2.getString("AVG_HR_PUMPING_DAY")));
		        	
		        	pwsCistern.add(formatData(rs2.getString("REPAIR_COST_YEAR")));
		        	pwsCistern.add(formatData(rs2.getString("CAPASITOR")));
		        	
		        	pwsCistern.add(formatData(rs2.getString("CONTROL_PANEL")));
		        	pwsCistern.add(formatData(rs2.getString("POWER_SUPPLY_AVAILABLE_HRS"))); 
		        	pwsCistern.add(formatData(rs2.getString("POWER_HOURS")));
		        	pwsCistern.add(formatData(rs2.getString("QTY_WATER_CUM")));
		        	cpwsReport.add( pwsCistern);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			        stmt.close();
			       conn.close();
		        
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
				
				return  cpwsReport;

		}
		
		public static ArrayList getAssetPwsPumpsetsPhReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
		{
			////System.out.println("getting data from CheckListMasterData for pws pump house  report");
			ArrayList cpwsReport=new ArrayList();
			ArrayList pwsCistern;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
			    conn = dataSource.getConnection();
		    	stmt = conn.createStatement();
		    	
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        ////System.out.println( finalQuery);
			     try
				   {
			     
			     	
			     	String sno="1";
		            while(rs2.next())
		           { 
		            	
		            Statement stmt2 = conn.createStatement();
		    	    Statement stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("PUMPHOUSE_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("PUMPHOUSE_CODE")+"',1,14)=substr(panch_code,1,14)");
		            
		            pwsCistern=new ArrayList();
		            pwsCistern.add(sno);
		            try{rs3.next();
		            
		            pwsCistern.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsCistern.add("");
		            	//System.out.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		pwsCistern.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsCistern.add("");
		        		//System.out.println("exception:"+e);
		        	}
		        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsCistern.add(formatData(rs2.getString("PUMPHOUSE_CODE")));
		        	pwsCistern.add(formatData(rs2.getString("CONDITION")));
		        	pwsCistern.add(formatData(rs2.getString("TYPE")));
		        	pwsCistern.add(formatData(rs2.getString("AREA")));
		        	pwsCistern.add(formatData(rs2.getString("HEIGHT")));
		        	
		        	cpwsReport.add( pwsCistern);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			        stmt.close();
			       conn.close();
		        
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
				
				return  cpwsReport;

		}
		
		public static ArrayList getAssetPwsPumpsetsCpReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
		{
			////System.out.println("getting data from CheckListMasterData for pws capacitors report");
			ArrayList cpwsReport=new ArrayList();
			ArrayList pwsCistern;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
			    conn = dataSource.getConnection();
		    	stmt = conn.createStatement();
		    	
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        ////System.out.println( finalQuery);
			     try
				   {
			     
			     	
			     	String sno="1";
		            while(rs2.next())
		           { 
		            	
		            Statement stmt2 = conn.createStatement();
		    	    Statement stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("CPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("CPSC_CODE")+"',1,14)=substr(panch_code,1,14)");
		            
		            pwsCistern=new ArrayList();
		            pwsCistern.add(sno);
		            try{rs3.next();
		            
		            pwsCistern.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsCistern.add("");
		            	//System.out.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		pwsCistern.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsCistern.add("");
		        		//System.out.println("exception:"+e);
		        	}
		        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsCistern.add(formatData(rs2.getString("CPSC_CODE")));
		        	pwsCistern.add(formatData(rs2.getString("CP_EXES")));
		        	pwsCistern.add(formatData(rs2.getString("CP_COND")));
		        	pwsCistern.add(formatData(rs2.getString("CP_CAP")));
		        	pwsCistern.add(formatData(rs2.getString("CP_CAP_CON")));
		        	pwsCistern.add(formatData(rs2.getString("CP_MS")));
		        	pwsCistern.add(formatData(rs2.getString("CP_PL")));
		        	pwsCistern.add(formatData(rs2.getString("CP_CUT")));
		        	pwsCistern.add(formatData(rs2.getString("CP_PP")));
		        	pwsCistern.add(formatData(rs2.getString("CP_VM")));
		        	pwsCistern.add(formatData(rs2.getString("CP_AM")));
		        	pwsCistern.add(formatData(rs2.getString("CP_STA")));
		        	pwsCistern.add(formatData(rs2.getString("CP_MS1")));
		        	pwsCistern.add(formatData(rs2.getString("CP_SB")));
		        	
		        	
		        	cpwsReport.add( pwsCistern);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			        stmt.close();
			       conn.close();
		        
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
				
				return  cpwsReport;

		}
		//code added
		public static ArrayList getAssetPwsPipelinePumpingmainReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
		{
			////System.out.println("getting data from CheckListMasterData for cpws reservoirs ohsr  report");
			ArrayList pwsReport=new ArrayList();
			ArrayList pwsPipelinePumpingMain;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
		        
			    
			    conn = dataSource.getConnection();
		    	stmt = conn.createStatement();
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
			        ////System.out.println( finalQuery);
			     try
				   {
			     	   	
			        String sno="1";
		            while(rs2.next())
		           { 
		        	pwsPipelinePumpingMain=new ArrayList();
		        	Statement stmt2 = conn.createStatement();
		    	    Statement stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("pm_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("pm_CODE")+"',1,14)=substr(panch_code,1,14)");
		            
		            pwsPipelinePumpingMain=new ArrayList();
		            pwsPipelinePumpingMain.add(sno);
		            try{rs3.next();
		            
		            pwsPipelinePumpingMain.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsPipelinePumpingMain.add("");
		            	//System.out.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		pwsPipelinePumpingMain.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsPipelinePumpingMain.add("");
		        		//System.out.println("exception:"+e);
		        	}
		        	pwsPipelinePumpingMain.add(formatData(rs2.getString("ASSET_NAME"))+"");  
		        	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_MAT"))+"");       
			     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_CLA"))+"");      
			     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_DIA"))+"");      
			     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_LEN"))+"");      
			     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_COND"))+"");      
			     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_REP"))+"");       
			     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_AV_NO"))+"");      
			     	
			     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_SCRV_NO"))+"");      
			     	    
			     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_SV_NO"))+"");     
			     	     
			     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_RV_NO"))+"");     
			     	
			             
			     
		        	pwsReport.add( pwsPipelinePumpingMain);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	pwsReport.add(ExceptionReport);
					 	return 	pwsReport;
					 }
			        stmt.close();
			       conn.close();
		        
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
				
				return  pwsReport;

		}


		public static ArrayList getAssetPwsPipelineDistributionReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
		{
			////System.out.println("getting data from CheckListMasterData for pws pipe line distribution  report");
			ArrayList pwsReport=new ArrayList();
			ArrayList pwsPipelineDistribution;
			try
			{
				String finalQuery="select subCompTbl.*,DECODE(DIS_COVE,'Y','YES','N','NO')DIS_COVE1,b.DIS_MAT,ASSET_NAME";
		        finalQuery=finalQuery+query;
		        
			    
			    conn = dataSource.getConnection();
		    	stmt = conn.createStatement();
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
			        ////System.out.println("final query in checkListMasterData is"+ finalQuery);
			     try
				   {
			     	

			     		     	
			        String sno="1";
		            while(rs2.next())
		           { 
		        	pwsPipelineDistribution=new ArrayList();
		        	Statement stmt2 = conn.createStatement();
		    	    Statement stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("DISTRISC_CODE")+"',1,14)=substr(panch_code,1,14)");
		            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("DISTRISC_CODE")+"',1,14)=substr(panch_code,1,14)");
		            
		            pwsPipelineDistribution=new ArrayList();
		            pwsPipelineDistribution.add(sno);
		            try{rs3.next();
		            
		            pwsPipelineDistribution.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsPipelineDistribution.add("");
		            	//System.out.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		pwsPipelineDistribution.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsPipelineDistribution.add("");
		        		//System.out.println("exception:"+e);
		        	}
		        	
		        	

		        	  pwsPipelineDistribution.add(formatData(rs2.getString("ASSET_NAME"))+""); 
		            pwsPipelineDistribution.add(formatData(rs2.getString("DISTRISC_CODE"))+""); 
		        	pwsPipelineDistribution.add(formatData(rs2.getInt("NO_OF_PIPES"))+""); 
		        	pwsPipelineDistribution.add(formatData(rs2.getString("DIS_MAT"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getInt("DIS_LEN"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getString("DIS_COVE1"))+"");  
		        	pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_LN"))+""); 
		        	pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_TLC"))+"");  
		        	pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_BN"))+"");
			     	pwsReport.add( pwsPipelineDistribution);
			     	
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	pwsReport.add(ExceptionReport);
					 	return 	pwsReport;
					 	
					 }
			        stmt.close();
			       conn.close();
		        
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
				
				return  pwsReport;

		}

//	pws pipeline stand posts
		public static ArrayList getAssetPwsPipelineStandPostsReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
		{
			////System.out.println("getting data from CheckListMasterData for pws pipe line distribution  report");
			ArrayList pwsReport=new ArrayList();
			ArrayList record;
			try
			{
				String finalQuery="select subCompTbl.SPHCPCSC_CODE,subCompTbl.SP_NO,HC_NO,DECODE(subCompTbl.PC_RF,'Y','YES','N','NO')PC_RF1," +
						"DECODE(subCompTbl.PC_UF,'Y','YES','N','NO')PC_UF1,subCompTbl.PC_HRS,DECODE(subCompTbl.PC_LV,'Y','YES','N','NO')PC_LV," +
						"subCompTbl.PC_SUG," +
						"subCompTbl.PC_FEA,subCompTbl.PC_COST,subCompTbl.PC_DIS,ASSET_NAME";
		        finalQuery=finalQuery+query;
		        
			    
			    conn = dataSource.getConnection();
		    	stmt = conn.createStatement();
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
			        ////System.out.println( finalQuery);
			     try
				   {
			     	
			     	 

			     	 	     	
/////////
			     		     	
			        String sno="1";
		            while(rs2.next())
		           { 
		            	record=new ArrayList();
		            	record=new ArrayList();
			        	Statement stmt2 = conn.createStatement();
			    	    Statement stmt3 = conn.createStatement();
			            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("SPHCPCSC_CODE")+"',1,14)=substr(panch_code,1,14)");
			            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("SPHCPCSC_CODE")+"',1,14)=substr(panch_code,1,14)");
			            
			            record=new ArrayList();
			            record.add(sno);
			            try{rs3.next();
			            
			            record.add(rs3.getString("PNAME"));
			        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
			            }catch(Exception e){
			            	record.add("");
			            	//System.out.println("Exception"+e);
			            	}
			        	try
						{
			        		rs4.next();
			        		record.add(rs4.getString("PANCH_NAME"));
			        	}
			        	catch(Exception e)
						{
			        		record.add("");
			        		//System.out.println("exception:"+e);
			        	}
			        	 record.add(formatData(rs2.getString("ASSET_NAME"))+"");
		            	 record.add(formatData(rs2.getString("SPHCPCSC_CODE"))+"");
		            	 record.add(formatData(rs2.getInt("SP_NO"))+"");  
		            	 record.add(formatData(rs2.getInt("HC_NO"))+""); 
		            	 record.add(formatData(rs2.getString("PC_RF1"))+"");
		            	 record.add(formatData(rs2.getString("PC_UF1"))+""); 
		            	 record.add(formatData(rs2.getFloat("PC_HRS")));       
				     	 record.add(formatData(rs2.getString("PC_LV"))+"");     
				     	 record.add(formatData(rs2.getString("PC_SUG"))+"");       
				     	 record.add(formatData(rs2.getString("PC_FEA"))+"");     
				     	 record.add(formatData(rs2.getFloat("PC_COST")));      
				     	 record.add(formatData(rs2.getInt("PC_DIS"))+""); 
				     pwsReport.add(record);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	pwsReport.add(ExceptionReport);
					 	return 	pwsReport;
					 }
			        stmt.close();
			       conn.close();
		        
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
				
				return  pwsReport;

		}
		
		
		  public static ArrayList getMandalsForPwsSource(DataSource dataSource,String Dcode,String Div,String subDiv,String sourceType,String subType)
        {
         	    ////System.out.println("getting data from CheckListMasterData for districts grill  report");
	    	
   	        rws_asset_cpws_DrillDownBean cpwsGrill; 
		        ArrayList cpwsReport=new ArrayList();
   	     
		        String query="";
		        String q1="select count(*)COUNT,dname ,trim(man.MNAME)as Mnadal from rws_district_tbl d,rws_mandal_tbl man," +
   			"RWS_SOURCE_TBL subCompTbl where subCompTbl.source_type_code='"+sourceType +"' and subCompTbl.subsource_type_code='"+subType+"'"+
   			 " and substr(subCompTbl.hab_code,1,2) = man.dcode " +
   			"and substr(subCompTbl.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
   			" and d.dcode=man.dcode " +
   			"and man.dcode='"+Dcode+"'";
		        
		        String q2="and subCompTbl.circle_office_Code='"+Dcode+"'and subCompTbl.DIVISION_OFFICE_CODE='"+Div+"'";
		        String q4=" and subCompTbl.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
   	        String q3= " group by dname,man.MNAME";
   	        if(!(Div.equals("")))
   	        {  
   	        	////System.out.println("in div block");
   	        	query=q1+q2;
   	        	 if(!(subDiv.equals("")))
   	        	 {
   	        	 query=query+q4;	
   	        	 }
   	        }  query=query+q3;
   	        if((Div.equals("")))
   	        {
   	          query=q1+q3;
   	        }
   			try
   			{    
   			   conn = dataSource.getConnection();
   		       stmt = conn.createStatement();
   			   ////System.out.println(query);
   			        ResultSet rs=stmt.executeQuery(query);
   			        ////System.out.println(query);
   			        try{String sno="1";
   		        while(rs.next())
   		         {     
   		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
   		        	cpwsGrill.setSno(sno);
   		        	cpwsGrill.setName(rs.getString("Mnadal"));
   		        	cpwsGrill.setTotal(rs.getString("COUNT"));
   		            cpwsReport.add( cpwsGrill);
   		        	int no=Integer.parseInt(sno);
   		        	no++;
   		            sno=""+no;
   		        	
   		         }
   			    }
   			        catch(Exception e)
   					 {
   					 	//System.out.println("error in getig dat in CheckListMasterData"+e);
   					 java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
   					 }
   			        stmt.close();	
   			        conn.close();  
   		        
   			}
   			 catch(Exception e)
   			 {
   			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
   			 java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
   			 }
   				
   				return  cpwsReport;	

    }
		  
		  public static ArrayList getAssetPwsSource(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
			{
				////System.out.println("getting data from CheckListMasterData for pws pipe line distribution  report");
				ArrayList pwsReport=new ArrayList();
				ArrayList record;
				try
				{
					String finalQuery="select *";
			        finalQuery=finalQuery+query;
			        
				    
				    conn = dataSource.getConnection();
			    	stmt = conn.createStatement();
			    	// ohbr
			    	    ResultSet rs2=stmt.executeQuery( finalQuery);
				        ////System.out.println( finalQuery);
				     try
					   {
				     	
				     

				     		     	
				        String sno="1";
			            while(rs2.next())
			           { 
			            	
			            	
			            	record=new ArrayList();
				        	Statement stmt2 = conn.createStatement();
				    	    Statement stmt3 = conn.createStatement();
				            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
				            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("SOURCE_CODE")+"',1,14)=substr(panch_code,1,14)");
				            
				            record=new ArrayList();
				            record.add(sno);
				            try{rs3.next();
				            
				            record.add(rs3.getString("PNAME"));
				        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
				            }catch(Exception e){
				            	record.add("");
				            	//System.out.println("Exception"+e);
				            	}
				        	try
							{
				        		rs4.next();
				        		record.add(rs4.getString("PANCH_NAME"));
				        	}
				        	catch(Exception e)
							{
				        		record.add("");
				        		//System.out.println("exception:"+e);
				        	}
			            	
			            	record.add(formatData(rs2.getString("SOURCE_CODE"))+"");  
					     	record.add(formatData(rs2.getString("SOURCE_NAME"))+"");     
					     	record.add(formatData(rs2.getString("SOURCE_TYPE_CODE"))+"");  
					     	record.add(formatData(rs2.getString("SUBSOURCE_TYPE_CODE"))+"");  
					     	record.add(formatData(rs2.getString("HAB_CODE  NOT NULL"))+"");  
					     	record.add(formatData(rs2.getString("NO_OF_HABITAITONS_COVERD"))+"");    
					     	record.add(formatData(rs2.getString("POPULATION_BENIFITED"))+"");  
					     	record.add(formatData(rs2.getString("SEASONAL"))+"");     
					     	record.add(formatData(rs2.getString("PRESENT_CONDITION"))+"");   
					     	record.add(formatData(rs2.getString("WATER_QUALITY"))+"");   
					     	record.add(formatData(rs2.getString("STATIC_WATER_LEVEL"))+"");    
					     	record.add(formatData(rs2.getString("SUMMER_WATER_LEVEL"))+"");     
					     	record.add(formatData(rs2.getString("YIELD"))+"");    
					     	record.add(formatData(rs2.getString("DIST_NEAR_PRIVATE_SOURCE"))+"");     
					     	record.add(formatData(rs2.getString("LOCATION"))+"");    
					     	record.add(formatData(rs2.getString("CIRCLE_OFFICE_CODE"))+"");     
					     	record.add(formatData(rs2.getString("DIVISION_OFFICE_CODE"))+"");    
					     	record.add(formatData(rs2.getString("SUBDIVISION_OFFICE_CODE"))+"");     
					     	record.add(formatData(rs2.getString("DEPTH"))+"");    
					     	record.add(formatData(rs2.getString("DIAMETER"))+"");    
					  
					     pwsReport.add(record);
			        	int no=Integer.parseInt(sno);
			        	no++;
			            sno=""+no;
			           }
				    }
				        catch(Exception e)
						 {
						 	//System.out.println("error in getig dat in CheckListMasterData"+e);
						 	java.util.Vector ExceptionReport =new java.util.Vector();
						 	ExceptionReport.add(e);
						 	pwsReport.add(ExceptionReport);
						 	return 	pwsReport;
						 }
				        stmt.close();
				       conn.close();
			        
				}
				 catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	pwsReport.add(ExceptionReport);
				 	return 	pwsReport;
				 }
					
					return  pwsReport;

			}
			
		  
		  public static ArrayList getAssetHandpumpsBorewellReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query, int start, int end,int serialNo)throws Exception
			{
				////System.out.println("getting data from CheckListMasterData for cpws source intakeWell  report");
				ArrayList cpwsReport=new ArrayList();
				ArrayList cpwsReport2=new ArrayList();
				ArrayList report=new ArrayList();
				ArrayList record;
				ArrayList record2;
				try
				{
					
					////////////////
					String finalQuery="select subCompTbl.HP_CODE,subCompTbl.LOCATION" +
							",subCompTbl.DRILL_YEAR,subCompTbl.DEPTH" +
							",subCompTbl.DIAMETER ,decode(subCompTbl.STATUS" +
							",'W','WORKING','N','NOT WORKING','S','SEASONAL'" +
							",'D','DRIED','C','CONDEMED') STATUS,subCompTbl.CASING" +
							",DECODE(subCompTbl.GEN_CONDITION,'G','GOOD','B','BAD') " +
							" GEN_CONDITION,subCompTbl.SUMMER_WL,subCompTbl.STATIC_WL" +
							",subCompTbl.SER_HRS,subCompTbl.SER_NO," +
							"DECODE(subCompTbl.PAINTED,'Y','YES','N','NO') " +
							"PAINTED,subCompTbl.REPAIRS," +
							"DECODE(subCompTbl.PLATFORM_CONDITION,'G','GOOD','B','BAD') " +
							"PLATFORM_CONDITION,DECODE(subCompTbl.DRAIN,'E','EXISTING','N','NOT EXINTING')" +
							" DRAIN,DECODE(subCompTbl.DRAIN_CONDITION,'G','GOOD','B','BAD') DRAIN_CONDITION," +
							"DECODE(subCompTbl.DRAIN_SD,'Y','YES','N','NO') DRAIN_SD,DECODE(subCompTbl.DRAIN_LP,'Y','YES','N','NO')" +
							" DRAIN_LP,DECODE(subCompTbl.HYGIENE,'G','GOOD','B','BAD') HYGIENE,subCompTbl.P_YEILD," +
							"subCompTbl.PYEILD_LOCAL,subCompTbl.AVG_TIME,ASSET_NAME";
					
					
					
					/////////////////////


					//String finalQuery="select  subCompTbl.*";
					finalQuery=finalQuery+query;
			        
				    ////System.out.println("final query is: "+finalQuery);
					//String finalQuery="";/////
					String pagingQuery="select * from(select a.*, rownum r from (";
					pagingQuery=pagingQuery+finalQuery+" order by subCompTbl.HP_CODE) a)  WHERE r BETWEEN "+start+" AND "+end;
					//SELECT * FROM( SELECT a.*, ROWNUM r FROM ( SELECT column FROM table[,....] [WHERE clause] ORDER BY column[,...]) a ) WHERE r BETWEEN start AND end
					
					////System.out.println("last query is"+pagingQuery);
					conn = dataSource.getConnection();
			    	stmt = conn.createStatement();
			    	// ohbr
			    	
			    	    ResultSet rs2=stmt.executeQuery(pagingQuery);
				        ////System.out.println( pagingQuery);
				     try
					   {
				     	
				     	
				     	
				     	String sno=serialNo+"";
				      
				     
				      
				        
			            while(rs2.next())
			           { 
			             record=new ArrayList();
			             record2=new ArrayList();
			             
				        	Statement stmt2 = conn.createStatement();
				    	    Statement stmt3 = conn.createStatement();
				            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("HP_CODE")+"',1,14)=substr(panch_code,1,14)");
				            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("HP_CODE")+"',1,14)=substr(panch_code,1,14)");
				            
				            record=new ArrayList();
				            record.add(sno);
				            try{rs3.next();
				            
				            record.add(rs3.getString("PNAME"));
				        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
				            }catch(Exception e){
				            	record.add("");
				            	//System.out.println("Exception"+e);
				            	}
				        	try
							{
				        		rs4.next();
				        		record.add(rs4.getString("PANCH_NAME"));
				        	}
				        	catch(Exception e)
							{
				        		record.add("");
				        		//System.out.println("exception:"+e);
				        	}
				        	record.add(rs2.getString("ASSET_NAME"));  
				        	 record.add(rs2.getString("HP_CODE"));  
					         record.add(rs2.getString("LOCATION"));     
				        	record.add(rs2.getString("DRILL_YEAR")); 
							 //record.add(rs2.getFloat("DEPTH")+"");  
							 String depth=rs2.getFloat("DEPTH")+"";
							 record.add(formatData(rs2.getFloat("DEPTH")));  
							 
							 record.add(formatData(rs2.getFloat("DIAMETER")));   
							 record.add(rs2.getString("STATUS"));  
							 record.add(rs2.getString("CASING"));     
							 record.add(rs2.getString("GEN_CONDITION"));   
							
							
							 record.add(formatData(rs2.getFloat("SUMMER_WL")));  
							 record.add(formatData(rs2.getFloat("STATIC_WL")));  
							 record.add(formatData(rs2.getFloat("SER_HRS")));  
							
							 record2.add(sno);
							 record2.add(rs2.getInt("SER_NO")+"");
							 record2.add(rs2.getString("PAINTED"));
							 record2.add(rs2.getString("REPAIRS")); 
							 record2.add(rs2.getString("PLATFORM_CONDITION")); 
							 record2.add(rs2.getString("DRAIN"));   
							 record2.add(rs2.getString("DRAIN_CONDITION"));    
							 record2.add(rs2.getString("DRAIN_SD"));      
							 record2.add(rs2.getString("DRAIN_LP"));    
							 record2.add(rs2.getString("HYGIENE"));  
							 record2.add(rs2.getInt("P_YEILD")+""); 
							 record2.add(rs2.getString("PYEILD_LOCAL"));
							 record2.add(formatData(rs2.getFloat("AVG_TIME")));  
							// //System.out.println("mod is");
							// //System.out.println((rs2.getFloat("DEPTH") mod 10)+"");
										
			               	cpwsReport.add(record);
			               	cpwsReport2.add(record2);
			        	int no=Integer.parseInt(sno);
			        	no++;
			            sno=""+no;
			           }
				   report.add(cpwsReport);
				   report.add(cpwsReport2);
					   }
				        catch(Exception e)
						 {
						 	//System.out.println("error in getig dat in CheckListMasterData"+e);
						 	java.util.Vector ExceptionReport =new java.util.Vector();
						 	ExceptionReport.add(e);
						 	report.add(ExceptionReport);
						 	return 	report;
						 }
				        stmt.close();
				       conn.close();
			        
				}
				 catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	report.add(ExceptionReport);
				 	return 	report;
				 }
					
					return  report;

			}
public static String formatData(float data)
{
int temp;
float fraction;
if(data==0)
{
	return "--";
}
temp=(int)data;
fraction=data-temp;
if(fraction==0)
{
	return temp+"";
}

return data+"";

}

public static String formatData(String data)
{
if(data==null)
{
	return "";
}
if(!(data==null))
{
if(data.equals("null"))
{
return "";	
}
if(data.equals("0"))
	return "--";
}
return data;
}

public static String formatData(int data)
{
if(data==0)
	return "--";
else return data+"";
}

public static ArrayList getMandalsForFilters(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv,String Filtertype)
{
 	    ////System.out.println("getting data from CheckListMasterData for districts grill  report");
	
       rws_asset_cpws_DrillDownBean cpwsGrill=null; 
       ArrayList cpwsReport=new ArrayList();
    
       String query="";
       String q1="select count(*)COUNT,dname ,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
		"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
		"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and subStr(subCompTbl.WTPSC_CODE ,20,2)='"+Filtertype+"'" +
		" and substr(a.hab_code,1,2) = man.dcode " +
		"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
		" and d.dcode=man.dcode " +
		"and man.dcode='"+Dcode+"'";
       
       String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
       String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
       String q3= " group by dname,man.MNAME order by man.MNAME";
       if(!(Div.equals("")))
       {  
       	////System.out.println("in div block");
       	query=q1+q2;
       	 if(!(subDiv.equals("")))
       	 {
       	 query=query+q4;	
       	 }
       }  query=query+q3;
       if((Div.equals("")))
       {
         query=q1+q3;
       }
       int tot=0;
		try
		{    
		   conn = dataSource.getConnection();
	       stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		   ////System.out.println(query);
		        ResultSet rs=stmt.executeQuery(query);
		        ////System.out.println(query);
		        try{String sno="1";
	        while(rs.next())
	         {     
	        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno(sno);
	        	cpwsGrill.setName(rs.getString("Mandal"));
	        	cpwsGrill.setTotal(rs.getString("COUNT"));
	            tot=tot+Integer.parseInt(rs.getString("count"));
	            
		        ////System.out.println("Total Districts is "+tot);
	            cpwsReport.add(cpwsGrill);
	            int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
	        
	        
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		     
		            cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno("**");
		        	cpwsGrill.setName("Total");
		        	cpwsGrill.setTotal(Integer.toString(tot));
		        	cpwsReport.add(cpwsGrill);
		        	        		        
		        stmt.close();	
		        conn.close();  
		}
		
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 
			
			return  cpwsReport;	

}

public static ArrayList getMandalsForPws(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv)
{
 	    ////System.out.println("getting data from CheckListMasterData for districts grill  report");
	
       rws_asset_cpws_DrillDownBean cpwsGrill=null; 
       ArrayList cpwsReport=new ArrayList();
    
       String query="";
       String q1="select count(*)COUNT,dname ,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
		"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
		"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
		" and substr(a.hab_code,1,2) = man.dcode " +
		"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
		" and d.dcode=man.dcode and substr(subCompTbl."+subcompCode+",17,3) like '6%'" +
		"and man.dcode='"+Dcode+"'";
       
       String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
       String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
       String q3= " group by dname,man.MNAME order by man.MNAME";
       if(!(Div.equals("")))
       {  
       	////System.out.println("in div block");
       	query=q1+q2;
       	 if(!(subDiv.equals("")))
       	 {
       	 query=query+q4;	
       	 }
       }  query=query+q3;
       if((Div.equals("")))
       {
         query=q1+q3;
       }
       int tot=0;
		try
		{    
		   conn = dataSource.getConnection();
	       stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		   ////System.out.println(query);
		        ResultSet rs=stmt.executeQuery(query);
		        ////System.out.println(query);
		        try{String sno="1";
	        while(rs.next())
	         {     
	        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno(sno);
	        	cpwsGrill.setName(rs.getString("Mandal"));
	        	cpwsGrill.setTotal(rs.getString("COUNT"));
	            tot=tot+Integer.parseInt(rs.getString("count"));
	            
		        ////System.out.println("Total Districts is "+tot);
	            cpwsReport.add(cpwsGrill);
	            int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
	        
	        
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		     
		            cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno("**");
		        	cpwsGrill.setName("Total");
		        	cpwsGrill.setTotal(Integer.toString(tot));
		        	cpwsReport.add(cpwsGrill);
		        	        		        
		        stmt.close();	
		        conn.close();  
		}
		
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 
			
			return  cpwsReport;	

}


public static ArrayList getAssetMpwsPipelineDistributionReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for pws pipe line distribution  report");
	ArrayList pwsReport=new ArrayList();
	ArrayList pwsPipelineDistribution;
	try
	{
		//String finalQuery="select subCompTbl.*,b.DIS_MAT";
		String finalQuery="select subCompTbl.*,decode(subcompTbl.DIS_COVE,'Y','YES','N','NO')DIS_COVE1,ASSET_NAME";
        finalQuery=finalQuery+query+" and substr(subCompTbl.DISTRISC_CODE,17,3) like '4%'";
        
	    
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	// ohbr
    	    ResultSet rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println("final query in checkListMasterData is"+ finalQuery);
	     try
		   {
	     	

	     		     	
	        String sno="1";
            while(rs2.next())
           { 
        	pwsPipelineDistribution=new ArrayList();
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement(); 
    	    ResultSet rs3=null;
    	    ResultSet rs4=null;
    	    try{
    	    rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("DISTRISC_CODE")+"',1,14)=substr(panch_code,1,14)");
        	}catch(Exception e){//System.out.println("not executed rs3"+e);}  
    	    try{
        	rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("DISTRISC_CODE")+"',1,14)=substr(panch_code,1,14)");
    	    }catch(Exception e){//System.out.println("not executed rs4"+e); }
        	////System.out.println("executed rs4");   
	            pwsPipelineDistribution=new ArrayList();
	            pwsPipelineDistribution.add(sno);
	        	try{rs3.next();
	            
	        	pwsPipelineDistribution.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	pwsPipelineDistribution.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	pwsPipelineDistribution.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		pwsPipelineDistribution.add("");
	        		//System.out.println("exception:"+e);}
        	



        	try{
        		pwsPipelineDistribution.add(formatData(rs2.getString("ASSET_NAME"))+""); 
        	pwsPipelineDistribution.add(formatData(rs2.getString("DISTRISC_CODE"))+""); 
        	pwsPipelineDistribution.add(formatData(rs2.getInt("NO_OF_PIPES"))+""); 
        	//pwsPipelineDistribution.add(rs2.getString("DIS_MAT")+"");
        	pwsPipelineDistribution.add(formatData(rs2.getInt("DIS_LEN"))+"");
        	pwsPipelineDistribution.add(formatData(rs2.getString("DIS_COVE1"))+"");  
        	pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_LN"))+""); 
        	pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_TLC"))+"");  
        	pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_BN"))+"");
        	}catch(Exception e){//System.out.println("error in adding"+e);}
        	pwsReport.add( pwsPipelineDistribution);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
	        stmt.close();
	       conn.close();
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	pwsReport.add(ExceptionReport);
	 	return 	pwsReport;
	 }
		
		return  pwsReport;

}



public static ArrayList getAssetMpwsPumpsetsPumpHouseReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for pws pumpsets pumphouse  report");
	ArrayList pwsReport=new ArrayList();
	ArrayList record;
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME";
        finalQuery=finalQuery+query;
        
	    
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	// ohbr
    	    ResultSet rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( finalQuery);
	     try
		   {
	     	


	     	

	     		     	
	        String sno="1";
            while(rs2.next())
           { 
            	record=new ArrayList();
            	record.add(sno);
            	record.add(formatData(rs2.getString("ASSET_NAME"))+""); 
            	record.add(formatData(rs2.getString("PUMPHOUSE_CODE"))+""); 
            	record.add(formatData(rs2.getString("CONDITION"))+"");
            	record.add(formatData(rs2.getString("TYPE"))+""); 
            	record.add(formatData(rs2.getFloat("AREA "))+"");
            	record.add(formatData(rs2.getFloat("HEIGHT"))+"");    
		     	  	   	  
        	pwsReport.add(record);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
	        stmt.close();
	       conn.close();
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	pwsReport.add(ExceptionReport);
	 	return 	pwsReport;
	 }
		
		return  pwsReport;

}

public static ArrayList getAssetMpwsReservoirsrGlsrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for cpws reservoirs glsr  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsGlsr;
	try
	{
		

		String finalQuery="select subcompTbl.* ,ASSET_NAME,decode(subcompTbl.GLSR_DRA_COND,'Y','YES','N','NO')GLSR_DRA_COND1 ," +
				"decode(subcompTbl.GLSR_HYG,'G','GOOD','B','BAD')GLSR_HYG1";
        finalQuery=finalQuery+query;
        
	   conn = dataSource.getConnection();
       stmt = conn.createStatement();
	   ////System.out.println("final query in master data is"+finalQuery);
	   
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GLSR_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GLSR_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsGlsr=new ArrayList();
            cpwsGlsr.add(sno);
        	try{rs3.next();
            
        	cpwsGlsr.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsGlsr.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsGlsr.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsGlsr.add("");
        		
        	   		
        		//System.out.println("exception:"+e);}
        	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsGlsr.add(formatData(rs.getString("GLSR_CODE")));
           	cpwsGlsr.add(formatData(rs.getString("GLSR_LOC")));
         	cpwsGlsr.add(formatData(rs.getFloat("GLSR_CAP_LTS"))+"");
	     	cpwsGlsr.add(formatData(rs.getString("GLSR_MADE"))+"");
	     	cpwsGlsr.add(formatData(rs.getString("GLSR_COND"))+"");
	     	cpwsGlsr.add(formatData(rs.getFloat("GLSR_FILL_HRS"))+"");
        	cpwsGlsr.add(formatData(rs.getString("GLSR_EMPTY_HRS"))+"");
        	cpwsGlsr.add(formatData(rs.getString("GLSR_DRA_COND1"))+"");
        	cpwsGlsr.add(formatData(rs.getString("GLSR_HYG1"))+"");
            cpwsReport.add( cpwsGlsr);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();	
	        conn.close();  
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;

}


public static ArrayList getAssetMpwsReservoirsrGlbrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for cpws reservoirs glsr  report");
	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsGlsr;
	try
	{
		

		String finalQuery="select *,ASSET_NAME";
        finalQuery=finalQuery+query;
        
	   conn = dataSource.getConnection();
       stmt = conn.createStatement();
	   ////System.out.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        ////System.out.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GLSR_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GLSR_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            cpwsGlsr=new ArrayList();
            cpwsGlsr.add(sno);
        	try{rs3.next();
            
        	cpwsGlsr.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsGlsr.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsGlsr.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsGlsr.add("");
        		//System.out.println("exception:"+e);}
        	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsGlsr.add(formatData(rs.getString("GLSR_CODE")));
        	cpwsGlsr.add(formatData(rs.getString("GLSR_LOC")));
        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_CAP_LTS"))+"");
            cpwsGlsr.add(formatData(rs.getFloat("GLSR_SATGES"))+"");
        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_LWL"))+"");
        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_MWL"))+"");
        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_FILL_HR"))+"");
        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_EMPTY_HR"))+"");
        	cpwsGlsr.add(formatData(rs.getInt("GLSR_NO_OF_FILLING"))+"");
            cpwsReport.add( cpwsGlsr);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
        	
         }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 	
			 }
	        stmt.close();	
	        conn.close();  
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;

}

public static ArrayList getAssetMpwsReservoirsCisternsReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for Mpws Cisterns  report");
	ArrayList cpwsReport=new ArrayList();
	ArrayList pwsCistern;
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME,decode(subcompTbl.CIS_PF,'Y','YES','N','NO')CIS_PF1," +
				"decode(subcompTbl.CIS_PF_CON,'G','GOOD','B','BAD')CIS_PF_CON1,decode(subcompTbl.CIS_DRAIN,'Y','YES','N','NO')CIS_DRAIN1";
        finalQuery=finalQuery+query;
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	
    	// ohbr
    	    ResultSet rs2=stmt.executeQuery( finalQuery);
    	    
	        ////System.out.println( finalQuery);
	     try
		   {
	     
	     	
	     	String sno="1";
            while(rs2.next())
           { 
            	
            Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("CISSC_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("CISSC_CODE")+"',1,14)=substr(panch_code,1,14)");
            
            pwsCistern=new ArrayList();
            pwsCistern.add(sno);
            try{rs3.next();
            
            pwsCistern.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	pwsCistern.add("");
            	//System.out.println("Exception"+e);
            	}
        	try
			{
        		rs4.next();
        		pwsCistern.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e)
			{
        		pwsCistern.add("");
        		//System.out.println("exception:"+e);
        	}
        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
        	pwsCistern.add(formatData(rs2.getString("CISSC_CODE")));
        	pwsCistern.add(formatData(rs2.getString("CIS_LOC")));
        	pwsCistern.add(formatData(rs2.getString("CIS_CAP_LTS")));
        	pwsCistern.add(formatData(rs2.getString("CIS_COND")));
        	pwsCistern.add(formatData(rs2.getString("CIS_PF1")));
        	pwsCistern.add(formatData(rs2.getString("CIS_PF_CON1")));
        	pwsCistern.add(formatData(rs2.getString("CIS_DRAIN1")));
        	pwsCistern.add(formatData(rs2.getString("CIS_TAP")));
        	pwsCistern.add(formatData(rs2.getString("CIS_TAP_COND")));
        	pwsCistern.add(formatData(rs2.getString("CIS_HR")));
        	cpwsReport.add( pwsCistern);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();
	       conn.close();
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;

}




public static ArrayList getMandalsForMpws(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv)
{
 	    ////System.out.println("getting data from CheckListMasterData for districts grill  report");
	
        rws_asset_cpws_DrillDownBean cpwsGrill; 
        ArrayList cpwsReport=new ArrayList();
     
        String query="";
        String q1="select count(*)COUNT,dname ,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
		"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
		"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
		" and substr(a.hab_code,1,2) = man.dcode " +
		"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
		" and d.dcode=man.dcode " +
		"and man.dcode='"+Dcode+"' and substr(subCompTbl."+subcompCode+",17,3) LIKE '4%'";
        
        String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
        String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
        String q3= " group by dname,man.MNAME";
        if(!(Div.equals("")))
        {  
        	////System.out.println("in div block");
        	query=q1+q2;
        	 if(!(subDiv.equals("")))
        	 {
        	 query=query+q4;	
        	 }
        }  query=query+q3;
        if((Div.equals("")))
        {
          query=q1+q3;
        }
        int tot=0;
		try
		{    
		   conn = dataSource.getConnection();
	       stmt = conn.createStatement();
		   ////System.out.println(query);
		        ResultSet rs=stmt.executeQuery(query);
		        ////System.out.println(query);
		        try{String sno="1";
	        while(rs.next())
	         {     
	        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno(sno);
	        	cpwsGrill.setName(rs.getString("Mandal"));
	        	cpwsGrill.setTotal(rs.getString("COUNT"));
	        	 tot=tot+Integer.parseInt(rs.getString("count"));
	            cpwsReport.add( cpwsGrill);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        stmt.close();	
		        conn.close();  
	        
		        cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno("**");
	        	cpwsGrill.setName("Total");
	        	cpwsGrill.setTotal(Integer.toString(tot));
	        	cpwsReport.add(cpwsGrill);
		}
		
		
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
			
			return  cpwsReport;	

}


public static ArrayList getAssetMpwsPumpsetsPumpDetailsReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for pws pipe line distribution  report");
	ArrayList pwsReport=new ArrayList();
	ArrayList record;
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME";
        finalQuery=finalQuery+query;
        
	    
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	// ohbr
    	    ResultSet rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( finalQuery);
	     try
		   {
	     	
	     	
	     	 

	     	

	     		     	
	        String sno="1";
            while(rs2.next())
           { 
            	record=new ArrayList();
            	record.add(sno);
            	
            	

            	record.add(formatData(rs2.getString("ASSET_NAME"))+""); 
            	record.add(formatData(rs2.getString("PUMPDET_CODE"))+"");  
            	record.add(formatData(rs.getInt("HP"))+"");  
            	record.add(formatData(rs2.getString("DUTY_CON"))+""); 
            	record.add(formatData(rs2.getFloat("DISCHARGE_LPM"))+"");  
            	record.add(formatData(rs.getInt("YEARS_USED"))+"");  
            	record.add(formatData(rs2.getFloat("AVG_HR_PUMPING_DAY"))+""); 
            	record.add(formatData(rs2.getString("CAPASITOR"))+""); 
            	record.add(formatData(rs2.getFloat("POWER_SUPPLY_AVAILABLE_HRS"))+"");
            	record.add(formatData(rs2.getFloat("QTY_WATER_CUM"))+""); 
            	record.add(formatData(rs2.getString("PUMPCODE"))+""); 
            	record.add(formatData(rs2.getString("TYPE"))+""); 
            	record.add(formatData(rs2.getInt("HEAD_MTS"))+""); 
            	record.add(formatData(rs2.getInt("STANDBY_HP"))+"");      
            	record.add(formatData(rs2.getString("FAILURE_FREQ"))+"");    
            	record.add(formatData(rs2.getFloat("REPAIR_COST_YEAR"))+"");         
            	record.add(formatData(rs2.getString("CONTROL_PANEL"))+"");        
            	record.add(formatData(rs2.getInt("WORK_HRS"))+"");    
	    	pwsReport.add(record);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
	        stmt.close();
	       conn.close();
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	pwsReport.add(ExceptionReport);
	 	return 	pwsReport;
	 }
		
		return  pwsReport;

}

//
public static ArrayList getAssetMpwsPipelineStandPostsReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for pws pipe line distribution  report");
	ArrayList pwsReport=new ArrayList();
	ArrayList record;
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME,decode(subcompTbl.PC_LV,'Y','YES','N','NO')PC_LV1";
        finalQuery=finalQuery+query+" and subStr(subCompTbl.SPHCPCSC_CODE,17,3) like '4%'";
        
	    
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	// ohbr
    	    ResultSet rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( finalQuery);
	     try
		   {
	     	
	     	 

	     	

	     		     	
	        String sno="1";
            while(rs2.next())
           { 
            	record=new ArrayList();
            	record=new ArrayList();
	        	Statement stmt2 = conn.createStatement();
	    	    Statement stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("SPHCPCSC_CODE")+"',1,14)=substr(panch_code,1,14)");
	            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("SPHCPCSC_CODE")+"',1,14)=substr(panch_code,1,14)");
	            
	            record=new ArrayList();
	            record.add(sno);
	            try{rs3.next();
	            
	            record.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	record.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try
				{
	        		rs4.next();
	        		record.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e)
				{
	        		record.add("");
	        		//System.out.println("exception:"+e);
	        	}
	        	record.add(formatData(rs2.getString("ASSET_NAME"))+"");
            	 record.add(formatData(rs2.getString("SPHCPCSC_CODE"))+"");
            	 record.add(formatData(rs2.getInt("SP_NO"))+"");  
            	 record.add(formatData(rs2.getInt("HC_NO"))+""); 
            	 record.add(formatData(rs2.getString("PC_RF"))+"");
            	 record.add(formatData(rs2.getString("PC_UF"))+""); 
            	 record.add(formatData(rs2.getFloat("PC_HRS"))+"");       
		     	 record.add(formatData(rs2.getString("PC_LV1"))+"");     
		     	 record.add(formatData(rs2.getString("PC_SUG"))+"");       
		     	 record.add(formatData(rs2.getString("PC_FEA"))+"");     
		     	 record.add(formatData(rs2.getFloat("PC_COST"))+"");      
		     	 record.add(formatData(rs2.getInt("PC_DIS"))+""); 
		     pwsReport.add(record);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
	        stmt.close();
	       conn.close();
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	pwsReport.add(ExceptionReport);
	 	return 	pwsReport;
	 }
		
		return  pwsReport;

}




public static ArrayList getAssetMpwsPipelinePumpingmainReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for cpws reservoirs ohsr  report");
	ArrayList pwsReport=new ArrayList();
	ArrayList pwsPipelinePumpingMain;
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME";
        finalQuery=finalQuery+query+" and substr(subCompTbl.PM_CODE,17,3) like '4%'";
        
	    
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	// ohbr
    	    ResultSet rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( finalQuery);
	     try
		   {
	     	   	
	        String sno="1";
            while(rs2.next())
           { 
            	
        	pwsPipelinePumpingMain=new ArrayList();
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement(); 
    	    Statement stmt4 = conn.createStatement(); 
    	    ResultSet rs4=null;
    	    ResultSet rs3=null;
    	    try{
    	    rs3=stmt3.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("PM_CODE")+"',1,14)=substr(panch_code,1,14)");
        	}catch(Exception e){//System.out.println("Exception in statement2"+e);}
        	try{
        	rs4=stmt4.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("PM_CODE")+"',1,14)=substr(panch_code,1,14)");
        	}catch(Exception e){//System.out.println("exception in stmt3"+e);}    
        
	            pwsPipelinePumpingMain=new ArrayList();
	            pwsPipelinePumpingMain.add(sno);
	        	try{rs3.next();
	            
	        	pwsPipelinePumpingMain.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	pwsPipelinePumpingMain.add("");
	            	//System.out.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	pwsPipelinePumpingMain.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		pwsPipelinePumpingMain.add("");
	        		//System.out.println("exception:"+e);}
	        	
	        	 pwsPipelinePumpingMain.add(formatData(rs2.getString("ASSET_NAME"))+""); 
	        
	      pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_CODE"))+"");       
        	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_MAT"))+"");       
	     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_CLA"))+"");      
	     	pwsPipelinePumpingMain.add(formatData(rs2.getFloat("PM_DIA"))+"");      
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_LEN"))+"");      
	     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_COND"))+"");      
	     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_REP"))+"");       
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_AV_NO"))+"");      
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_AV_CON_G"))+"");       

	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_AV_CON_B"))+"");       
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SCRV_NO"))+"");      
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SCRV_COND_G"))+"");         
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SCRV_COND_B"))+"");        
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SV_NO"))+"");     
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SV_COND_G"))+"");        
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SV_COND_B"))+"");      
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_RV_NO"))+"");     
	     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_RV_COND_G"))+"");         
	        pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_RV_COND_B"))+"");       

        	pwsReport.add( pwsPipelinePumpingMain);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
	        stmt.close();
	       conn.close();
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	pwsReport.add(ExceptionReport);
	 	return 	pwsReport;
	 }
		
		return  pwsReport;

}

public static ArrayList getAssetMpwsReservoirsOhsrReport(DataSource dataSource,AssetCpwsReportBean reportBean,String query)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for pws reservoirs ohsr  report");
	ArrayList cpwsReport=new ArrayList();
	ArrayList pwsOhsr;
	try
	{
		
		

		/*String finalQuery="select subCompTbl.OHSR_NO,subCompTbl.OHSR_LTS," +
				"subCompTbl.OHSR_LOCATION,subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_MADE," +
				"subCompTbl.OHSR_HT,subCompTbl.OHSR_COND,subCompTbl.OHSR_FILL_HRS,subCompTbl.OHSR_EMPTY," +
				"OHSR_HYG ,OHSR_FEN,OHSR_NO_OF_FILLING,OHSR_CODE";
				*/
		//String finalQuery="select subCompTbl.*";
		String finalQuery="select  subCompTbl.*,ASSET_NAME,decode(subcompTbl.OHSR_FEN,'Y','YES','N','NO')OHSR_FEN1," +
				"decode(subcompTbl.OHSR_HYG,'G','GOOD','B','BAD')OHSR_HYG1";
				
		
		finalQuery=finalQuery+query;
        
	    
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	// ohbr
    	    ResultSet rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( finalQuery);
	     try
		   {
	        String sno="1";
            while(rs2.next())
           { 
            	
      
        
        	Statement stmt2 = conn.createStatement();
    	    Statement stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("OHSR_CODE")+"',1,14)=substr(panch_code,1,14)");
            ResultSet rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("OHSR_CODE")+"',1,14)=substr(panch_code,1,14)");
           
            pwsOhsr=new ArrayList();
            pwsOhsr.add(sno);
        	try{rs3.next();
            
        	pwsOhsr.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	pwsOhsr.add("");
            	//System.out.println("Exception"+e);
            	}
        	try{rs4.next();
        	pwsOhsr.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		pwsOhsr.add("");
        		//System.out.println("exception:"+e);}
        	try{
        	pwsOhsr.add(rs2.getString("ASSET_NAME"));
        	}
        	catch(Exception e)
			{
        		//System.out.println("Exception in assetname"+e);
        		pwsOhsr.add("");
			}
        	pwsOhsr.add(formatData(rs2.getString("OHSR_CODE")));
        	pwsOhsr.add(formatData(rs2.getString("OHSR_LOCATION")));
        	pwsOhsr.add(formatData(rs2.getInt("OHSR_NO"))+"");
            pwsOhsr.add(formatData(rs2.getFloat("OHSR_LTS"))+"");
           	pwsOhsr.add(formatData(rs2.getString("OHSR_MADE"))+"");
        	pwsOhsr.add(formatData(rs2.getFloat("OHSR_HT"))+"");
        	pwsOhsr.add(formatData(rs2.getString("OHSR_COND"))+"");
        	pwsOhsr.add(formatData(rs2.getFloat("OHSR_FILL_HRS"))+"");
        	pwsOhsr.add(formatData(rs2.getFloat("OHSR_EMPTY"))+"");
        	pwsOhsr.add(formatData(rs2.getString("OHSR_HYG1"))+"");
        	pwsOhsr.add(formatData(rs2.getString("OHSR_FEN1"))+"");
        	pwsOhsr.add(formatData(rs2.getInt("OHSR_NO_OF_FILLING"))+"");
        	
        	cpwsReport.add( pwsOhsr);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	        stmt.close();
	       conn.close();
        
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
		
		return  cpwsReport;

}
//code added on 11-10-2006//
public static ArrayList getAssetHabLinkReport(DataSource dataSource,AssetCpwsReportBean rptBean)throws Exception
{
	////System.out.println("getting data from CheckListMasterData for cpws source Rotary bore well  report");
	ArrayList report=new ArrayList();
	ArrayList report2=new ArrayList();
	ArrayList mainAssets;
	int sno=0,sno2=0;
	 ArrayList finalReport2=new ArrayList();
	ArrayList finalReport=new ArrayList();
	try
	{
		
		

		String finalQuery="select s.scheme_code,am.asset_name,am.location,am.date_creation from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where am.asset_code=s.asset_code and hab_code='"+rptBean.getHabitation()+"'";
		
		
		
        ////System.out.println("final query in asset hab link is :"+finalQuery);
        
	    
		
		
	    conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	// ohbr
    	     rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( finalQuery);
	     try
		   {
	     	String location=null;
	        sno=1;
            while(rs2.next())
           { 
            		            	
            mainAssets=new ArrayList();
            mainAssets.add(sno+"");
            mainAssets.add(rs2.getString("SCHEME_CODE"));
            mainAssets.add(rs2.getString("ASSET_NAME"));
            location=rs2.getString("LOCATION");
            if(location==null||location.equals(""))
            {	//System.out.println("location is null or ''");
            	 mainAssets.add("--");
            
            }
            else
            	mainAssets.add(rs2.getString("LOCATION"));
           mainAssets.add(rs2.getString("DATE_CREATION"));
            report.add( mainAssets);
        	
            sno++;
           }
	    }
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in Rotary borewell CheckListMasterData"+e);
			 }
	        closeAll();
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 }
	
	
	 ////System.out.println("getting data from CheckListMasterData for Asset Links  report");
	
		ArrayList linkAssets;
		try
		{
			
			
			
			String finalQuery="select s.scheme_code,am.asset_name,am.location,am.date_creation from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where where am.asset_code=s.asset_code and am.asset_code in (select asset_code from RWS_ASSET_HAB_TBL where hab_code='"+rptBean.getHabitation()+"')";
			////System.out.println("final query in asset hab link is :"+finalQuery);
	        
		    
			//String finalQuery="";/////
			
		    conn = dataSource.getConnection();
	    	stmt = conn.createStatement();
	    	// ohbr
	    	     rs2=stmt.executeQuery( finalQuery);
		        ////System.out.println( finalQuery);
		     try
			   {
		        sno2=1;
		        ////System.out.println("before while");
	            while(rs2.next())
	           { 
	            	
	            	linkAssets=new ArrayList();
	            	//linkAssets.add(sno);
	            	linkAssets.add(rs2.getString("SCHEME_CODE"));
	            	linkAssets.add(rs2.getString("ASSET_NAME"));
	            	linkAssets.add(rs2.getString("LOCATION"));
	            	linkAssets.add(rs2.getString("DATE_CREATION"));
	            	
	            report2.add( linkAssets);
	        	
	            sno2++;
	           }
	            
		    }
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in Rotary borewell CheckListMasterData"+e);
				 }
		        closeAll();
		  if(sno>sno2)
		       {
		  
		  	for(int i=0;i<(sno-sno2)+1;i++)
		       	{
		       		linkAssets=new ArrayList();
		       		linkAssets.add("--");
		       		linkAssets.add("--");
		       		linkAssets.add("--");
		       		linkAssets.add("--");
		       		 report2.add(linkAssets);
		       	}
		       }
		  
		 
          
            
            
		       
	        
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 }
		 
			
		finalReport.add(report);
		finalReport.add(report2);

	return finalReport;
	
	
	
}





public static ArrayList getAssetHabLinkReport2(DataSource dataSource,AssetCpwsReportBean rptBean)throws Exception
{
	
	ArrayList report=new ArrayList();
	ArrayList mainAssets;
	AssetHabLinkReportBean assets;
	int sno=0;
	boolean rs2Exists=false,rs3Exists=false;
	 
	////System.out.println("getting data from CheckListMasterData for AssetHabLink  report2");
	try
	{
		String finalQuery="select s.scheme_code,am.asset_name,am.location,TO_CHAR(am.date_creation,'DD-MM-YYYY')date_creation,am.asset_cost from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s " +
				"where am.asset_code=s.asset_code and hab_code='"+rptBean.getHabitation()+"'";
		////System.out.println("final query in asset hab link is :"+finalQuery);
        conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	stmt2 = conn.createStatement();
    	     rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( "query1"+finalQuery);
	      
	         finalQuery="select s.scheme_code,AM.asset_name,AM.location,TO_CHAR(AM.date_creation,'DD-MM-YYYY')date_creation,AM.asset_cost from rws_asset_mast_tbl AM,RWS_ASSET_SCHEME_TBL S where am.asset_code=s.asset_code  and am.asset_code in (select asset_code from RWS_ASSET_HAB_TBL where hab_code='"+rptBean.getHabitation()+"')";
	    	     rs3=stmt2.executeQuery( finalQuery);
		        ////System.out.println( "query2"+finalQuery);
		       
		        
		    try
		   {
	     	String location=null;
	        sno=1;
	      
	        
	        rs2Exists=rs2.next();
	      
	       
	        rs3Exists=rs3.next();
	     
            while(rs2Exists || rs3Exists)
           { 
            	
            	assets=new AssetHabLinkReportBean();
         
           assets.setSno(sno+"");
           		if(rs2Exists)
            	{
           
            		
            		 assets.setHw_scheme_code(rs2.getString("SCHEME_CODE"));
            		 assets.setHw_asset_name(rs2.getString("ASSET_NAME"));
     	            location=rs2.getString("LOCATION");
            			if(location==null||location.equals(""))
            			{	
            				assets.setHw_asset_location("--");
            			
            			}
            			else
            				assets.setHw_asset_location(location);
            			assets.setHw_date_creation(rs2.getString("DATE_CREATION"));
            			assets.setHw_asset_cost(rs2.getString("ASSET_COST"));
            		rs2Exists=rs2.next();
            	}//end of if(rs2Exists)
            	else
            	{
            		////System.out.println("in else");
            		assets.setHw_scheme_code("--");
            		assets.setHw_asset_name("--");
            		assets.setHw_asset_location("--");
            		assets.setHw_date_creation("--");
            		assets.setHw_asset_cost("--");
            	}
        	 if(rs3Exists)
        	 {
        
        	 	assets.setLinked_scheme_code(rs3.getString("SCHEME_CODE"));
       
        	 	assets.setLinked_asset_name(rs3.getString("ASSET_NAME"));
       
        	location=rs3.getString("LOCATION");
        	
				if(location==null||location.equals(""))
				{	
					assets.setLinked_asset_location("--");
		
				}
				else
					assets.setLinked_asset_location(location);
				
				assets.setLinked_date_creation(rs3.getString("DATE_CREATION"));
				
				assets.setLinked_asset_cost(rs3.getString("ASSET_COST"));
        	
        		rs3Exists=rs3.next();
        		
        	 }
        	 else
        	 {
        	 	
        	 	assets.setLinked_scheme_code("--");
        	 	assets.setLinked_asset_name("--");
        	 	assets.setLinked_asset_location("--");
        	 	assets.setLinked_date_creation("--");
        	 	assets.setLinked_asset_cost("--");
        	 	
        	 }
        
            report.add( assets);
        	
            sno++;
         
           }//end of while
	    }//end of try
	        catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in AssetHabLinkReport2 CheckListMasterData"+e);
			 }
	        closeAll();
	}
	 catch(Exception e)
	 {
	 	//System.out.println("error in getig dat in CheckListMasterData"+e);
	 }
	
	return report;

}


public static ArrayList getAssetHabLinkDistDrilldown(DataSource dataSource,AssetCpwsReportBean rptBean)throws Exception
{
	
	Connection conn=dataSource.getConnection();
	 stmt=conn.createStatement();
	 stmt2=conn.createStatement();
	 ps2=null;
	 ps3=null;
	 rs=null;
	 rs2=null;
	int sno=0;
	int habitationCount=0,mainAssetCount=0,linkedAssetCount=0;
	ArrayList report=new ArrayList();
	AssetHabLinkDrilldownBean bean;
	ArrayList record;
	
	try
	{
	String query="select dcode,dname from rws_district_tbl order by dname";
	
	rs=stmt.executeQuery(query);
	rs2=null;
	
	while(rs.next())
	{
		sno++;
	//System.out.println("in while"+sno);
	query="select count(*)count from rws_panchayat_raj_tbl where substr(panch_code,1,2)="+rs.getString("dcode");	
	ps2=conn.prepareStatement("select count(*)count from rws_panchayat_raj_tbl where substr(panch_code,1,2)=?");
	ps2.setString(1,rs.getString("dcode"));
	//rs2=stmt2.executeQuery(query);
	rs2=ps2.executeQuery();
	////System.out.println("executed query1");
	rs2.next();
	habitationCount=habitationCount+rs2.getInt(1);
	//system.out.println("habitation count"+habitationCount);
	bean=new AssetHabLinkDrilldownBean();
	bean.setSno(sno+"");
	bean.setName(rs.getString("dname"));
	bean.setCode(rs.getString("dcode"));
	bean.setHabitation(rs2.getString(1));
	query="select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)="+rs.getString("dcode");
	ps3=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)=?");
	ps3.setString(1,rs.getString("dcode"));
	
	//rs2=stmt2.executeQuery(query);
	rs2=ps3.executeQuery();
	////System.out.println("executed query2");
	rs2.next();
	//system.out.println("executed 0");
	mainAssetCount=mainAssetCount+rs2.getInt(1);
	//system.out.println("main asset count"+mainAssetCount);
	//system.out.println("executed a");
	bean.setAsset(rs2.getString(1));
	//system.out.println("executed b");
	query="select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)="+rs.getString("dcode");
	//system.out.println("executed c");
	ps2=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)=?");
	//system.out.println("executed 1");
	ps2.setString(1,rs.getString("dcode"));
	//system.out.println("executed 2");
	rs2=ps2.executeQuery();
	//system.out.println("executed query3");
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	linkedAssetCount=linkedAssetCount+rs2.getInt(1);
	//system.out.println("linked asset count"+linkedAssetCount);
	bean.setLinkAsset(rs2.getString(1));
	report.add(bean);	
	}
	}
	catch(Exception e)
	{//System.out.println("exception"+e);
	}
	finally
	{
		 closeAll();
	}
	
	////System.out.println("a0");
	
	bean=new AssetHabLinkDrilldownBean();
	////System.out.println("a1");
	bean.setSno("**");
	////System.out.println("a2");
	bean.setName("Total");
	////System.out.println("a3");
	bean.setHabitation(habitationCount+"");
	////System.out.println("a4");
	bean.setAsset(mainAssetCount+"");
	////System.out.println("a5");
	bean.setLinkAsset(linkedAssetCount+"");
	////System.out.println("a6");
	report.add(bean);
	
	
	
		return report;
}


public static ArrayList getAssetHabLinkMandalReport(DataSource dataSource,AssetCpwsReportBean rptBean,String dcode)throws Exception
{
	
	Connection conn=dataSource.getConnection();
	 ps=null;
	 ps2=null;
	 stmt=conn.createStatement();
	 stmt2=conn.createStatement();
	 rs=null;
	 rs2=null;
	ArrayList report=new ArrayList();
	AssetHabLinkDrilldownBean bean;
	ArrayList record;
	int habitationCount=0,mainAssetCount=0,linkedAssetCount=0;
	int sno=0;
	try
	{
		////System.out.println("0");
	String query="select mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by mname";
	////System.out.println("1");
	ps=conn.prepareStatement("select mcode,mname from rws_mandal_tbl where dcode=? order by mname");
	ps.setString(1,dcode);
	rs=ps.executeQuery();
	//rs=stmt.executeQuery(query);
	////System.out.println("2");
	rs2=null;

	while(rs.next())
	{
		sno++;
	query="select count(*) from rws_panchayat_raj_tbl where substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+rs.getString("mcode")+"'";	
	
	//System.out.println("in while"+sno);
	////System.out.println("3");
	ps2=conn.prepareStatement("select count(*) from rws_panchayat_raj_tbl where substr(panch_code,1,2)=? and substr(panch_code,6,2)=?");
	ps2.setString(1,dcode);
	ps2.setString(2,rs.getString("mcode"));
	rs2=ps2.executeQuery();
	////System.out.println("4");
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	
	habitationCount=habitationCount+rs2.getInt(1);
	bean=new AssetHabLinkDrilldownBean();
	bean.setSno(sno+"");
	bean.setName(rs.getString("mname"));
	bean.setCode(rs.getString("mcode"));
	bean.setHabitation(rs2.getString(1));
	query="select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)="+dcode+" and substr(hab_code,6,2)="+rs.getString("mcode");
	////System.out.println("5");
	ps2=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)=? and substr(hab_code,6,2)=?");
	ps2.setString(1,dcode);
	ps2.setString(2,rs.getString("mcode"));
	rs2=ps2.executeQuery();
	////System.out.println("6");
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	
	mainAssetCount=mainAssetCount+rs2.getInt(1);
	bean.setAsset(rs2.getString(1));
	query="select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)="+dcode+" and substr(hab_code,6,2)="+rs.getString("mcode");
	////System.out.println("7");
	ps2=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)=? and substr(hab_code,6,2)=?");
	ps2.setString(1,dcode);
	ps2.setString(2,rs.getString("mcode"));
	rs2=ps2.executeQuery();
	//rs2=stmt2.executeQuery(query);
	//rs2=stmt2.executeQuery(query);
	////System.out.println("8");
	rs2.next();

	linkedAssetCount=linkedAssetCount+rs2.getInt(1);
	bean.setLinkAsset(rs2.getString(1));
	report.add(bean);	
	}
	}
	catch(Exception e)
	{//System.out.println("exception"+e);
	}
	finally
	{
		 closeAll();
	}
	try{
	bean=new AssetHabLinkDrilldownBean();
	bean.setSno("**");
	bean.setName("Total");
	bean.setHabitation(habitationCount+"");
	bean.setAsset(mainAssetCount+"");
	bean.setLinkAsset(linkedAssetCount+"");
	 ////System.out.println("executed all");
	report.add(bean);
	}catch(Exception e){//System.out.println("exception e"+e);}
	 //System.out.println("report added");
		return report;
}


public static ArrayList getAssetHabLinkPanchayatReport(DataSource dataSource,AssetCpwsReportBean rptBean,String dcode,String mcode)throws Exception
{
	
	Connection conn=dataSource.getConnection();
	 ps=null;
	 stmt=conn.createStatement();
	 stmt2=conn.createStatement();
	 rs=null;
	 rs2=null;
	ArrayList report=new ArrayList();
	AssetHabLinkDrilldownBean bean;
	ArrayList record;
	int habitationCount=0,mainAssetCount=0,linkedAssetCount=0;
	int sno=0;
	try
	{
	String query="select pcode,pname from rws_panchayat_tbl where dcode='"+dcode+"' and mcode="+mcode+" order by pname";
	ps=conn.prepareStatement("select pcode,pname from rws_panchayat_tbl where dcode=? and mcode=? order by pname");
	ps.setString(1,dcode);
	ps.setString(2,mcode);
	rs=ps.executeQuery();
	//rs=stmt.executeQuery(query);
	rs2=null;
	
	while(rs.next())
	{
		sno++;
	query="select count(*) from rws_panchayat_raj_tbl where substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+mcode+"' and substr(panch_code,13,2)="+rs.getString("pcode");	
	ps=conn.prepareStatement("select count(*) from rws_panchayat_raj_tbl where substr(panch_code,1,2)=? and substr(panch_code,6,2)=? and substr(panch_code,13,2)=?");
	ps.setString(1,dcode);
	ps.setString(2,mcode);
	ps.setString(3,rs.getString("pcode"));
	rs2=ps.executeQuery();
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	habitationCount=habitationCount+rs2.getInt(1);
	bean=new AssetHabLinkDrilldownBean();
	bean.setSno(sno+"");
	bean.setName(rs.getString("pname"));
	bean.setCode(rs.getString("pcode"));
	bean.setHabitation(rs2.getString(1));
	query="select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)="+dcode+" and substr(hab_code,6,2)="+mcode+" and substr(hab_code,13,2)="+rs.getString("pcode");
	ps=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)=? and substr(hab_code,6,2)=? and substr(hab_code,13,2)=?");
	ps.setString(1,dcode);
	ps.setString(2,mcode);
	ps.setString(3,rs.getString("pcode"));
	rs2=ps.executeQuery();
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	mainAssetCount=mainAssetCount+rs2.getInt(1);
	bean.setAsset(rs2.getString(1));
	query="select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)="+dcode+" and substr(hab_code,6,2)="+mcode+" and substr(hab_code,13,2)="+rs.getString("pcode");
	ps=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)=? and substr(hab_code,6,2)=? and substr(hab_code,13,2)=?");
	ps.setString(1,dcode);
	ps.setString(2,mcode);
	ps.setString(3,rs.getString("pcode"));
	rs2=ps.executeQuery();
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	linkedAssetCount=linkedAssetCount+rs2.getInt(1);
	bean.setLinkAsset(rs2.getString(1));
	report.add(bean);	
	}
	}
	catch(Exception e)
	{//System.out.println("exception"+e);
	}
	finally
	{
		 closeAll();
	}
	bean=new AssetHabLinkDrilldownBean();
	bean.setSno("**");
	bean.setName("Total");
	bean.setHabitation(habitationCount+"");
	bean.setAsset(mainAssetCount+"");
	bean.setLinkAsset(linkedAssetCount+"");
	report.add(bean);
		return report;
}

public static ArrayList getAssetHabLinkVillageReport(DataSource dataSource,AssetCpwsReportBean rptBean,String dcode,String mcode,String pcode)throws Exception
{
	
	Connection conn=dataSource.getConnection();
	 ps2=null;
	 stmt=conn.createStatement();
	 stmt2=conn.createStatement();
	 rs=null;
	 rs2=null;
	ArrayList report=new ArrayList();
	AssetHabLinkDrilldownBean bean;
	ArrayList record;
	int habitationCount=0,mainAssetCount=0,linkedAssetCount=0;
	int sno=0;
	try
	{
	String query="select vcode,vname from rws_village_tbl where dcode='"+dcode+"' and mcode="+mcode+" and pcode="+pcode+" order by vname";
	ps=conn.prepareStatement("select vcode,vname from rws_village_tbl where dcode=? and mcode=? and pcode=? order by vname");
	ps.setString(1,dcode);
	ps.setString(2,mcode);
	ps.setString(3,pcode);

	rs=ps.executeQuery();
	//rs=stmt.executeQuery(query);
	rs2=null;
	
	while(rs.next())
	{
		sno++;
	query="select count(*) from rws_panchayat_raj_tbl where substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+mcode+"' and substr(panch_code,13,2)="+pcode+" and substr(panch_code,8,3)="+rs.getString("vcode");	
	////System.out.println("query1"+query);
	ps2=conn.prepareStatement("select count(*) from rws_panchayat_raj_tbl where substr(panch_code,1,2)=? and substr(panch_code,6,2)=? and substr(panch_code,13,2)=? and substr(panch_code,8,3)=?");
	ps2.setString(1,dcode);
	ps2.setString(2,mcode);
	ps2.setString(3,pcode);
	ps2.setString(4,rs.getString("vcode"));
	rs2=ps2.executeQuery();
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	habitationCount=habitationCount+rs2.getInt(1);
	bean=new AssetHabLinkDrilldownBean();
	bean.setSno(sno+"");
	bean.setName(rs.getString("vname"));
	bean.setCode(rs.getString("vcode"));
	bean.setHabitation(rs2.getString(1));
	query="select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)="+dcode+" and substr(hab_code,6,2)="+mcode+" and substr(hab_code,13,2)="+pcode+" and substr(hab_code,8,3)="+rs.getString("vcode");
	////System.out.println("query2"+query);
	//rs2=stmt2.executeQuery(query);
	ps2=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)=? and substr(hab_code,6,2)=? and substr(hab_code,13,2)=? and substr(hab_code,8,3)=?");
	ps2.setString(1,dcode);
	ps2.setString(2,mcode);
	ps2.setString(3,pcode);
	ps2.setString(4,rs.getString("vcode"));
	rs2=ps2.executeQuery();
	rs2.next();
	mainAssetCount=mainAssetCount+rs2.getInt(1);
	bean.setAsset(rs2.getString(1));
	query="select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)="+dcode+" and substr(hab_code,6,2)="+mcode+" and substr(hab_code,13,2)="+pcode+" and substr(hab_code,8,3)="+rs.getString("vcode");
	////System.out.println("query3"+query);
	ps2=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)=? and substr(hab_code,6,2)=? and substr(hab_code,13,2)=? and substr(hab_code,8,3)=?");
	ps2.setString(1,dcode);
	ps2.setString(2,mcode);
	ps2.setString(3,pcode);
	ps2.setString(4,rs.getString("vcode"));
	rs2=ps2.executeQuery();
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	linkedAssetCount=linkedAssetCount+rs2.getInt(1);
	bean.setLinkAsset(rs2.getString(1));
	report.add(bean);	
	}
	}
	catch(Exception e)
	{//System.out.println("exception"+e);
	}
	finally
	{
		 closeAll();
		
	}
	bean=new AssetHabLinkDrilldownBean();
	bean.setSno("**");
	bean.setName("Total");
	bean.setHabitation(habitationCount+"");
	bean.setAsset(mainAssetCount+"");
	bean.setLinkAsset(linkedAssetCount+"");
	report.add(bean);
		return report;
}


public static ArrayList getAssetHabLinkHabitationReport(DataSource dataSource,AssetCpwsReportBean rptBean,String dcode,String mcode,String pcode,String vcode)throws Exception
{
	
	Connection conn=dataSource.getConnection();
	 ps2=null;
	 stmt=conn.createStatement();
	 stmt2=conn.createStatement();
	 rs=null;
	 rs2=null;
	ArrayList report=new ArrayList();
	AssetHabLinkDrilldownBean bean;
	
	ArrayList record;
	int habitationCount=0,mainAssetCount=0,linkedAssetCount=0;
	int sno=0;
	try
	{
	String query="select panch_code,panch_name from rws_panchayat_raj_tbl where substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)="+mcode+"and substr(hab_code,13,2)="+pcode+" and substr(hab_code,8,3)="+vcode+" order by panch_name";
	////System.out.println("query0"+query);
	ps=conn.prepareStatement("select panch_code,panch_name from rws_panchayat_raj_tbl where substr(hab_code,1,2)=? and substr(hab_code,6,2)=? and substr(hab_code,13,2)=? and substr(hab_code,8,3)=? order by panch_name ");
	ps.setString(1,dcode);
	ps.setString(2,mcode);
	ps.setString(3,pcode);
	ps.setString(4,vcode);
	rs=ps.executeQuery();
	//rs=stmt.executeQuery(query);
	rs2=null;
	
	while(rs.next())
	{
		sno++;
	query="select count(*) from rws_panchayat_raj_tbl where substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+mcode+"' and substr(panch_code,13,2)="+pcode+" and substr(panch_code,8,3)="+vcode+" and substr(panch_code,11,2)=substr('"+rs.getString("panch_code")+"',11,2)";	
	////System.out.println("query1"+query);
	ps2=conn.prepareStatement("select count(*) from rws_panchayat_raj_tbl where substr(panch_code,1,2)=? and substr(panch_code,6,2)=? and substr(panch_code,13,2)=? and substr(panch_code,8,3)=? and substr(panch_code,11,2)=substr(?,11,2)");
	
	ps2.setString(1,dcode);
	ps2.setString(2,mcode);
	ps2.setString(3,pcode);
	ps2.setString(4,vcode);
	ps2.setString(5,rs.getString("panch_code"));
	rs2=ps2.executeQuery();
	//rs2=stmt2.executeQuery(query);
	////System.out.println("executed query"+query);
	rs2.next();
	habitationCount=habitationCount+rs2.getInt(1);
	bean=new AssetHabLinkDrilldownBean();
	bean.setSno(sno+"");
	bean.setName(rs.getString("panch_name"));
	bean.setCode(rs.getString("panch_code"));
	bean.setHabitation(rs2.getString(1));
	query="select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)="+dcode+" and substr(hab_code,6,2)="+mcode+" and substr(hab_code,13,2)="+pcode+" and substr(hab_code,8,3)="+vcode+" and hab_code=substr('"+rs.getString("panch_code")+"',1,16)";	
	ps2=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_mast_tbl where substr(hab_code,1,2)=? and substr(hab_code,6,2)=? and substr(hab_code,13,2)=? and substr(hab_code,8,3)=? and hab_code=substr(?,1,16)");
	
	ps2.setString(1,dcode);
	ps2.setString(2,mcode);
	ps2.setString(3,pcode);
	ps2.setString(4,vcode);
	ps2.setString(5,rs.getString("panch_code"));
	rs2=ps2.executeQuery();
	////System.out.println("executed query"+query);
	////System.out.println("query2"+query);
	
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	mainAssetCount=mainAssetCount+rs2.getInt(1);
	bean.setAsset(rs2.getString(1));
	//query="select distinct count(*) from rws_asset_hab_tbl where substr(hab_code,1,2)="+dcode+" and substr(hab_code,6,2)="+mcode+" and substr(hab_code,13,2)="+pcode+" and substr(hab_code,8,3)="+vcode+" and hab_code=substr('"+rs.getString("panch_code")+"',1,16)";	
	query="select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)="+dcode+" and substr(hab_code,6,2)="+mcode+" and substr(hab_code,13,2)="+pcode+" and substr(hab_code,8,3)="+vcode+" and hab_code=substr('"+rs.getString("panch_code")+"',1,16)";
	////System.out.println("query3"+query);
	ps2=conn.prepareStatement("select count(distinct(asset_code)) from rws_asset_hab_tbl where substr(hab_code,1,2)=? and substr(hab_code,6,2)=? and substr(hab_code,13,2)=? and substr(hab_code,8,3)=? and hab_code=substr(?,1,16)");
	
	ps2.setString(1,dcode);
	ps2.setString(2,mcode);
	ps2.setString(3,pcode);
	ps2.setString(4,vcode);
	ps2.setString(5,rs.getString("panch_code"));
	rs2=ps2.executeQuery();
	////System.out.println("executed query"+query);
	//rs2=stmt2.executeQuery(query);
	rs2.next();
	linkedAssetCount=linkedAssetCount+rs2.getInt(1);
	bean.setLinkAsset(rs2.getString(1));
	report.add(bean);	
	}
	}
	catch(Exception e)
	{//System.out.println("exception"+e);
	}
	finally
	{
		 closeAll();
		
	}
	bean=new AssetHabLinkDrilldownBean();
	bean.setSno("**");
	bean.setName("Total");
	bean.setHabitation(habitationCount+"");
	bean.setAsset(mainAssetCount+"");
	bean.setLinkAsset(linkedAssetCount+"");
	report.add(bean);
	return report;
}

////////////////////////**************************///////////////////////////
public static ArrayList getAssetHabLinkReportByVillageDisplayAll(DataSource dataSource,AssetCpwsReportBean rptBean)throws Exception
{
	
	ArrayList report=new ArrayList();
	ArrayList mainAssets;
	AssetHabLinkReportBean assets;
	int sno=0;
	boolean rs2Exists=false,rs3Exists=false;
	
	////System.out.println("getting data from CheckListMasterData for AssetHabLink  report");
	try
	{
		String finalQuery="select s.scheme_code,am.asset_name,am.location,TO_CHAR(AM.date_creation,'DD-MM-YYYY')date_creation,am.asset_cost from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where am.asset_code=s.asset_code and "+
				"substr(hab_code,1,2)='"+rptBean.getCircle()+"' and substr(hab_code,6,2)="+rptBean.getMandal()+" and substr(hab_code,13,2)="+rptBean.getPanchayat()+" and substr(hab_code,8,3)="+rptBean.getVillage();
		//System.out.println("final query in asset hab link is :"+finalQuery);
        conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	stmt2 = conn.createStatement();
    	     rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( "query1"+finalQuery);
	      
	         finalQuery="select s.scheme_code,am.asset_name,am.location,TO_CHAR(AM.date_creation,'DD-MM-YYYY')date_creation,am.asset_cost from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where am.asset_code=s.asset_code and  am.asset_code in (select asset_code from rws_asset_hab_tbl " +
				"where substr(hab_code,1,2)='"+rptBean.getCircle()+"' and substr(hab_code,6,2)="+rptBean.getMandal()+" and substr(hab_code,13,2)="+rptBean.getPanchayat()+" and substr(hab_code,8,3)="+rptBean.getVillage()+")";
	    	     rs3=stmt2.executeQuery( finalQuery);
		        ////System.out.println( "query2"+finalQuery);
		       
		        
		        try
				   {
			     	String location=null;
			        sno=1;
			      
			        
			        rs2Exists=rs2.next();
			      
			       
			        rs3Exists=rs3.next();
			     
		            while(rs2Exists || rs3Exists)
		           { 
		            	//System.out.println("in while");
		            	assets=new AssetHabLinkReportBean();
		         
		           assets.setSno(sno+"");
		           		if(rs2Exists)
		            	{
		           
		            		
		            		 assets.setHw_scheme_code(rs2.getString("SCHEME_CODE"));
		            		 assets.setHw_asset_name(rs2.getString("ASSET_NAME"));
		     	            location=rs2.getString("LOCATION");
		            			if(location==null||location.equals(""))
		            			{	
		            				assets.setHw_asset_location("--");
		            			
		            			}
		            			else
		            				assets.setHw_asset_location(location);
		            			assets.setHw_date_creation(rs2.getString("DATE_CREATION"));
		            			assets.setHw_asset_cost(rs2.getString("ASSET_COST"));
		            		rs2Exists=rs2.next();
		            	}//end of if(rs2Exists)
		            	else
		            	{
		            		////System.out.println("in else");
		            		assets.setHw_scheme_code("--");
		            		assets.setHw_asset_name("--");
		            		assets.setHw_asset_location("--");
		            		assets.setHw_date_creation("--");
		            		assets.setHw_asset_cost("--");
		            	}
	            	 if(rs3Exists)
	            	 {
	            
	            	 	assets.setLinked_scheme_code(rs3.getString("SCHEME_CODE"));
		       
	            	 	assets.setLinked_asset_name(rs3.getString("ASSET_NAME"));
	           
	            	location=rs3.getString("LOCATION");
	            	
	    				if(location==null||location.equals(""))
	    				{	
	    					assets.setLinked_asset_location("--");
	    		
	    				}
	    				else
	    					assets.setLinked_asset_location(location);
	    				
	    				assets.setLinked_date_creation(rs3.getString("DATE_CREATION"));
	    				
	    				assets.setLinked_asset_cost(rs3.getString("ASSET_COST"));
	            	
	            		rs3Exists=rs3.next();
	            		
	            	 }
	            	 else
	            	 {
	            	 	
	            	 	assets.setLinked_scheme_code("--");
	            	 	assets.setLinked_asset_name("--");
	            	 	assets.setLinked_asset_location("--");
	            	 	assets.setLinked_date_creation("--");
	            	 	assets.setLinked_asset_cost("--");
	            	 	
	            	 }
	            
		            report.add( assets);
		        	
		            sno++;
		         
		           }//end of while
			    }//end of try
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in AssetHabLinkReport2 CheckListMasterData"+e);
					 }
			        closeAll();
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 }
			
			return report;
		
		}

public static ArrayList getAssetHabLinkReportByMandalDisplayAll(DataSource dataSource,AssetCpwsReportBean rptBean)throws Exception
{
	
	ArrayList report=new ArrayList();
	ArrayList mainAssets;
	AssetHabLinkReportBean assets;
	int sno=0;
	boolean rs2Exists=false,rs3Exists=false;
	
	////System.out.println("in getAssetHabLinkReportByMandalDisplayAll in checkListMasterData");
	////System.out.println("getting data from CheckListMasterData for AssetHabLink  report");
	try
	{
		String finalQuery="select s.scheme_code,am.asset_name,am.location,TO_CHAR(AM.date_creation,'DD-MM-YYYY')date_creation,am.asset_cost,am.asset_cost from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where am.asset_code=s.asset_code and "+
				" substr(hab_code,1,2)='"+rptBean.getCircle()+"' and substr(hab_code,6,2)="+rptBean.getMandal();
		////System.out.println("final query in asset hab link is :"+finalQuery);
        conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	stmt2 = conn.createStatement();
    	     rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( "query1"+finalQuery);
	      
	         finalQuery="select s.scheme_code,am.asset_name,am.location,TO_CHAR(AM.date_creation,'DD-MM-YYYY')date_creation,am.asset_cost from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where am.asset_code=s.asset_code and  am.asset_code in (select asset_code from rws_asset_hab_tbl " +
				"where substr(hab_code,1,2)='"+rptBean.getCircle()+"' and substr(hab_code,6,2)="+rptBean.getMandal()+")";
	         ////System.out.println( "query2"+finalQuery);  
	          rs3=stmt2.executeQuery( finalQuery);
		      
		       
		        
		        try
				   {
			     	String location=null;
			        sno=1;
			      
			        
			        rs2Exists=rs2.next();
			      
			       
			        rs3Exists=rs3.next();
			     
		            while(rs2Exists || rs3Exists)
		           { 
		            	
		            	assets=new AssetHabLinkReportBean();
		         
		           assets.setSno(sno+"");
		           		if(rs2Exists)
		            	{
		           
		            		
		            		 assets.setHw_scheme_code(rs2.getString("SCHEME_CODE"));
		            		
		            		 assets.setHw_asset_name(rs2.getString("ASSET_NAME"));
		            		
		            		 location=rs2.getString("LOCATION");
		            		
		            		 if(location==null||location.equals(""))
		            			{	
		            				assets.setHw_asset_location("--");
		            			
		            			}
		            			else
		            				assets.setHw_asset_location(location);
		            		
		            		 assets.setHw_date_creation(rs2.getString("DATE_CREATION"));
		            		
		            		 assets.setHw_asset_cost(rs2.getString("ASSET_COST"));
		            		
		            		 rs2Exists=rs2.next();
		            	}//end of if(rs2Exists)
		            	else
		            	{
		            		////System.out.println("in else");
		            		assets.setHw_scheme_code("--");
		            		assets.setHw_asset_name("--");
		            		assets.setHw_asset_location("--");
		            		assets.setHw_date_creation("--");
		            		assets.setHw_asset_cost("--");
		            	}
	            	 if(rs3Exists)
	            	 {
	            	 	
	            	 	assets.setLinked_scheme_code(rs3.getString("SCHEME_CODE"));
	            	 	
	            	 	assets.setLinked_asset_name(rs3.getString("ASSET_NAME"));
	            	 
	            	location=rs3.getString("LOCATION");
	            	
	    				if(location==null||location.equals(""))
	    				{	
	    					assets.setLinked_asset_location("--");
	    		
	    				}
	    				else
	    					assets.setLinked_asset_location(location);
	    				
	    				assets.setLinked_date_creation(rs3.getString("DATE_CREATION"));
	    				
	    				assets.setLinked_asset_cost(rs3.getString("ASSET_COST"));
	    			
	            		rs3Exists=rs3.next();
	            		
	            	 }
	            	 else
	            	 {
	            	 	
	            	 	assets.setLinked_scheme_code("--");
	            	 	assets.setLinked_asset_name("--");
	            	 	assets.setLinked_asset_location("--");
	            	 	assets.setLinked_date_creation("--");
	            	 	assets.setLinked_asset_cost("--");
	            	 	
	            	 }
	            
		            report.add( assets);
		        	
		            sno++;
		         
		           }//end of while
			    }//end of try
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in AssetHabLinkReport2 CheckListMasterData"+e);
					 }
			        closeAll();
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 }
			
			return report;
		
		}

public static ArrayList getAssetHabLinkReportByPanchayatDisplayAll(DataSource dataSource,AssetCpwsReportBean rptBean)throws Exception
{
	
	ArrayList report=new ArrayList();
	ArrayList mainAssets;
	AssetHabLinkReportBean assets;
	int sno=0;
	boolean rs2Exists=false,rs3Exists=false;
	
	////System.out.println("getting data from CheckListMasterData for AssetHabLink  report");
	try
	{
		String finalQuery="select s.scheme_code,am.asset_name,am.location,TO_CHAR(AM.date_creation,'DD-MM-YYYY')date_creation,am.asset_cost from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where am.asset_code=s.asset_code and "+
				" substr(hab_code,1,2)='"+rptBean.getCircle()+"' and substr(hab_code,6,2)="+rptBean.getMandal()+" and substr(hab_code,13,2)="+rptBean.getPanchayat();
		////System.out.println("final query in asset hab link is :"+finalQuery);
        conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	stmt2 = conn.createStatement();
    	     rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( "query1"+finalQuery);
	      
	         finalQuery="select s.scheme_code,am.asset_name,am.location,TO_CHAR(AM.date_creation,'DD-MM-YYYY')date_creation,am.asset_cost from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where am.asset_code=s.asset_code and  am.asset_code in (select asset_code from rws_asset_hab_tbl " +
				"where substr(hab_code,1,2)='"+rptBean.getCircle()+"' and substr(hab_code,6,2)="+rptBean.getMandal()+" and substr(hab_code,13,2)="+rptBean.getPanchayat()+")";
	    	     rs3=stmt2.executeQuery( finalQuery);
		        ////System.out.println( "query2"+finalQuery);
		       
		        
		        try
				   {
			     	String location=null;
			        sno=1;
			      
			        
			        rs2Exists=rs2.next();
			      
			       
			        rs3Exists=rs3.next();
			     
		            while(rs2Exists || rs3Exists)
		           { 
		            	
		            	assets=new AssetHabLinkReportBean();
		         
		           assets.setSno(sno+"");
		           		if(rs2Exists)
		            	{
		           
		            		
		            		 assets.setHw_scheme_code(rs2.getString("SCHEME_CODE"));
		            		 assets.setHw_asset_name(rs2.getString("ASSET_NAME"));
		     	            location=rs2.getString("LOCATION");
		            			if(location==null||location.equals(""))
		            			{	
		            				assets.setHw_asset_location("--");
		            			
		            			}
		            			else
		            				assets.setHw_asset_location(location);
		            			assets.setHw_date_creation(rs2.getString("DATE_CREATION"));
		            			assets.setHw_asset_cost(rs2.getString("ASSET_COST"));
		            		rs2Exists=rs2.next();
		            	}//end of if(rs2Exists)
		            	else
		            	{
		            		////System.out.println("in else");
		            		assets.setHw_scheme_code("--");
		            		assets.setHw_asset_name("--");
		            		assets.setHw_asset_location("--");
		            		assets.setHw_date_creation("--");
		            		assets.setHw_asset_cost("--");
		            	}
	            	 if(rs3Exists)
	            	 {
	            
	            	 	assets.setLinked_scheme_code(rs3.getString("SCHEME_CODE"));
		       
	            	 	assets.setLinked_asset_name(rs3.getString("ASSET_NAME"));
	           
	            	location=rs3.getString("LOCATION");
	            	
	    				if(location==null||location.equals(""))
	    				{	
	    					assets.setLinked_asset_location("--");
	    		
	    				}
	    				else
	    					assets.setLinked_asset_location(location);
	    				
	    				assets.setLinked_date_creation(rs3.getString("DATE_CREATION"));
	    				
	    				assets.setLinked_asset_cost(rs3.getString("ASSET_COST"));
	            	
	            		rs3Exists=rs3.next();
	            		
	            	 }
	            	 else
	            	 {
	            	 	
	            	 	assets.setLinked_scheme_code("--");
	            	 	assets.setLinked_asset_name("--");
	            	 	assets.setLinked_asset_location("--");
	            	 	assets.setLinked_date_creation("--");
	            	 	assets.setLinked_asset_cost("--");
	            	 	
	            	 }
	            
		            report.add( assets);
		        	
		            sno++;
		         
		           }//end of while
			    }//end of try
			        catch(Exception e)
					 {
					 	//System.out.println("error in getig dat in AssetHabLinkReport2 CheckListMasterData"+e);
					 }
			        closeAll();
			}
			 catch(Exception e)
			 {
			 	//System.out.println("error in getig dat in CheckListMasterData"+e);
			 }
			
			return report;
		
		}

public static ArrayList getAssetHabLinkReportByDistDisplayAll(DataSource dataSource,AssetCpwsReportBean rptBean)throws Exception
{
	
	ArrayList report=new ArrayList();
	ArrayList mainAssets;
	AssetHabLinkReportBean assets;
	int sno=0;
	boolean rs2Exists=false,rs3Exists=false;
	
	////System.out.println("getting data from CheckListMasterData for AssetHabLink  report");
	try
	{
		String finalQuery="select s.scheme_code,am.asset_name,am.location,TO_CHAR(AM.date_creation,'DD-MM-YYYY')date_creation,am.asset_cost from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where am.asset_code=s.asset_code and "+
				" substr(hab_code,1,2)='"+rptBean.getCircle()+"'";
		////System.out.println("final query in asset hab link is :"+finalQuery);
        conn = dataSource.getConnection();
    	stmt = conn.createStatement();
    	stmt2 = conn.createStatement();
    	     rs2=stmt.executeQuery( finalQuery);
	        ////System.out.println( "query1"+finalQuery);
	      
	         finalQuery="select s.scheme_code,am.asset_name,am.location,TO_CHAR(AM.date_creation,'DD-MM-YYYY')date_creation,am.asset_cost from rws_asset_mast_tbl am,RWS_ASSET_SCHEME_TBL s where am.asset_code=s.asset_code and  am.asset_code in (select asset_code from rws_asset_hab_tbl " +
				"where substr(hab_code,1,2)='"+rptBean.getCircle()+"')";
	         ////System.out.println( "query2"+finalQuery);
	          rs3=stmt2.executeQuery( finalQuery);
		       
		       
		        
	         try
			   {
		     	String location=null;
		        sno=1;
		      
		        
		        rs2Exists=rs2.next();
		      
		       
		        rs3Exists=rs3.next();
		     
	            while(rs2Exists || rs3Exists)
	           { 
	            	
	            	assets=new AssetHabLinkReportBean();
	         
	           assets.setSno(sno+"");
	           		if(rs2Exists)
	            	{
	           
	            		
	            		 assets.setHw_scheme_code(rs2.getString("SCHEME_CODE"));
	            		 assets.setHw_asset_name(rs2.getString("ASSET_NAME"));
	     	            location=rs2.getString("LOCATION");
	            			if(location==null||location.equals(""))
	            			{	
	            				assets.setHw_asset_location("--");
	            			
	            			}
	            			else
	            				assets.setHw_asset_location(location);
	            			assets.setHw_date_creation(rs2.getString("DATE_CREATION"));
	            			assets.setHw_asset_cost(rs2.getString("ASSET_COST"));
	            		rs2Exists=rs2.next();
	            	}//end of if(rs2Exists)
	            	else
	            	{
	            		////System.out.println("in else");
	            		assets.setHw_scheme_code("--");
	            		assets.setHw_asset_name("--");
	            		assets.setHw_asset_location("--");
	            		assets.setHw_date_creation("--");
	            		assets.setHw_asset_cost("--");
	            	}
            	 if(rs3Exists)
            	 {
            
            	 	assets.setLinked_scheme_code(rs3.getString("SCHEME_CODE"));
	       
            	 	assets.setLinked_asset_name(rs3.getString("ASSET_NAME"));
           
            	location=rs3.getString("LOCATION");
            	
    				if(location==null||location.equals(""))
    				{	
    					assets.setLinked_asset_location("--");
    		
    				}
    				else
    					assets.setLinked_asset_location(location);
    				
    				assets.setLinked_date_creation(rs3.getString("DATE_CREATION"));
    				
    				assets.setLinked_asset_cost(rs3.getString("ASSET_COST"));
            	
            		rs3Exists=rs3.next();
            		
            	 }
            	 else
            	 {
            	 	
            	 	assets.setLinked_scheme_code("--");
            	 	assets.setLinked_asset_name("--");
            	 	assets.setLinked_asset_location("--");
            	 	assets.setLinked_date_creation("--");
            	 	assets.setLinked_asset_cost("--");
            	 	
            	 }
            
	            report.add( assets);
	        	
	            sno++;
	         
	           }//end of while
		    }//end of try
		        catch(Exception e)
				 {
				 	//System.out.println("error in getig dat in AssetHabLinkReport2 CheckListMasterData"+e);
				 }
		        finally
				{
		        	 closeAll();
				}
		}
		 catch(Exception e)
		 {
		 	//System.out.println("error in getig dat in CheckListMasterData"+e);
		 }
		
		return report;
	
	}

public static ArrayList getAssetHabLinkSubCompDetails(DataSource dataSource,String schemeCode,String assetType,String component,String subComponent)
{
	String assetCode="";
	ArrayList report=new ArrayList();
	ArrayList record=null;
	TotalCountBean countBean=null;
	String query=null;
	////System.out.println("in getAssetHabLinkSubCompDetails of checkListMaster");
	////System.out.println("assetType"+assetType);
	////System.out.println("schemeCode"+schemeCode);
	////System.out.println("component"+component);
	////System.out.println("subComponent"+subComponent);
	try{
	Connection conn=dataSource.getConnection();
	
	 stmt1=null;
	 stmt2=null;
	 rs1=null;
	 rs2=null;

	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery("select asset_code from RWS_ASSET_SCHEME_TBL where scheme_code="+schemeCode);
	if(rs1.next())
	{
	assetCode=rs1.getString("asset_code");
	}
	if(assetType.equals("pws"))
	{
		////System.out.println("in pws query execution");
		//if(component.equals("source"))
		{
			//if(subComponent.equals("borewell"))
    		{
    			//rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,3)='600' asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("BORE WELL");
    			//countBean.setCount(rs1.getString(1));
    			countBean.setCount("0");
    			report.add(countBean);
    		}
			//if(subComponent.equals("rotaryborewell"))
    		{
//    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,3)='600' asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("ROTARY BORE WELL");
    			//countBean.setCount(rs1.getString(1));
    			countBean.setCount("0");
    			report.add(countBean);
    		}
			//if(subComponent.equals("intakewell"))
    		{
//    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,3)='600' asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("INTAKE WELL");
    			//countBean.setCount(rs1.getString(1));
    			countBean.setCount("0");
    			report.add(countBean);
    		}
			//if(subComponent.equals("infiltrationwell"))
    		{
//    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,3)='600' asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("INFILTRATION WELL");
    			//countBean.setCount(rs1.getString(1));
    			countBean.setCount("0");
    			report.add(countBean);
    		}
			
		}
	
		//if(component.equals("pipeline"))
		{
			//if(subComponent.equals("distribution"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,1)='6' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("DISTRIBUTION");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("standposts"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_SP_HC_PC_SC_PARAM_TBL where substr(SPHCPCSC_CODE,17,1)= '6' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("STAND POSTS");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    			
    		}
			//if(subComponent.equals("pumpingmain"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_PM_SC_PARAM_TBL where substr(PM_CODE,17,1)='6' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("PUMPING MAIN");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			
		}
		//if(component.equals("reservoirs"))
		{
			//if(subComponent.equals("ohsr"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_OHSR_SC_PARAM_TBL  where substr(OHSR_CODE,17,1)= '6' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("OHSR");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("cisterns"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_CIS_SC_PARAM_TBL where substr(CISSC_CODE,17,1)='6' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("CISTERNS");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("glsr"))
    		{
    			countBean=new TotalCountBean();
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_GLSR_SC_PARAM_TBL  where substr(GLSR_CODE,17,1)= '6' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("GLSR");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			
		}
		//if(component.equals("pumpsets"))
		{
			//if(subComponent.equals("pumpdetails"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_PUMP_DET_SC_PARAM_TBL  where substr(PUMPDET_CODE,17,1)= '6' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("PUMP DETAILS");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("pumphouse"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_PUMPHOUSE_PARAM_TBL where substr(PUMPHOUSE_CODE,17,1)= '6' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("PUMP HOUSE");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			
		}
	
		
	}//end of pws
	if(assetType.equals("mpws"))
	{
		////System.out.println("in mpws query execution");
		//if(component.equals("source"))
		{
			//if(subComponent.equals("borewell"))
    		{
//    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,1)= '4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean=new TotalCountBean();
    			countBean.setName("BORE WELL");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("rotaryborewell"))
    		{
//    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,1)= '4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("ROTARY BORE WELL");
    			//if(rs1.next())
    			{
    			//countBean.setCount(rs1.getString(1));
    			
    			}
    			//else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    			
    		}
			//if(subComponent.equals("intakewell"))
    		{
//    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,1)='4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("INTAKE WELL");
    			//if(rs1.next())
    			{
    			//countBean.setCount(rs1.getString(1));
    			
    			}
    			//else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("infiltrationwell"))
    		{
//    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,1)='4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("INFILTRATION WELL");
    			//if(rs1.next())
    			{
    			//countBean.setCount(rs1.getString(1));
    			
    			}
    			//else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			
		}
		//if(component.equals("pipeline"))
		{
			//if(subComponent.equals("distribution"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,17,1)='4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("DISTRIBUTION");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("standposts"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_SP_HC_PC_SC_PARAM_TBL where substr(SPHCPCSC_CODE,17,1)='4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("STAND POSTS");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    			
    		}
			//if(subComponent.equals("pumpingmain"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_PM_SC_PARAM_TBL where substr(PM_CODE,17,1)='4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("PUMPING MAIN");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			
		}
		//if(component.equals("reservoirs"))
		{
			//if(subComponent.equals("ohsr"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_OHSR_SC_PARAM_TBL  where substr(OHSR_CODE,17,1)= '4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("OHSR");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("cisterns"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_CIS_SC_PARAM_TBL where substr(CISSC_CODE,17,1)='4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("CISTERNS");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("glsr"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_GLSR_SC_PARAM_TBL  where substr(GLSR_CODE,17,1)= '4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("GLSR");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			
		}
		//if(component.equals("pumpsets"))
		{
			//if(subComponent.equals("pumpdetails"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_PUMP_DET_SC_PARAM_TBL  where substr(PUMPDET_CODE,17,1)= '4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("PUMP DETAILS");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    			////System.out.println("mpws pump details added");
    		}
			//if(subComponent.equals("pumphouse"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_PUMPHOUSE_PARAM_TBL where substr(PUMPHOUSE_CODE,17,1)= '4' and asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("PUMP HOUSE");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			
		}
	
		
	}//end of mpws
	if(assetType.equals("cpws"))
	{
		////System.out.println("in cpws query execution");
		//if(component.equals("pumpsets"))
		{
			//if(subComponent.equals("pumpdetails"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_PUMP_DET_SC_PARAM_TBL where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("PUMP DETAILS");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
		}
			
		
		//if(component.equals("source"))
		{
			//if(subComponent.equals("borewell"))
    		{
    			countBean=new TotalCountBean();
    			countBean.setName("BORE WELL");
    			//if(rs1.next())
    			{
    			//countBean.setCount(rs1.getString(1));
    			
    			}
    			//else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("rotaryborewell"))
    		{
    			countBean=new TotalCountBean();
    			countBean.setName("ROTARY BORE WELL");
    			//if(rs1.next())
    			{
    			//countBean.setCount(rs1.getString(1));
    			
    			}
    			//else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("intakewell"))
    		{
    			countBean=new TotalCountBean();
    			countBean.setName("INTAKE WELL");
    			//if(rs1.next())
    			{
    			//countBean.setCount(rs1.getString(1));
    			
    			}
    			//else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    			
    		}
			//if(subComponent.equals("infiltrationwell"))
    		{
    			countBean=new TotalCountBean();
    			countBean.setName("INFILTRATION WELL");
    			//if(rs1.next())
    			{
    			//countBean.setCount(rs1.getString(1));
    			
    			}
    			//else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
		}
		//if(component.equals("headworks"))
		{
			//if(subComponent.equals("rawwatercollectionwell"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_RW_COLLWELL_PARAM_TBL  where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("RAW WATER COLLETION WELL");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("sstank"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_SS_SC_PARAM_TBL   where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("SS TANK");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			///if(subComponent.equals("ssfilters"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_SS_SC_PARAM_TBL   where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("SS FILTERS");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("rsfilters"))
    		{
    			///*******************
    			countBean=new TotalCountBean();
    			countBean.setName("RS FILTERS");
    			//if(rs1.next())
    			{
    			//countBean.setCount(rs1.getString(1));
    			
    			}
    			//else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("sump"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_SUMP_M_SC_PARAM_TBL   where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("SUMP");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("footpathbridge"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_FP_BRIDGE_PARAM_TBL  where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("FOOT PATH BRIDGE");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("pumphouse"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_PUMPHOUSE_PARAM_TBL  where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("PUMP HOUSE");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("watchmanquarter"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_WATCHMAN_PARAM_TBL where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("WATCHMAN QUARTER");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("clearwatercollectionwell"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_CW_COLLWELL_PARAM_TBL where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("CLEAR WATER COLLECTION WELL");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
		}
		//if(component.equals("pipeline"))
		{
			//if(subComponent.equals("pumpingmain"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_PM_SC_PARAM_TBL where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("PUMPING MAIN");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("gravitymain"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_GRAVITYMAIN_TBL where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("GRAVITY MAIN");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("distribution"))
    		{
    			rs1=stmt1.executeQuery("select count(*) from RWS_AST_DISTRIB_PARAM_TBL where asset_code="+assetCode);
    			countBean=new TotalCountBean();
    			countBean.setName("DISTRIBUTION");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
		}
		//if(component.equals("reservoirs"))
		{
			//if(subComponent.equals("ohsr"))
    		{
    			countBean=new TotalCountBean();
    			countBean.setName("OHSR");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("ohbr"))
    		{
				rs1=stmt1.executeQuery("select count(*) from RWS_AST_OHBR_SC_PARAM_TBL  where asset_code="+assetCode);
				countBean=new TotalCountBean();
    			countBean.setName("OHBR");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("glsr"))
    		{ 
				rs1=stmt1.executeQuery("select count(*) from RWS_AST_GLSR_SC_PARAM_TBL  where asset_code="+assetCode);
				countBean=new TotalCountBean();
    			countBean.setName("GLSR");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    			
    		}
			//if(subComponent.equals("glbr"))
    		{
				rs1=stmt1.executeQuery("select count(*) from RWS_AST_GLBR_SC_PARAM_TBL  where asset_code="+assetCode);
				countBean=new TotalCountBean();
    			countBean.setName("GLBR");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
			//if(subComponent.equals("bpt"))
    		{
				rs1=stmt1.executeQuery("select count(*) from RWS_AST_BPT_PARAM_TBL   where asset_code="+assetCode);
				countBean=new TotalCountBean();
    			countBean.setName("BPT");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    			
    		}
		}
	}//end of cpws
	if(assetType.equals("handpumps"))
	{////System.out.println("in handupmps query execution");
		//if(component.equals("source"))
		{
			//if(subComponent.equals("borewell"))
    		{
    			query="select count(*) from RWS_HP_SUBCOMP_PARAM_TBL where asset_code="+assetCode;
    			////System.out.println("query in handpumps"+query);
    			rs1=stmt1.executeQuery(query);
    			countBean=new TotalCountBean();
    			countBean.setName("BORE WELL");
    			if(rs1.next())
    			{
    			countBean.setCount(rs1.getString(1));
    			
    			}
    			else
    			{
    				countBean.setCount("--");
    			}
    			report.add(countBean);
    		}
		}
	}
	 closeAll();
	
	}catch(Exception e){//System.out.println("error"+e);}
	return report;
	
}//end of function

public static String getAssetCode(DataSource dataSource,String schemeCode)
{
	String assetCode=null;
	try
	{
	Connection conn=dataSource.getConnection();
	 stmt=conn.createStatement();
	
	 rs=stmt.executeQuery("select asset_code from rws_asset_scheme_tbl where scheme_code="+schemeCode);
	if(rs.next())
	{
		assetCode=rs.getString(1);
	}
	
	}
	catch(Exception e){//System.out.println("error in getting asset code"+e);}
	finally{
		try
		{
			 closeAll();
		}catch(Exception e){//System.out.println("error in closing connection"+e);}
	}
	return assetCode;
}

//end of code added on 11-10-06



}y
	{
	Connection conn=dataSource.getConnection();
	 stmt=conn.createStatement();
	
	 rs=stmt.executeQuery("select asset_code from rws_asset_scheme_tbl w