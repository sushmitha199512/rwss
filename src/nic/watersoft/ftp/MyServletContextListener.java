package nic.watersoft.ftp;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import nic.watersoft.commons.RWSBankUtills;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.DailyRollingFileAppender;
import org.apache.log4j.Layout;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;

/**
 * 
 * @author Sai Prasad N
 * 
 *         Monitoring the Response Files sent By Bank
 */
public class MyServletContextListener implements ServletContextListener {

	RwsResponseMonitor responseMonitor = null;
	static Logger log = Logger.getLogger(MyServletContextListener.class
			.getName());

	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
		// System.out.println("App Destroyed:");
		// log.info("App Started");
		responseMonitor.stop();

	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		initLogger();
		responseMonitor = new RwsResponseMonitor();
		responseMonitor.init();
		//System.out.println("App Initialized");

	}

	private static void initLogger() {
		boolean isDebug = false;

		File logsdir = new File(RWSBankUtills.LOG_FILE_PATH);
		if (!logsdir.exists()) {
			logsdir.mkdirs();
		}
		String path = new File(logsdir, "serverlog").getAbsolutePath();
		try {
			if (isDebug) {
				BasicConfigurator.configure(new ConsoleAppender());
			} else {
				Layout layout = new PatternLayout("%d %x %C{1}.%M- %m%n");
				Logger.getRootLogger().addAppender(
						new DailyRollingFileAppender(layout, path,
								"'.'yyyy-MM-dd-a"));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		Logger.getRootLogger().setLevel(Level.INFO);
		Logger.getLogger("nic.watersoft").setLevel(Level.INFO);

	}
}