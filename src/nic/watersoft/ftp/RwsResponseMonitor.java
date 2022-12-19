package nic.watersoft.ftp;

import java.io.File;

import nic.watersoft.commons.RwsProperties;
import nic.watersoft.commons.RwsUtils;
import nic.watersoft.masters.RwsContractorAmtTransferDAO;

import org.apache.commons.io.monitor.FileAlterationListener;
import org.apache.commons.io.monitor.FileAlterationListenerAdaptor;
import org.apache.commons.io.monitor.FileAlterationMonitor;
import org.apache.commons.io.monitor.FileAlterationObserver;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsResponseMonitor {

	FileAlterationObserver observer = null;
	FileAlterationMonitor monitor = null;
	File folder = null;
	private long pollingInterval = 0;

	void init() {
		RwsProperties rwsProperties = new RwsProperties();
		if (rwsProperties != null
				&& rwsProperties.getIsBankResponseMonitorEnable()) {
			this.pollingInterval = Long.parseLong(rwsProperties
					.getBankResponseMonitorIntreval());

			folder = new File(rwsProperties.getBankResponseMonitorPath());
			System.out.println("File Path:"+folder.getAbsolutePath());

			if (!folder.exists()) {
				// Test to see if monitored folder exists
				folder.mkdirs();
				System.out.println("File Path:"+folder.getAbsolutePath());

			}

			start();
		}
	}

	void start() {

		observer = new FileAlterationObserver(folder);
		monitor = new FileAlterationMonitor(pollingInterval);
		FileAlterationListener listener = new FileAlterationListenerAdaptor() {
			// Is triggered when a file is created in the monitored folder
			@Override
			public void onFileCreate(File file) {
				if (RwsUtils.validateResponseFile(file.getName())) {
					String responsePath = RwsUtils.getResponseFilePath(file
							.getName());
					try {
						String status ="";// new FileSignerVerifier().FileVerifier(
								//file.getAbsolutePath(), responsePath);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					File f = new File(responsePath);
					new RwsContractorAmtTransferDAO().responseUpdateDB(f);
					// RwsUtils.fileMove(file,new File("C:\\"));
				} else {
					file.delete();
				}
			}

			// Is triggered when a file is deleted from the monitored folder
			@Override
			public void onFileDelete(File file) {
				// try {
				// } catch (IOException e) {
				// e.printStackTrace(System.err);
				// }
			}
		};

		observer.addListener(listener);
		monitor.addObserver(observer);
		try {
			monitor.start();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	void stop() {
		try {
			if (monitor != null) {
				monitor.stop();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}