<%@page import="com.sun.org.apache.xml.internal.security.utils.Base64"%>
<%@page import="nic.watersoft.commons.MakeHashUtils"%>
<%@ include file="/reports/conn.jsp" %>
<html>
<script>
	function randomString(length) 
	{
		var charStr = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	    var result = '';
	    for (var i = length; i > 0; --i){
	    	result += charStr.charAt(Math.floor(Math.random() * charStr.length));
	    }
	    return result;
	}
</script>
<form>
	<%
		Boolean flag = false;
		if(flag==false)
		{
			flag=(Boolean)session.getAttribute("AGENCY");
		}
		String userid = null;
		if(session.getAttribute("userId")==null)
		{
			response.sendRedirect(request.getContextPath()+"/rws_login_frm.jsp");
		}
		else
		{
			userid=(String)session.getAttribute("userId");
		}
		String special=request.getParameter("special");
		String oldpwd=request.getParameter("oldPassword");
		String newpwd=request.getParameter("newPassword");		
		String salt=request.getParameter("slt");		 
		try{
			String query="";
			PreparedStatement pstat=null;
			String qry="";
			if(flag != null && flag==true)
			{
			 	qry=" Select PASSWORD  from rws_agency_pwd_tbl  where  user_id= ? ";
			}
			else
			{
				 qry=" Select PASSWORD  from rws_password_tbl  where  user_id= ?";
			}
			pstat=conn.prepareStatement(qry);
			pstat.setString(1, userid);
			rs=pstat.executeQuery();
			while(rs.next()){
				String dbPwd = rs.getString(1);
				String firstPwdHash = new String(Base64.decode(dbPwd));
				String saltedFirstHash = firstPwdHash+salt;
				String secondHash = MakeHashUtils.sha256(saltedFirstHash);				
				if(secondHash.equals(oldpwd)){
			 	   if(flag != null && flag==true){
					   query = " UPDATE  rws_agency_pwd_tbl  SET password = ? WHERE user_id = ? AND password = ? ";
				   }else{
					query = " UPDATE  rws_password_tbl  SET password = ? WHERE user_id = ? AND password = ? ";
				   }
					pstat = conn.prepareStatement(query);
					pstat.setString(1,newpwd);			
					pstat.setString(2,userid);
					pstat.setString(3,dbPwd);
					int ans = pstat.executeUpdate();
					if(ans>0 && (special!=null && special.equals("Y"))) {
	%>
	<script>
			var userid='<%=userid%>';
			var special='<%=special%>';
			alert("Password Changed Sucessfully");
			document.location.href="./rws_sec_changepass_frm.jsp?special="+special+"&userid="+userid;
	</script>
	<%		}else if(ans>0 && (special!=null && special.equals("N"))){%>
	<script>
			 var userid='<%=userid%>';
			 var special='<%=special%>';
			 alert("Password Changed Sucessfully");
			 document.location.href="./rws_sec_changepass_frm.jsp?special="+special+"&userid="+userid;
			 window.close();
	</script>
	<%}else{%>
    <script>
		 var special='<%=special%>';
		 alert("Password Can't be Changed");
		 var userid='<%=userid%>';
		 document.location.href="./rws_sec_changepass_frm.jsp?special="+special+"&userid="+userid;
	</script>
	<%		}
		}else {
	%>
	<script>
		 alert("Incorrect Old Password Provided");
		 var userid='<%=userid%>';
		 var special='<%=special%>';
		 document.location.href="./rws_sec_changepass_frm.jsp?special="+special+"&userid="+userid;
    </script>
	<%			}
			}
		 }catch(Exception e){
			System.out.println("Exception in rws_sec_changepass_process Change Password :"+e);
		}
	%>
	<input type="hidden" name="userId" value="<%=userid%>"/>
</form>
</html>