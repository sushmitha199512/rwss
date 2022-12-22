<html>
<head>
<title>JSP JavaMail Example </title>
</head>
<body>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%
String host = "mail.malyada.com";
String to = "saiprasad4u2010@gmail.com";//request.getParameter("to");
String from = "saiprasad.n@malyada.com";//request.getParameter("from");
String subject = "Heeloww";//request.getParameter("subject");
String messageText = "Body ingofmjfjf";//request.getParameter("body");
boolean sessionDebug = false;
// Create some properties and get the default Session.
Properties props = System.getProperties();
 props.put("mail.smtp.starttls.enable","true"); 
props.put("mail.smtp.host", host);
props.put("mail.smtp.port","25");
props.put("mail.transport.protocol", "smtp");
props.put("mail.smtp.auth", "false");
props.put("mail.user", "saiprasad.n"); 
props.put("mail.password","saiprasad2012"); 



Session mailSession = Session.getDefaultInstance(props);
 
// Set debug on the Session
// Passing false will not echo debug info, and passing True will.
 
mailSession.setDebug(sessionDebug);
 
// Instantiate a new MimeMessage and fill it with the 
// required information.
 
Message msg = new MimeMessage(mailSession);
try{
msg.setFrom(new InternetAddress(from));
InternetAddress[] address = {new InternetAddress(to)};
msg.setRecipients(Message.RecipientType.TO, address);
msg.setSubject(subject);
msg.setSentDate(new Date());
msg.setText(messageText);

// Hand the message to the default transport service
// for delivery.
 
Transport.send(msg);
out.println("Mail was sent to " + to);
out.println(" from " + from);
out.println(" using host " + host + ".");
 }catch(Exception e){
e.printStackTrace();
}
%>
</table>
</body>
</html>