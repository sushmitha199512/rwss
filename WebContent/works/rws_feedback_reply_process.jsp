<%@ page import="javax.servlet.*"%>
<%
try
{
	String mail = request.getParameter("mail");
	String reply = request.getParameter("reply");
	System.out.println("reply:"+reply);
	System.out.println("mail:"+mail);
	String[] params = new String[4];
	params[0]="";
	params[1]= "";
	params[2]= "";
	params[3]= mail;
	nic.watersoft.commons.SendingMail sm = new nic.watersoft.commons.SendingMail();
	boolean b = sm.sendingMail(params, reply,"Reg: Reply for your request",mail);
	System.out.println("b:"+b);
	String msg = "";
	if(b)msg = "Reply Sent Successfully to Specified Mail Id";
	else msg = "Mail Not Sent - Contact Administrator";
	String jspUrl = "rws_feedback_reply.jsp";
	request.setAttribute("msg",msg);
	%>
		<script>
			var msg = '<%=msg%>';
			alert(msg);
			self.close();
		</script>
	<%
	//RequestDispatcher dispatcher = null;
	//dispatcher = request.getRequestDispatcher(jspUrl);
//	dispatcher.forward(request,response);
	//response.sendRedirect(jspUrl);
}
catch(Exception e){e.printStackTrace();}
%>