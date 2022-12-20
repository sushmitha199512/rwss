<html>
<head>
<title>Sai Feedback </title>
</head>
<body>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.Authenticator.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%String host="", user="", pass="";
host = "smtp.gmail.com"; 
user = "saiprasad4u2010@gmail.com";
pass = "saiprasadn";
String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
String to = "saiprasad4u2010@gmail.com"; // out going email id
String from = "saiprasad.n@malyada.com"; //Email id of the recipient
String subject = "test";
String messageText = "test mail";
boolean sessionDebug = true;
Properties props = System.getProperties();
props.put("mail.host", host);
props.put("mail.transport.protocol.", "smtp");
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.", "true");
props.put("mail.smtp.port", "465");
props.put("mail.smtp.socketFactory.fallback", "false");
props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
Session mailSession = Session.getDefaultInstance(props, null);
mailSession.setDebug(sessionDebug);
Message msg = new MimeMessage(mailSession);
msg.setFrom(new InternetAddress(from));
InternetAddress[] address = {new InternetAddress(to)};
msg.setRecipients(Message.RecipientType.TO, address);
msg.setSubject(subject);
msg.setContent(messageText, "text/html"); // use setText if you want to send text
Transport transport = mailSession.getTransport("smtp");
transport.connect(host, user, pass);
try {
transport.sendMessage(msg, msg.getAllRecipients());
out.println("Email sent");
//WasEmailSent = true; // assume it was sent
}
catch (Exception err) {
//WasEmailSent = false; // assume it's a fail
}
transport.close();

%>

</table>
</body>
</html>