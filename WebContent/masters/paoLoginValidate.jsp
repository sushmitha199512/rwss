<%@page import="nic.watersoft.commons.Md5Impl"%>
<%@ include file="/reports/conn.jsp" %>
<%
String userId = request.getParameter("userId");
String password = request.getParameter("password");
String slt=request.getParameter("slt");
//System.out.println("slt:"+slt);
try
{
	Statement stt = conn.createStatement();
	ResultSet rss = stt.executeQuery("select * from RWS_BANK_PASSWORD_TBL where user_id='"+userId+"'");
	boolean validUser=false;
	if(rss.next())
	{
		if(password.equals(Md5Impl.getMd5Code(rss.getString("password")+slt)))
		{
			validUser=true;
			request.setAttribute("encLogged","true");
			session.setAttribute("encLogged1","true");
		}
	}
	if(validUser)
	{
		
		%>
			<script>
			  alert("Login Successfully");
			</script>
		<%
				System.out.println("after sucessful login:"+request.getAttribute("encLogged"));
				response.sendRedirect("rws_bill_release_to_pao.jsp");
	}
	else
	{
		%>
			<script>
				alert("Login Failed");
				document.location.href="rws_bill_release_to_pao_login.jsp";
			</script>
		<%
	
	}
}
catch(Exception e){}
%>