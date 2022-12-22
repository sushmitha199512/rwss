package nic.watersoft.scheduler;

import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;

public class JobListener implements ServletContextListener {
        Scheduler scheduler = null;

        @Override
        public void contextInitialized(ServletContextEvent servletContext) {
                System.out.println("Job Initialized");
                
                try {
                        // Setup the Job class and the Job group
                       /* JobDetail job = newJob(ScheduleJob.class).withIdentity(
                                        "CronQuartzJob", "Group").build();*/
                        
                	JobDetail job = newJob(ScheduleJob_Hab_Schemes.class).withIdentity("CronQuartzJob", "Group").build();
                	JobDetail job1 = newJob(ScheduleJob_Tot_Transactions.class).withIdentity("CronQuartzJob1", "Group").build();
                	JobDetail jobForGeoTagging = newJob(ScheduleJob_Geo_Tagging.class).withIdentity("CronQuartzJob2", "Group").build();
                	JobDetail jobForPvtTankers = newJob(ScheduleJob_Pvt_Agent_Tankers.class).withIdentity("CronQuartzJob3", "Group").build();
                        // Create a Trigger that fires every 5 minutes.
                       /* Trigger trigger = newTrigger()
                        .withIdentity("TriggerName", "Group")
                        .withSchedule(CronScheduleBuilder.cronSchedule("0/3 * * * * ?"))
                        .build();*/
                		
                	 Trigger trigger = newTrigger().withIdentity("TriggerName", "Group")
                             .withSchedule(CronScheduleBuilder.cronSchedule("0 50 22 ? * FRI"))
                             .build();
                	 
                	 Trigger trigger1 = newTrigger().withIdentity("TriggerName1", "Group")
                			 .withSchedule(CronScheduleBuilder.cronSchedule("0 10 14 26 * ?")).build();
                	
                	 Trigger triggerForGeoTagging = newTrigger().withIdentity("TriggerForGeoTagging", "Group")
                			 .withSchedule(CronScheduleBuilder.cronSchedule("0 10 18 ? * WED")).build();
                	 
                	 Trigger triggerForPvtTankers = newTrigger().withIdentity("TriggerForPvtTankers", "Group")
                			 .withSchedule(CronScheduleBuilder.cronSchedule("0 10 22 * * ?")).build();
                			 // .withSchedule(CronScheduleBuilder.cronSchedule("0 00 16 ? * WED")).build();
                        // Setup the Job and Trigger with Scheduler & schedule jobs
                        scheduler = new StdSchedulerFactory().getScheduler();
                        scheduler.start();
                        scheduler.scheduleJob(job, trigger); 
                        scheduler.scheduleJob(job1, trigger1);
                        scheduler.scheduleJob(jobForGeoTagging, triggerForGeoTagging);
                        scheduler.scheduleJob(jobForPvtTankers, triggerForPvtTankers);
                }
                catch (SchedulerException e) {
                        e.printStackTrace();
                }
        }

        @Override
        public void contextDestroyed(ServletContextEvent servletContext) {
                System.out.println("Job Destroyed");
                try 
                {
                        scheduler.shutdown();
                } 
                catch (SchedulerException e) 
                {
                        e.printStackTrace();
                }
        }
}