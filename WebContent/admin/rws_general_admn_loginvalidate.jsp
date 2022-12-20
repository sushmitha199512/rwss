<%@page import="nic.watersoft.commons.Md5Impl"%>
<%@ include file="/reports/conn.jsp" %>
<%@page import="nic.watersoft.admin.AdminDAO"%>
<%
	String userId = request.getParameter("userId");
	String password = request.getParameter("password");//System.out.println("GENERAL ADMIN password :"+password);
	String captcha = request.getParameter("captcha");System.out.println("GENERAL ADMIN Captcha :"+captcha);
	String slt=request.getParameter("slt");
	String user = request.getParameter("number");//System.out.println("User Entered number :"+user);
	String key = request.getParameter("key");//System.out.println("User Entered key :"+key);
	String currentCap = (String)session.getAttribute("forgotkey");System.out.println("GENERAL ADMIN currentCap  :"+currentCap);

	//String vcapstr = (String)session.getAttribute("vcapstr");System.out.println("3. vcapstr  :"+vcapstr);
	try{
		Statement stt = conn.createStatement();
		ResultSet rss = stt.executeQuery("select * from RWS_BANK_PASSWORD_TBL where user_id='"+userId+"' AND user_id='HO-ADMIN'");
		boolean validUser=false;
		if(rss.next()){	         
			if(password.equals(rss.getString("password")) && (captcha.equals(currentCap))){
				validUser=true;
				session.setAttribute("su","true");
				session.setAttribute("GeneralAdmin",userId);
			}
		}
		if(validUser){
			%>
			<script>
				alert("Login Successfully");				
				document.location.href="../admin/rws_general_admn_loginsuccess.jsp";
			</script>
				<%
					} else 	{
						session.removeAttribute("su");
						session.removeAttribute("GeneralAdmin");				
				%>
			<script>
				alert("Login Failed due to Invalid Password or Invalid captcha \n\n  Login Again");
				window.close();
			</script>
			  <%					}
							}
					catch(Exception e){}
			  %>