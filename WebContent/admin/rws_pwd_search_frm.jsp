<%@page import="java.security.SecureRandom"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	if(users != null ){
		String userid = users.getUserId();	
           if(userid!=null && (!userid.equals("admin") && !userid.equals("100000") && !userid.equals("EE-Budget"))){		            	   
        	   response.sendRedirect("../commons/rws_not_authorization.jsp");
           }
	}else{
		 response.sendRedirect("../masters/sessionExpired.jsp");
	}	
%>
<script>
function fnData() {
	 document.forms[0].action="./rws_pwd_search_frm.jsp";
	 document.forms[0].submit();
}

function userCheck() {
	var response = '';
	 var path=  window.location.href;
	 var arr  = path.split("pred/");
	 $.ajax({ type: "POST",   
	          url: "switch.do?prefix=/admin&page=/ajaxCall.do&modeCheck=AuthCheck&urlPath="+encodeURIComponent(arr[1]),
	          async: false,
	          success : function(resp)
	          {
	        	  resp;
	             // window.location = '/../commons/UnAuthorize.jsp';
	             // document.location.href="/pred/commons/UnAuthorize.jsp";
	          }
	 });  	
}
</script>
<body onload="userCheck();">
<form>
<body onFocus="document.forms[0].userId.focus();">
<%
try {
    PreparedStatement stmt1=null;
	ResultSet rs1=null;
	String user="";
	if(request.getParameter("userId")!=null && !request.getParameter("userId").equals("")){
		user=request.getParameter("userId");
	}else{}
%>
	<table align="center" cellpadding="0" cellspacing="0">
	<thead>
	<tr>
		<td>
			<jsp:include page="/commons/TableHeader.jsp">
				<jsp:param name="TableName" value="Password Search Form" />
				<jsp:param name="TWidth" value="100%" />
			</jsp:include>
		</td>
	</tr>
	</thead>

	<tfoot>
	<tr>
		<td>
			<jsp:include page="/commons/TableFotter.jsp">
				<jsp:param name="TWidth" value="100%" />
			</jsp:include>
		</td>
	</tr>
	</tfoot>
	<tbody>
	<tr>
	<td>
	<table  bgcolor="white" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
	
	<tr >
		<td bgcolor="#DEE3E0" class=rptvalue>User Id: <font color="red">*</font>&nbsp;<input type="text" name="userId" maxlength=15 size=15 value=<%=user%>>&nbsp;&nbsp;&nbsp;<input type="button" name="button" value="Submit" onclick="fnData()"></td></tr>
	<%
	if(user!=null && !user.equals("")&& !user.equals("admin")) {		
		//String randomPwd = MakeHashUtils.getRandomString(6);
		String randomPwd = MakeHashUtils.genPassword();
		String qry="select password from rws_password_tbl where user_id= ? ";
		PreparedStatement ps1=conn.prepareStatement(qry);
		ps1.setString(1, user);
		rs=ps1.executeQuery();
		if(rs.next()){
			String hashNewPwd = MakeHashUtils.sha256(randomPwd);		
			String updateQry="update rws_password_tbl set password= ? where user_id= ? ";
			PreparedStatement stmt2=conn.prepareStatement(updateQry);
			stmt2.setString(1, hashNewPwd);
			stmt2.setString(2, user);
			stmt2.executeUpdate(); 
		%>
		  <tr>
		  <td class=rptvalue>Password is&nbsp;:<font color="green"><%=randomPwd%></font></td></tr>
		<%}else{%>
		<script>
			alert("Please Enter Valid UserId");
			document.location.href="rws_pwd_search_frm.jsp";
		</script> 
		<%}
   }
}catch(Exception e){%> 
<script>
	alert("Please Enter Valid UserId");
	document.location.href="rws_pwd_search_frm.jsp";
</script> 
<%}finally{
	if(conn!=null)
	 conn.close();
}%>
</table>
</tbody>
</table>
</form>
</body>
