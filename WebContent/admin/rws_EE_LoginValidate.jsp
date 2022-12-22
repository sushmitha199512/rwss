<%@page import="nic.watersoft.commons.Md5Impl"%>
<%@ include file="/reports/conn.jsp" %>
<%
String userId = request.getParameter("userId");
String password = request.getParameter("password");
//System.out.println("User id:"+userId);
//System.out.println("password:"+password);
String slt=request.getParameter("slt");
try
{
	Statement stt = conn.createStatement();
	ResultSet rss = stt.executeQuery("select * from RWS_PASSWORD_TBL where user_id='"+userId+"'");
	boolean validUser=false;
	boolean resetUser=false;
	if(rss.next())
	{
 String saltedPassword=Md5Impl.getMd5Code(rss.getString(3)+slt);
		if(password.equals(saltedPassword))
		{
			
if(rss.getString(14)!=null && rss.getString(14).equals("R")){
				
				resetUser=true;
			}else {
			validUser=true;
			session.setAttribute("eeLogged","true");
			}
		}
	}
	if(resetUser)
	{
		////System.out.println("after sucessful login:"+request.getAttribute("encLogged"));
		%>
			<script>
			var user='<%=userId %>';
			//alert(user);
			document.location.href="../admin/rws_gen_admn_changepass_frm.jsp?userId="+user;
		//window.open("../masters/rws_ee_homepage_frm.jsp");

			//document.location.href="rws_bill_release_to_bank.jsp";
			</script>
		<%
				////System.out.println("after sucessful login:"+request.getAttribute("encLogged"));
				//response.sendRedirect("rws_bill_release_to_bank.jsp");
	}
	if(validUser)
	{
		////System.out.println("after sucessful login:"+request.getAttribute("encLogged"));
		%>
			<script>
			  alert("Login Successfully");
			
		document.location.href="../masters/rws_ee_homepage_frm.jsp";
		//window.open("../masters/rws_ee_homepage_frm.jsp");

			//document.location.href="rws_bill_release_to_bank.jsp";
			</script>
		<%
				////System.out.println("after sucessful login:"+request.getAttribute("encLogged"));
				//response.sendRedirect("rws_bill_release_to_bank.jsp");
	}
	else
	{
				session.removeAttribute("eeLogged");
		%>
			<script>
				alert("Login Failed due to Invalid Password \n\n         Login Again");
				window.close();
			</script>
		<%
	
	}
}
catch(Exception e){}
%>