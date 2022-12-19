<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>

<%@ include file="/reports/conn.jsp"%>
<script>
function getData(){
	document.forms[0].action="switch.do?prefix=/admin&page=/resetPassword.do&mode=data"
	document.forms[0].submit();	
}
function resetUser(){
	document.forms[0].action="switch.do?prefix=/admin&page=/resetPassword.do&mode=reset"
	document.forms[0].submit();	
}
</script>

<body>
<html:form action="resetPassword.do" method="post">
	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
			<tr align="right" colspan="30">
				<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>			
			</tr>  
		</table>
	</caption>

</table>
<table align="center" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td><jsp:include page="/commons/TableHeaderWithoutClose.jsp">
				<jsp:param name="TableName" value="Reset Password" />
				<jsp:param name="TWidth" value="100%" />
			</jsp:include></td>
		</tr>
	</thead>

	<tfoot>
		<tr>
			<td><jsp:include page="/commons/TableFotter.jsp">
				<jsp:param name="TWidth" value="100%" />
			</jsp:include></td>
		</tr>
	</tfoot>
	<tbody>
		<tr>
			<td>
			<table bgcolor="white" border="1" bordercolor="#8A9FCD" rules="none"
				style="border-collapse: collapse">
				<tr><td class="btext">Select User:&nbsp;&nbsp;&nbsp;<html:select property="userId"
							style="width:133px" styleClass="mycombo" onchange="javascript:getData();" >
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="users" property="value"
								labelProperty="label" />
						</html:select></td>
						</tr>
						<tr>
						<td class="btext">Circle&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:text property="circleOfficeName" readonly="true"></html:text></td></tr>
						<tr><td class="btext">Division&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:text property="divOfficeName" readonly="true"></html:text></td>
						</tr>
						<tr >
						<td align="center" class="btext"><input type="button" value="Reset" class="btext" onclick="resetUser();"></input></td></tr>
			</table>
			</td>
		</tr>
	</tbody>
</table>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
