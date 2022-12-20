package nic.watersoft.masters;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nic.watersoft.commons.RWSBankUtills;
import nic.watersoft.ftp.RWSFTPClient;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.SftpException;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsPaymentConfirmationAction extends Action {

	private static String VIEW = "view";
	private static String SFTP_SEND = "sftp";
	static Logger log = Logger.getLogger(RwsPaymentConfirmationAction.class
			.getName());
	

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RwsPaymentConfirmationDAO rConfirmationDAO = new RwsPaymentConfirmationDAO();
		RwsPaymentConfirmationBean rwsPaymentConfirmationBean = (RwsPaymentConfirmationBean) form;

		String mode = request.getParameter("mode");
		if (mode != null && mode.equals(VIEW)) {

			rwsPaymentConfirmationBean.setFilesTobeSentList(rConfirmationDAO
					.getFilesToBeSentList());
		}
		if (mode != null && mode.equals(SFTP_SEND)) {
			mode = "view";
			int recLength = 0;
			if (request.getParameter("resultCount") != null) {
				recLength = Integer.parseInt(request
						.getParameter("resultCount"));
			}

			if (recLength > 0) {
				processSFTPFile(rwsPaymentConfirmationBean, request,
						rConfirmationDAO, recLength);

			}

		}

		return mapping.findForward(mode);

	}

	private String processSFTPFile(
			RwsPaymentConfirmationBean rwsPaymentConfirmationBean,
			HttpServletRequest request,
			RwsPaymentConfirmationDAO rConfirmationDAO, int recLength) {
		RWSFTPClient rwsftpClient = new RWSFTPClient();
		/**
		 * Connect TO FTP/SFTP Server
		 */
		try {
			rwsftpClient.connectFTPServer();
		} catch (JSchException e1) {
			e1.printStackTrace();
			request.setAttribute("message", "SFTP Server Not Connected.");
		}
		boolean flag = true;

		if (rwsftpClient.isConnected()) {

			for (int i = 0; i < recLength; i++) {

				if (request.getParameter("rFileStatusRecord[" + i + "].checks") != null
						&& request.getParameter(
								"rFileStatusRecord[" + i + "].checks").equals(
								"on")) {

					RwsFileStatusRecord r = (RwsFileStatusRecord) rwsPaymentConfirmationBean
							.getFilesTobeSentList().get(i);

					try {

						File f = new File(r.getFileName());

						// System.out.println("File name:" + f.getName());
						String destinationFile = createTempSignedFile(f
								.getName(), request);

						log.info("Signing File:" + f.getName());
						log.info("Created temp File:" + destinationFile);

						// System.out.println("File Path:" + r.getFileName());

						File tempFile = new File(destinationFile);
						String status = "";//new FileSignerVerifier().FileSigning(r.getFileName(), destinationFile);
						//String status = "S";
						if (status != null && status.equals("S")) {
							try {
								rwsftpClient.fileUpload(destinationFile,
										RWSBankUtills.SFTP_DESTINATION_PATH
												+ f.getName());
								
								request
								.setAttribute("message",
										"File Uploaded To Server Successfully."
												+ status);
						
								if (!tempFile.delete()) {
									log.info("File Deleteed");
								}
							} catch (SftpException e) {
								rwsftpClient.disConnect();
								request
										.setAttribute("message",
												"File Upload To Server Error."
														+ status);
								if (!tempFile.delete()) {
									log.info("File Deleteed");
								}
								flag = false;
								e.printStackTrace();
								

							}
						} else {
							if (!tempFile.delete()) {
								log.info("File Deleteed");
							}
							log.info("Deleted Temp File:" + destinationFile);

							request.setAttribute("message", "Signing Failed."
									+ status);
						}

					} catch (Exception e) {

						e.printStackTrace();
						rwsftpClient.disConnect();
						request.setAttribute("message", "Send Failed.");
						flag = false;
					}
					if (flag) {
						//rConfirmationDAO.updateDB(r.getFileName());
					}

				}
			}
			rwsftpClient.disConnect();
		}
		// rFileStatusRecord[0].checks=on
		rwsPaymentConfirmationBean.setFilesTobeSentList(rConfirmationDAO
				.getFilesToBeSentList());
		return null;
	}

	private String createTempSignedFile(String destinationFileName,
			HttpServletRequest request) {

		File dir = new File(RWSBankUtills.BANK_SIGNED_TEMP_PATH);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		String fPath = RWSBankUtills.BANK_SIGNED_TEMP_PATH + File.separatorChar
				+ destinationFileName;

		//System.out.println("fPath:" + fPath);

		File file = new File(fPath);
		if (!file.exists()) {
			try {
				if (file.createNewFile()) {
					return fPath;
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}

}
