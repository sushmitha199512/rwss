<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetTypeForm" />
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<script language="javascript">

function validate()
{
	if(document.forms[0].accNo.value=="")
	{
		alert("Please Enter Account No");
		return false;
	}
}
</script>

<html:form action="office.do?mode=edit" >
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
						<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Home&nbsp;&nbsp;|</a><a href="javascript:onclick=history.go(-1)">Back</td>		
				</tr>  
			</table>
		</caption>
	</table>
<table>

<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Account Update Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="300" >
<tr>
<td>
	<table  border=0  width="335"  align=center  style="margin-bottom:5;margin-top:5">
 <tr>
	<td class=mycborder >
	<FONT class=myfontclr>Circle Office Name</FONT>
	</td>
	<td class=mycborder >
	<html:text property="circleName" styleClass="mytext" readonly="true" />
	<html:hidden property="circleCode" styleClass="mytext"/>
	</td></tr>
	<tr >
	<td class=mycborder >
	<FONT class=myfontclr>Division Office Name</FONT>
	</td>
	<td class=mycborder >
	<html:text property="divisionName" styleClass="mytext"  readonly="true"/>
	<html:hidden property="divisionCode" styleClass="mytext"/>
	</td>
	</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Bank Name</FONT>
	</td>
	<td class=mycborder >
	<html:text property="bankName" styleClass="mytext" readonly="true" />
	<html:hidden property="bankCode" styleClass="mytext"/>
	</td>
	</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Branch Name</FONT>
	</td>
	<td class=mycborder >
	<html:text property="branchName" styleClass="mytext" readonly="true"/>
	<html:hidden property="branchCode" styleClass="mytext"/>
	<html:hidden property="offCode" styleClass="mytext"/>
	</td>
	</tr> 
	<html:hidden property="branchCode" styleClass="mytext"/>
	<html:hidden property="offCode" styleClass="mytext"/>
	
	<td class=mycborder >
	<FONT class=myfontclr>Account No</FONT>
	</td>
	<td class=mycborder >
	<html:text property="accNo" styleClass="mytext" maxlength="15" onkeypress="return numeralsOnly()"/>
	</td>
	</tr>
	</table>
    <tr>
	<td  align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="save" onclick="return validate()" />
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	</td>
</tr>
</table>
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


