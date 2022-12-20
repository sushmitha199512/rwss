<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>

<html>
<head>
<script language="javascript">
function validate()
{
		
	 if(document.forms[0].bankName.value=='')
	{

		alert("please Enter Bank Name ");
				return false;
	}
	else if(document.forms[0].bankAbb.value=='')
	{
		alert("please Enter Bank Abbrivation ");
				return false;
	}
	else
		{
		
	document.forms[0].action="switch.do?prefix=/masters&page=/bank.do?mode=save";
	document.forms[0].submit();
}
}
function autocompletion(){
    for (i=0; i<document.forms.length; i++) {
     document.forms[i].setAttribute("AutoComplete","off");
    }
}
</script>
</head>
<body  onload="autocompletion()">
<html:form action="bank.do">
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
			<tr align="right">
<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>
			
			</tr>  
		</table>
	</caption>

</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Bank Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Bank Code:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="bankCode" value="<%=(String)request.getAttribute(\"bankcode\")%>" styleClass="mytext" maxlength="2" />
	</td></tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Bank Name:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="bankName"  styleClass="mytext" />
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Bank Acronym:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="bankAbb"  styleClass="mytext" maxlength="4"/>
	</td>
	</tr>
</table>

<tr>
	<td colspan="2" align="center">
	<html:button property="mode" title="Save the Fields" styleClass="btext" value="save" onclick="return validate()"/> 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

