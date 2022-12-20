<%@ include file="/reports/conn.jsp" %>
<html>
<form>
<%
String userid=request.getParameter("user");
String special=request.getParameter("special");
//System.out.println("special:"+special);
String oldpwd=request.getParameter("oldPassword");
String newpwd=request.getParameter("newPassword");
String cpwd=request.getParameter("confirmPassword");
try{
		String query="";
		PreparedStatement pstat=null;
		String qry=" Select PASSWORD  from rws_bank_password_tbl where  user_id='"+userid+"' ";
		stmt=conn.createStatement();
		rs=stmt.executeQuery(qry);
		while(rs.next())
		{
			if(rs.getString(1).equals(oldpwd))
			{
			   if(newpwd.equals(cpwd))
				{
					query = " UPDATE  rws_bank_password_tbl SET password = ? WHERE user_id = ? AND password = ? ";
					pstat = conn.prepareStatement(query);
					pstat.setString(1,newpwd);			
					pstat.setString(2,userid);
					pstat.setString(3,oldpwd);
					int ans = pstat.executeUpdate();
					if(ans>0 && (special!=null && special.equals("Y"))) {
					%>
					<script>
					var userid='<%=userid%>';
					var special='<%=special%>';
					 alert("Password Changed Sucessfully");
					document.location.href="rws_bank_chpwd_frm.jsp?special="+special+"&userId="+userid;
					 </script>
					<%
					}else if(ans>0 && (special!=null && special.equals("N"))){%>
					<script>
					 var userid='<%=userid%>';
					 var special='<%=special%>';
					 alert("Password Changed Sucessfully");
					 document.location.href="rws_bank_chpwd_frm.jsp?special="+special+"&userId="+userid;
					 window.close();
					 </script>
					 <%}else{%>
					  <script>
					 var special='<%=special%>';
					  alert("Password Can't Changed");
					  var userid='<%=userid%>';
					  document.location.href="rws_bank_chpwd_frm.jsp?special="+special+"&userId="+userid;
					  </script>
					<%}
				}
			}
			else
			{%>
			 <script>
			 alert("Incorrect Old Password Provided");
			 var userid='<%=userid%>';
			 var special='<%=special%>';
			 document.location.href="rws_bank_chpwd_frm.jsp?special="+special+"&userId="+userid;
             </script>
			<%}
		}
	 }catch(Exception e)
		{
		System.out.println("Exception in Change Password :"+e);
		}
%>
<input type="hidden" name="userId" value="<%=userid%>"/>
</form>
</html>