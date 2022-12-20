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

public class JobListenerTransactions implements ServletContextListener{
	Scheduler scheduler = null;

    @Override
    public void contextInitialized(ServletContextEvent servletContext) {
            //System.out.println("Job Initialized For Transactions");
            
            try {
                    // Setup the Job class and the Job group
                   /* JobDetail job = newJob(ScheduleJob.class).withIdentity(
                                    "CronQuartzJob", "Group").build();*/
                    
            	JobDetail job = newJob(ScheduleJob_Tot_Transactions.class).withIdentity("CronQuartzJob1", "Group").build();

                    // Create a Trigger that fires every 5 minutes.
                   /* Trigger trigger = newTrigger()
                    .withIdentity("TriggerName", "Group")
                    .withSchedule(CronScheduleBuilder.cronSchedule("SS MI HH DD MON WEEKDAY"))
                    .build();*/
            		
            	 Trigger trigger = newTrigger().withIdentity("TriggerName1", "Group").withSchedule(CronScheduleBuilder.cronSchedule("0 55 22 29 * ?")).build();
            	
                    // Setup the Job and Trigger with Scheduler & schedule jobs
                    scheduler = new StdSchedulerFactory().getScheduler();
                    scheduler.start();
                    scheduler.scheduleJob(job, trigger);
            }
            catch (SchedulerException e) {
                    e.printStackTrace();
            }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContext) {
           // System.out.println("Job Destroyed");
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
