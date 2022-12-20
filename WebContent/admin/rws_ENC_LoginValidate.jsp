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
		if(password.equals(Md5Impl.getMd5Code(rss.getString("password")+slt)))
		{
if(rss.getString(14)!=null && rss.getString(14).equals("R")){
				
				resetUser=true;
			}else {
			validUser=true;
			session.setAttribute("encLogged","true");
			}
		}
	}
	
	if(resetUser){  %>
		<script>
		var user='<%=userId %>';
		//alert(user);
		document.location.href="../admin/rws_gen_admn_changepass_frm.jsp?userId="+user;
		</script>
		<% 
	}
	if(validUser)
	{
		////System.out.println("after sucessful login:"+request.getAttribute("encLogged"));
		%>
			<script>
			  alert("Login Successfully");
			
		document.location.href="../masters/rws_ENC_homepage_frm.jsp";
		//window.open("../masters/rws_ee_homepage_frm.jsp");

			//document.location.href="rws_bill_release_to_bank.jsp";
			</script>
		<%
				////System.out.println("after sucessful login:"+request.getAttribute("encLogged"));
				//response.sendRedirect("rws_bill_release_to_bank.jsp");
	}
	else
	{
				session.removeAttribute("encLogged");
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