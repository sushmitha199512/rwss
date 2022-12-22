<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<title>Users List Form</title>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>

<table bgcolor= "yellow" align=center border=0>
<tr>
<td><a href="javascript:history.go(-1)">Back</a></td>
</tr>
</table>
<body bgcolor="#edf2f8">

<html:form action="users.do&mode=view" method="post">
	<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
				<tr align="right">
						<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Home&nbsp;&nbsp;|</a><a href="javascript:onclick=history.go(-1)">Back</td>		
				</tr>  
			</table>
		</caption>
	</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Users Info" />
	<jsp:param name="TWidth" value="570" />
	
</jsp:include>

 <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="43%" border=1 style="border-collapse:collapse">

	<tr>
	<TD class="btext" align="center">S.No</TD>
	<td class="btext" align="center">User Name</td>
	<td class="btext" align="center">Circle</td>
	<td class="btext" align="center">Division</td>
	<td class="btext" align="center">Sub Division</td>
	<td class="btext" align="center">Mobile NO</td>
	<td class="btext" align="center">E-Mail ID</td>
	</tr>

	<logic:notEmpty name="usersList" property="usersList">
	<%int count=1; %>
	<logic:iterate id="usersBean" name="usersList" property="usersList" indexId="index">	
	<tr>
	<td class="rptValue" align="left"><%=count++%></td>
	
	<td align="left" class="rptValue" >			
				<bean:write name="usersBean" property="userId" />							
		</td>
				
		<td align="left" class="rptValue">			
				<bean:write name="usersBean" property="circle"  />							
		</td>
				
		<td class="rptValue">
				<bean:write name="usersBean" property="division" />	
		</td>
		<td class="rptValue">
				<bean:write name="usersBean" property="subdivision" />	
		</td>
		<td align="left" class="rptValue">			
				<bean:write name="usersBean" property="mobileNo"  />							
		</td>
				
		<td class="rptValue">
				<bean:write name="usersBean" property="mailId" />	
		</td></tr>
	</logic:iterate>
	</logic:notEmpty>
	</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="570" />
</jsp:include>

</html:form>
 
  
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

