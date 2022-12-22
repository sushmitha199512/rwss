package nic.watersoft.scheduler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.smsmobile.NicSmsGateway;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class ScheduleJob implements Job {
        public void execute(JobExecutionContext context)
                        throws JobExecutionException {
                
                String smsToSend = "RC TEST STATS\nKRI/GTR/KNL\n";
                String actTakenCount = "Attended: ";
                String todayTestCount = "Tested Today: ";
                String totalTestCount = "Tested So Far: ";
                String posPpmCount = "Positive: ";
                Statement stmt2 = null;
                Connection conn2 = null;
                PreparedStatement pstt2 = null;
                ResultSet rss2 = null;
                
                ArrayList<String> numList = new ArrayList<String>();
                numList.add("9440440672");
                numList.add("9704621666");
                numList.add("9100120555");
                numList.add("9100120500");
                numList.add("9100120502");
                numList.add("9100120503");
                numList.add("9100121300");
                numList.add("9100121400");
                numList.add("9100122400");
                numList.add("9100120506");
                numList.add("9100120562");
                numList.add("9248011173");
                
                ArrayList<String> dcodeList = new ArrayList<String>();
                dcodeList.add("06");
                dcodeList.add("07");
                dcodeList.add("13");
                
                conn2 = RwsOffices.getConn();
                            
                try
                {
	                for(int i=0;i<dcodeList.size();i++)
	                {
	                	String dcode = dcodeList.get(i);
	                	
	                	String sqlActionTaken = "SELECT COUNT(*) FROM RWS_RESIDUAL_CHLORINE_SMS_TBL a, RWS_MOBILE_SMS_REGISTER_TBL b WHERE TO_DATE(TO_CHAR(a.TEST_DATE,'dd-mm-yyyy'),'dd-mm-yyyy')>TO_DATE('11-08-2016','dd-mm-yyyy') AND a.ACTION_ENTERED_DATE IS NOT NULL AND TO_CHAR(a.SMS_MOBILE) = TO_CHAR(b.MOBILE) AND SUBSTR(b.HABITATION_CODE,1,2)='"+dcode+"'";
	                    String sqlSoFarTested = "SELECT COUNT(*) FROM RWS_RESIDUAL_CHLORINE_SMS_TBL a, RWS_MOBILE_SMS_REGISTER_TBL b WHERE TO_DATE(TO_CHAR(a.TEST_DATE,'dd-mm-yyyy'),'dd-mm-yyyy')>TO_DATE('11-08-2016','dd-mm-yyyy') AND TO_CHAR(a.SMS_MOBILE) = TO_CHAR(b.MOBILE) AND SUBSTR(b.HABITATION_CODE,1,2)='"+dcode+"'";
	                    String sqlPositivePPM = "SELECT COUNT(*) FROM RWS_RESIDUAL_CHLORINE_SMS_TBL a, RWS_MOBILE_SMS_REGISTER_TBL b WHERE TO_DATE(TO_CHAR(a.TEST_DATE,'dd-mm-yyyy'),'dd-mm-yyyy')>TO_DATE('11-08-2016','dd-mm-yyyy') AND PPM_VALUE<0.2 AND TO_CHAR(a.SMS_MOBILE) = TO_CHAR(b.MOBILE) AND SUBSTR(b.HABITATION_CODE,1,2)='"+dcode+"'";
	                    String sqlSameDayTest = "SELECT COUNT(*) FROM RWS_RESIDUAL_CHLORINE_SMS_TBL a, RWS_MOBILE_SMS_REGISTER_TBL b WHERE TO_DATE(TO_CHAR(a.TEST_DATE,'dd-mm-yyyy'),'dd-mm-yyyy')=TO_DATE(TO_CHAR(sysdate,'dd-mm-yyyy'),'dd-mm-yyyy')  AND TO_CHAR(a.SMS_MOBILE) = TO_CHAR(b.MOBILE) AND SUBSTR(b.HABITATION_CODE,1,2)='"+dcode+"'";
	                	
	                    System.out.println(sqlSoFarTested);
	                    
	                    pstt2 = conn2.prepareStatement(sqlSoFarTested);
	                    //pstt2.setString(1, dcode);
	                    rss2 = pstt2.executeQuery();
	                    if(rss2.next())
	                        totalTestCount += rss2.getInt(1)+"/";
	
	                    pstt2 = conn2.prepareStatement(sqlSameDayTest);
	                    //pstt2.setString(1, dcode);
	                    rss2 = pstt2.executeQuery();
	                    if(rss2.next())
	                        todayTestCount += rss2.getInt(1)+"/";
	
	                    pstt2 = conn2.prepareStatement(sqlActionTaken);
	                    //pstt2.setString(1, dcode);
	                    rss2 = pstt2.executeQuery();
	                    if(rss2.next())
	                        actTakenCount += rss2.getInt(1)+"/";
	
	                    pstt2 = conn2.prepareStatement(sqlPositivePPM);
	                    //pstt2.setString(1, dcode);
	                    rss2 = pstt2.executeQuery();
	                    if(rss2.next())
	                        posPpmCount += rss2.getInt(1)+"/";
	                    
	                }
	                
	                smsToSend += totalTestCount.substring(0,totalTestCount.length()-1)+"\n"
                                    +posPpmCount.substring(0,posPpmCount.length()-1)+"\n"
                                        +actTakenCount.substring(0,actTakenCount.length()-1)+"\n"
                                        	+todayTestCount.substring(0,todayTestCount.length()-1);
	                
	                for(String num: numList)
	                {
//	                    NicSmsGateway sms = new NicSmsGateway();
//	                    String result=  sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", num, smsToSend);
	                    String result = "Delivered";
	                    System.out.println("Status of SMS("+num+"): "+result);
	                    System.out.println("SMS to Send("+num+"): "+smsToSend);
	                    stmt2=conn2.createStatement();
                       String inoutqry="insert into RWS_SMS_IN_OUT_STATUS_TBL (MOBILE,SMS_DATE,SMS_TYPE,SMS_MODULE_AREA,SMS_DESC) values(?,SYSDATE,'PUSH','RC-P',?)";
                       System.out.println("query: "+inoutqry);
                       PreparedStatement ps =conn2.prepareStatement(inoutqry);
           	 		    ps.setString(1, num);
           	 		    ps.setString(2,result);
                       ps.executeUpdate();
                       stmt2.close();
	                }
                }
                catch(Exception e)
                {
                	e.printStackTrace();
                }
                finally {
                	try {
                		if(conn2!=null)
                			conn2.close();
                		if(stmt2!=null)
                			stmt2.close();
                		if(pstt2!=null)
                			pstt2.close();
                		if(rss2!=null)
                			rss2.close();
                	}
                	catch(Exception e) {
                		e.printStackTrace();
                	}
                }
                
        }
}