package nic.watersoft.scheduler;

import java.sql.Connection;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.reports.RwsGeoTaggingFormatDownloaderDAO;

public class ScheduleJob_Geo_Tagging implements Job {
        public void execute(JobExecutionContext context)
                        throws JobExecutionException {
        	 Connection conn = null;
                            
                try
                {
                	System.out.println("geo Tagging job");
                	 conn = RwsOffices.getConn();
                	RwsGeoTaggingFormatDownloaderDAO geoTagDAO=new RwsGeoTaggingFormatDownloaderDAO();		
        			 geoTagDAO.createAssetGeoTagging(conn);
                   //  System.out.println("completed");
                	 
                     } 
                catch(Exception e)
                {
                	e.printStackTrace();
                }
                finally {
                	try {
                		if(conn!=null)
                			conn.close();
                	}
                	catch(Exception e) {
                		e.printStackTrace();
                	}
                	               	
                }
                
        }
}