<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String useridd = users.getUserId();
	System.out.println("useridd:"+useridd);
%>
<script>
function fnData()
{
	if(document.forms[0].userId.value.length!=3)
	{
		alert("Please Enter valid User Id");
	}
	else{
		var user3Code = '<%=useridd.substring(0,3)%>';
		document.forms[0].action="./rws_pwd_search_frm1.jsp";
		document.forms[0].submit();
	}
}
</script>
<form>
<body onFocus="document.forms[0].userId.focus()">
<%
try
 {
System.out.println("useridd.substring:"+useridd.substring(3,6));
	if(useridd!=null && useridd.substring(3,6).equals("000")){
    Statement stmt1=null;
	ResultSet rs1=null;
	String user="",user1="";
	if(request.getParameter("userId")!=null && !request.getParameter("userId").equals(""))
	{user=useridd.substring(0,3)+request.getParameter("userId");
	user1 = request.getParameter("userId");}else{user1="";}%>
	<table align="center" cellpadding="0" cellspacing="0">
	<thead>
	<tr>
		<td>
			<jsp:include page="/commons/TableHeader.jsp">
				<jsp:param name="TableName" value="Search Form" />
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
		<td bgcolor="#DEE3E0" class=rptvalue align=center>User Id: <font color="red">*</font>&nbsp;<input type="text" name="userIdd" maxlength=3 style="width:25px" readonly value=<%=useridd.substring(0,3)%>><input type="text" name="userId" maxlength=3 style="width:30px" value="<%=user1%>">&nbsp;&nbsp;&nbsp;<input type="button" name="button" value="Get Password" onclick="fnData()" class="btext"></td></tr>
	<%
	if(user!=null && !user.equals("") && user.length()==6 && !user.substring(1,3).equals("00")) 
	{
		String qry1="Select distinct circle_office_name ";
		if(!user.substring(3,4).equals("0"))
		{
		  qry1+=",division_office_name ";
		} 
		if(!user.substring(4,6).equals("00"))
		{
			qry1+=",subdivision_office_name ";
		}
		qry1+=" from rws_complete_office_view where circle_office_code='"+user.substring(1,3)+"' ";
		if(!user.substring(3,4).equals("0"))
		{
		 qry1+="and division_office_code='"+user.substring(3,4)+"'  ";
		}
		if(!user.substring(4,6).equals("00") && !user.substring(4,6).equals("AO") && !user.substring(4,6).equals("EE"))
		{
		qry1+=" and subdivision_office_code='"+user.substring(4,6)+"' ";
		}
		System.out.println("qry1:"+qry1);
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(qry1);
		if(rs1.next())
		{%>
		
		<tr><td class=btext>
		<table>
		<tr><td class=btext>Circle</td><td class=rptValue><font color=black><%=rs1.getString(1)%></font></td>
		<%
		if(!user.substring(3,4).equals("0")){%>
		<tr><td class=btext>Division</td><td class=rptValue><font color=black><%=rs1.getString(2)%></font></td>
		<%}
		if(!user.substring(4,6).equals("00") && !user.substring(4,6).equals("AO") && !user.substring(4,6).equals("EE"))
		{%>
		  <tr><td class=btext>Sub Division</td><td class=rptValue><font color=black><%=rs1.getString(3)%></font></td>
		<%}%>
		</table></td></tr>
		<%}
		String qry="select password from rws_password_tbl where user_id='"+user+"' ";
		stmt=conn.createStatement();
		rs=stmt.executeQuery(qry);
		if(rs.next())
		{%>
		  <tr>
		  <td class=rptvalue>Password for User ID(<b><%=user%></b>):<font color="green"><b><%=rs.getString(1)%></b></font></td></tr>
		<%}else{%>
		<script>
			alert("Please Enter Valid UserId");
			document.location.href="rws_pwd_search_frm1.jsp";
		</script> 
		<%}
   }
	 }
	 else
	 {%>
		<script>
			document.location.href="../commons/UnAuthorize.jsp";
		</script> <%
	 }
}catch(Exception e){%> 
<script>
	alert("Please Enter Valid UserId");
	document.location.href="rws_pwd_search_frm1.jsp";
</script> 
<%}finally{
try{
	if(conn!=null)
	 conn.close();
}catch(Exception e){}
}%>
</table>
</tbody>
</table>
</form>

