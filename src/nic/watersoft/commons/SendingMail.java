/*
 * Created on 03-May-2010
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

/**
 * @author RAMESH
 *
 */
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import javax.mail.*;
import javax.mail.Authenticator;
import javax.mail.internet.*;
import javax.activation.*;
import java.text.DateFormat;
import java.util.*;
import java.sql.*;

public class SendingMail extends HttpServlet
{
	String SMTP_HOST_NAME = "smtp.gmail.com";
	String SMTP_AUTH_USER_FROM = "";
	String SMTP_AUTH_PWD  = "";
	String SMTP_AUTH_USER_TO = "";
	PrintWriter out=null;
   public void service(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException
    {
                                   HttpSession session=req.getSession(true);
		out = resp.getWriter();
		try
		{
		SendingMail obj = new SendingMail();
		//System.out.println("in service method1");
        String pwd="",email="";
		String vid = (String)session.getAttribute("sid");
		Connection con = RwsOffices.getConn();
        Statement st=con.createStatement();
		ResultSet rs = st.executeQuery("select l.password,m.mailid from login l,masterdata m where l.userid=m.userid and l.userid='"+vid+"'");
		//System.out.println("in service method2");

		if(rs.next())
		{
			pwd = rs.getString(1);
			email = rs.getString(2);
		}
		String emailMsgTxt = "Your Login Id: "+vid+" Login Password : '"+pwd+"'";
		//System.out.println("in service method3:"+emailMsgTxt);

		String[] params = new String[4];
		params[0]="";
		params[1]= "manthenaparvathi@gmail.com";
		params[2]= "";
		params[3]= email;
		//System.out.println("in service method4");
		boolean stat = obj.sendingMail(params,emailMsgTxt,"","");
		if(stat)
			{
				out.println("Your Password Credinitial Has Sent Your Mail Id! Please Check it out!!");
			                  resp.setHeader("Refresh","3;URL=./register.jsp");
			                  
                                                     }
			{
				out.println("Your Password Credinitial Has Failed to Sent");
				resp.setHeader("Refresh","3;URL=./register.jsp");
			                  
                                                     }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}


	public boolean sendingMail(String[] params,String emailMsgTxt,String subject,String mail) 
	{
		//System.out.println("in sendingmail method");
		boolean status = false;
		boolean debug = false;
		params[0]="";
		params[1]= "rwshelpdesk@gmail.com";
		params[2]= "helpdeskrws";
		params[3]=mail;
		String serverName = params[0];
		SMTP_AUTH_USER_FROM = params[1];
		SMTP_AUTH_PWD = params[2];
		SMTP_AUTH_USER_TO = params[3];
		DateFormat df = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.SHORT);
		try
		{
			Properties props = System.getProperties();
			props.setProperty("mail.smtp.host", SMTP_HOST_NAME);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "465");

			// added below line
			props.put("mail.smtp.starttls.enable","true");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");

			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getDefaultInstance(props, auth);
			session.setDebug(debug);

			Message msg = new MimeMessage(session);
			InternetAddress addressFrom = new InternetAddress(SMTP_AUTH_USER_FROM);
			msg.setFrom(addressFrom);
			InternetAddress addressTo = new InternetAddress(SMTP_AUTH_USER_TO);
			msg.setRecipient(Message.RecipientType.TO, addressTo);

			boolean flag = false;
			int paramsLength = params.length;

			InternetAddress[] addresses = null;
			if( paramsLength-4 > 0 )
			{
				addresses = new InternetAddress[paramsLength-4];
			}

			for(int i = 4; i < paramsLength; i++ )
			{
				addresses[i-4] = new InternetAddress(params[i]);
				flag = true;
			}
			if( flag )
			{
				msg.addRecipients(Message.RecipientType.CC, addresses);
			}

			msg.setSubject(subject);
			msg.setText(emailMsgTxt);
			msg.setSentDate(new java.util.Date());

			Transport.send(msg);
			//System.out.println("Msg sent");
			status = true;
		}
		catch (Exception e)
		{
			System.out.println(" Exception : "+e);
			status = false;
		}
		return status;
	}
	public class SMTPAuthenticator extends javax.mail.Authenticator
	{
		public PasswordAuthentication getPasswordAuthentication()
		{
			return new PasswordAuthentication(SMTP_AUTH_USER_FROM, SMTP_AUTH_PWD);
		}
	}		                    
}
