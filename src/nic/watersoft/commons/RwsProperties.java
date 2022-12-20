package nic.watersoft.commons;

import java.io.InputStream;
import java.util.Properties;

/**
 * 
 * @author Sai Prasad N
 * 
 */

public class RwsProperties {

	public static final String EMAIL_ENABLE = "emailenable";
	public static final String SMS_ENABLE = "smsenable";
	public static final String EMAIL_SENDER_ID = "sender";
	public static final String EMAIL_SENDER_PWD = "senderpassword";
	public static final String SMTP_HOST_NAME = "smtphostname";
	public static final String SMTP_PORT = "smtpport";
	public static final String EMAIL_PWD_SUB = "emailsubject";
	public static final String BANK_REPOSNSE_MONITOR_PATH = "bankresponsemonitorpath";
	public static final String BANK_REPOSNSE_MONITOR_INTREVAL = "bankresponsemonitorinterval";
	public static final String BANK_REPOSNSE_MONITOR_STATUS = "bankFilemonitorEnable";

	Properties prop = null;

	private boolean isEmailEnabled;
	private boolean isSMSEnabled;
	private String sender;
	private String senderPassword;
	private String smtpHostName;
	private String emailPasswordSubject;
	private String bankResponseMonitorPath;
	private String smtpPortNo;
	private boolean isBankResponseMonitorEnable;

	private String bankResponseMonitorIntreval;

	public RwsProperties() {
		prop = new Properties();

		try {

			InputStream stream = this.getClass().getResourceAsStream(
					"watersoft.properties");
			if (stream != null) {
				prop.load(stream);
				setEmailEnabled(Boolean.parseBoolean(prop
						.getProperty(EMAIL_ENABLE)));
				setSMSEnabled(Boolean
						.parseBoolean(prop.getProperty(SMS_ENABLE)));
				setSender(prop.getProperty(EMAIL_SENDER_ID));

				setSmtpHostName(prop.getProperty(SMTP_HOST_NAME));
				setSenderPassword(prop.getProperty(EMAIL_SENDER_PWD));
				setEmailPasswordSubject(prop.getProperty(EMAIL_PWD_SUB));
				setBankResponseMonitorIntreval(prop
						.getProperty(BANK_REPOSNSE_MONITOR_INTREVAL));
				setBankResponseMonitorPath(prop
						.getProperty(BANK_REPOSNSE_MONITOR_PATH));
				setSmtpPortNo(prop.getProperty(SMTP_PORT));
				setIsBankResponseMonitorEnable(Boolean.parseBoolean(prop
						.getProperty(BANK_REPOSNSE_MONITOR_STATUS)));

				stream.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean getIsBankResponseMonitorEnable() {
		return isBankResponseMonitorEnable;
	}

	public void setIsBankResponseMonitorEnable(
			boolean isBankResponseMonitorEnable) {
		this.isBankResponseMonitorEnable = isBankResponseMonitorEnable;
	}

	public String getSmtpPortNo() {
		return smtpPortNo;
	}

	public void setSmtpPortNo(String smtpPortNo) {
		this.smtpPortNo = smtpPortNo;
	}

	public String getBankResponseMonitorPath() {
		return bankResponseMonitorPath;
	}

	public void setBankResponseMonitorPath(String bankResponseMonitorPath) {
		this.bankResponseMonitorPath = bankResponseMonitorPath;
	}

	public String getBankResponseMonitorIntreval() {
		return bankResponseMonitorIntreval;
	}

	public void setBankResponseMonitorIntreval(
			String bankResponseMonitorIntreval) {
		this.bankResponseMonitorIntreval = bankResponseMonitorIntreval;
	}

	public Properties getProp() {
		return prop;
	}

	public void setProp(Properties prop) {
		this.prop = prop;
	}

	public boolean isEmailEnabled() {
		return isEmailEnabled;
	}

	public void setEmailEnabled(boolean isEmailEnabled) {
		this.isEmailEnabled = isEmailEnabled;
	}

	public boolean isSMSEnabled() {
		return isSMSEnabled;
	}

	public void setSMSEnabled(boolean isSMSEnabled) {
		this.isSMSEnabled = isSMSEnabled;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getSenderPassword() {
		return senderPassword;
	}

	public void setSenderPassword(String senderPassword) {
		this.senderPassword = senderPassword;
	}

	public String getSmtpHostName() {
		return smtpHostName;
	}

	public void setSmtpHostName(String smtpHostName) {
		this.smtpHostName = smtpHostName;
	}

	public String getEmailPasswordSubject() {
		return emailPasswordSubject;
	}

	public void setEmailPasswordSubject(String emailPasswordSubject) {
		this.emailPasswordSubject = emailPasswordSubject;
	}

}
