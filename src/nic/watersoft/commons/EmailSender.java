package nic.watersoft.commons;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import nic.watersoft.admin.RwsPasswordBean;

/**
 * 
 * @author
 * 
 *         Sending email to Users
 */
public class EmailSender {

	RwsProperties rwsProperties;

	class SMTPAuthenticator extends javax.mail.Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			System.out.println("rwsProperties.getSender()"
					+ rwsProperties.getSender());
			return new PasswordAuthentication(rwsProperties.getSender(),
					rwsProperties.getSenderPassword());
		}
	}

	public String getSubjectMesg(String password) {

		String mesg = "<br>As per your request, your password has been reset.<br>Your New Password is:"
				+ "" + password;

		mesg += "<br><br><br>";
		mesg += "This is a system generated e-mail and please do not reply.<br>";

		mesg += "If you have not changed the password and you have received this e-mail, it may mean that somebody else has changed the password. Please contact 040-23494810 immediately. ";
		return mesg;
	}

	public boolean sendMail(RwsPasswordBean rwsPasswordBean,
			RwsProperties rwsProperties) {

		this.rwsProperties = rwsProperties;
		boolean status;
		try {
			Properties props = System.getProperties();

			props.setProperty("mail.smtp.host", rwsProperties.getSmtpHostName());
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", rwsProperties.getSmtpPortNo());

			// added below line
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.socketFactory.port",rwsProperties.getSmtpPortNo());
			props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");

			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getDefaultInstance(props, auth);
			// session.setDebug(debug);

			Message msg = new MimeMessage(session);
			InternetAddress addressFrom = new InternetAddress(rwsProperties.getSender());
			msg.setFrom(addressFrom);
			InternetAddress addressTo = new InternetAddress(
					rwsPasswordBean.getRegisteredMailId());
			msg.setRecipient(Message.RecipientType.TO, addressTo);

			// InternetAddress addressCC = new InternetAddress(ccAddress);
			// msg.setRecipient(Message.RecipientType.CC, addressCC);

			msg.setSubject(rwsProperties.getEmailPasswordSubject());

			String userIdMesg = "<html><body bgcolor=#FFF8DC><center><img src='BannerRow11111.jpg'></center><h4><b><font color=green>Dear  "
					+ rwsPasswordBean.getUserId() + ",  </font></b></h3>";
			String emailMsgTxt = getSubjectMesg(rwsPasswordBean
					.getRandomPassword());

			String footerMesg = "<br><br>"
					+ "<h3><b><font color=blue>Thanks & Regards <br> WaterSoft Team.</font></b></h2></body></html>";

			// msg.setText(userIdMesg + ",\r\n" + emailMsgTxt + footerMesg);
			msg.setContent(userIdMesg + "<br>" + emailMsgTxt + footerMesg,
					"text/html");
			msg.setSentDate(new java.util.Date());

			Transport.send(msg);
			// System.out.println("Msg sent");
			status = true;
		} catch (Exception e) {
			System.out.println(" Exception : " + e);
			status = false;
		}
		return status;
	}

	public static void main(String[] args) {

		final String username = "srivenu.a@gmail.com";
		final String password = "";

		Properties props = System.getProperties();

		props.setProperty("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		// added below line
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username, password);
					}
				});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("srivenu.a@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse("srivenu.a@gmail.com"));
			message.setSubject("Testing Subject");
			message.setContent(
					"<center><img src=BannerRow11111.jpg></center><h1><font color=green>This is actual message</font></h1>",
					"text/html");

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

	}

}
