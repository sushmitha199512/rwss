package nic.watersoft.ftp;

import nic.watersoft.commons.RWSBankUtills;
import nic.watersoft.commons.RwsUtils;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RWSFTPClient {

	public Session session = null;
	public Channel channel = null;
	public ChannelSftp sftpChannel = null;

	/**
	 * Initializing the SFTP Client for sending the Files Through SFTP
	 * 
	 * @author Sai Prasad N
	 * @throws JSchException
	 */
	public void connectFTPServer() throws JSchException {
		JSch jsch = new JSch();
		session = jsch.getSession(RWSBankUtills.SFTP_USER_NAME,
				RWSBankUtills.SFTP_HOST_NAME, RWSBankUtills.SFTP_PORT);
		session.setConfig("StrictHostKeyChecking", "no");
		session.setPassword(RWSBankUtills.SFTP_PASSWORD);
		session.connect();
		channel = session.openChannel(RWSBankUtills.SFTP);
		channel.connect();
		sftpChannel = (ChannelSftp) channel;

	}

	/**
	 * 
	 * @param srcFileName
	 * @param destFileName
	 * @throws SftpException
	 * @author Sai Prasad N
	 */
	public void fileUpload(String srcFileName, String destFileName)
			throws SftpException {

		sftpChannel.put(srcFileName, destFileName);

	}

	/**
	 * Check the SFTP Connection established or not.
	 * 
	 * @return
	 * @author Sai Prasad N
	 */
	public boolean isConnected() {
		if (sftpChannel != null && sftpChannel.isConnected()) {
			return true;
		}
		return false;
	}

	/**
	 * Disconnect the SFTP Server Connection
	 * 
	 * @author Sai Prasad N
	 */
	public void disConnect() {
		sftpChannel.exit();
		session.disconnect();

	}

	public static void main(String[] args) {
		
	
		System.out.println("After file"+RwsUtils.getResponseFilePath("ANDBNEFTRWS17082013.R01.20131707-121531"));

//		 RWSFTPClient rwsftpClient = new RWSFTPClient();
//		 try {
//			rwsftpClient.connectFTPServer();
//		} catch (JSchException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		 if (rwsftpClient.isConnected()) {
//		 try {
//		 rwsftpClient.fileUpload("F:\\04022013.txt",
//		 RWSBankUtills.SFTP_DESTINATION_PATH + "04022013.txt");
//		 } catch (SftpException e) {
//		 // TODO Auto-generated catch block
//		 e.printStackTrace();
//		 }
//		 } else {
//		 System.out.println("Channel Not Connected");
//		 }

//		JSch jsch = new JSch();
//		Session session = null;
//		try {
//			session = jsch.getSession(RWSBankUtills.SFTP_USER_NAME,
//					RWSBankUtills.SFTP_HOST_NAME, RWSBankUtills.SFTP_PORT);
//			session.setConfig("StrictHostKeyChecking", "no");
//			session.setPassword(RWSBankUtills.SFTP_PASSWORD);
//			session.connect();
//
//			Channel channel = session.openChannel("sftp");
//			channel.connect();
//			ChannelSftp sftpChannel = (ChannelSftp) channel; //
//			// sftpChannel.get("remotefile.txt", "localfile.txt");
//			sftpChannel.put("F:\\Sample.txt", "/home/sftptest/Sample.txt");
//
//			sftpChannel.exit();
//			session.disconnect();
//		} catch (JSchException e) {
//			e.printStackTrace();
//		} catch (SftpException e) {
//			e.printStackTrace();
//		}

	}
}