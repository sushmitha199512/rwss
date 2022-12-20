<%@page import="nic.watersoft.commons.Md5Impl"%>
<%@ include file="/reports/conn.jsp" %>
<%
String userId = request.getParameter("userId");
String password = request.getParameter("password");
//System.out.println("User id:"+userId);
//System.out.println("password:"+password);
String slt=request.getParameter("slt");
String captcha = request.getParameter("captcha"); System.out.println("RWS HO captcha :"+captcha);
String currentCap = (String)session.getAttribute("forgotkey");System.out.println("RWS HO currentCap :"+currentCap);
try
{
	Statement stt = conn.createStatement();
	ResultSet rss = stt.executeQuery("select * from RWS_BANK_PASSWORD_TBL where user_id='"+userId+"' AND user_id='RWS-HO'");
	boolean validUser=false;
	if(rss.next())
	{
		if(password.equals(Md5Impl.getMd5Code(rss.getString("password")+slt)) && captcha.equals(currentCap))
		{
			validUser=true;
			session.setAttribute("hoLogged","true");
		}
		//validUser=true;
	}
	System.out.println("RWS HO validUser :"+validUser);
	if(validUser)
	{
		//////System.out.println("after sucessful login:"+request.getAttribute("encLogged"));
		%>
			<script>
			  alert("Login Successfully");
			
		document.location.href="../masters/rws_HO_homepage_frm.jsp";
		//window.open("../masters/rws_ee_homepage_frm.jsp");

			//document.location.href="rws_bill_release_to_bank.jsp";
			</script>
		<%
				//////System.out.println("after sucessful login:"+request.getAttribute("encLogged"));
				//response.sendRedirect("rws_bill_release_to_bank.jsp");
	}
	else
	{
				session.removeAttribute("hoLogged");
		%>
			<script>
				alert("Login Failed due to Invalid Password or Invalid Captcha\n\n         Login Again");
				window.close();
			</script>
		<%
	
	}
}
catch(Exception e){}
%>