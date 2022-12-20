package nic.watersoft.commons;

/**
 * 
 * @author Sai Prasad N
 * 
 * 
 */
public class RWSBankUtills {

	public static final String BANK_NAME = "ANDB";
	public static final String INTR = "INTR";
	public static final String NEFT = "NEFT";
	public static final String RTGS = "RTGS";
	public static final String BANK_FILE_CHAR = "^";
	public static final String BANK_STATUS_OPEN = "O";
	public static final String BANK_STATUS_ACKNOWLEDGED = "A";
	public static final String BANK_STATUS_PAID = "P";
	public static final String BANK_STATUS_REJECTED = "R";
	public static final String RWS_PROGRAM = "RWS";
	public static final String BANK_FILES_PATH = "/usr/local/ANDB";
	public static final String BANK_NEFT_PATH = "C:\\downloads\\ANDB\\NEFT";
	public static final String BANK_RTGS_PATH = "C:\\downloads\\ANDB\\RTGS";
	public static final String BANK_INTR_PATH = "C:\\downloads\\ANDB\\INTR";
	public static final String BANK_SUMMARY_CHAR = "T";
	public static final String BANK_REQUEST_FOLDER = "REQUEST";
	public static final String BANK_RESPONSE_FOLDER = "RESPONSE";
	public static final String BANK_SIGNED_TEMP_PATH = "C:\\downloads\\SIGNED_TEMP";
	public static final String SFTP = "sftp";
	public static final String LOG_FILE_PATH="C:\\home\\sftptest\\logs";

	/**
	 * FTP && SFTP Settings
	 */

	public static final String FTP_HOST_NAME = "10.160.0.2";
	public static final int FTP_PORT = 21;
	public static final String FTP_USER_NAME = "bkvv";
	public static final String FTP_PASSWORD = "bkvv";
	public static final String FTP_DESTINATION_PATH = "/home2/bkvv/rwss/";

	public static final String SFTP_HOST_NAME = "10.160.2.101";
	public static final int SFTP_PORT = 22;
	public static final String SFTP_USER_NAME = "sftptest";
	public static final String SFTP_PASSWORD = "sftptest123";
	public static final String SFTP_DESTINATION_PATH = "/home/sftptest/";

	/**
	 * SMS Parameters
	 */
	public static final String SMS_GATEWAY_URL = "https://smsgw.nic.in/sendsms_nic/sendmsg.php";
	public static final String SMS_USER_NAME = "smstd.auth123";
	public static final String SMS_PASSWORD = "Y1245784r";
	public static final String SENDER = "SMS-RWSS";

}
