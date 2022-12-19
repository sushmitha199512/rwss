<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetTypeForm" />
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<script language="javascript">
function getDivisioncode()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/branch.do?mode=division2";
	document.forms[0].submit();
}
function validate()
{
	 if(document.forms[0].bankName.value=='')
	{
		alert("please Enter Bank Name ");
		return false;
	}
	else if(document.forms[0].branchCode.value=='')
	{
		alert("please Enter BranchCode ");
		return false;
	}
	else if(document.forms[0].branchName.value=='')
	{
		alert("please Enter Branch Name ");
		return false;
	}
	else if(document.forms[0].micrCode.value=='')
	{
		alert("please Enter MICR Code ");
		return false;
	}
}
</script>
<html:form action="branch.do?mode=edit" >
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
	<jsp:param name="TableName" value="Branch Update Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
<!-- <tr>
	<td class="mycborder">
	<FONT class=myfontclr>Bank Code<font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="bcode" styleClass="mycombo" style="width:123px">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="bankcode">
	<html:options collection="bankcode" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</tr>  -->
 <tr>
	<td class=mycborder >
	<FONT class=myfontclr>Bank:</FONT>
	</td>
	<td class=mycborder >
	<html:text property="bankName" styleClass="mytext" readonly="true" />
	</td></tr>
 <tr > 
		<td class=mycborder >
	<FONT class=myfontclr>Circle:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	
	<html:select property="circleCode" styleClass="mycombo" style="width:123px" onchange="javascript:getDivisioncode()">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="circlecode">
	<html:options collection="circlecode" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Division:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	
	<html:select property="divisionCode" styleClass="mycombo" style="width:123px" >
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="divisioncode">
	<html:options collection="divisioncode" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</td>
	</tr>
	<tr >
	<td class=mycborder >
	<FONT class=myfontclr>Branch Code:</FONT>
	</td>
	<td class=mycborder >
	<html:text property="branchCode" styleClass="mytext" maxlength="2" readonly="true" />
	</td>
	</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Branch Name:</FONT>
	</td>
	<td class=mycborder >
	<html:text property="branchName" styleClass="mytext" />
	</td>
	</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>MICR Code:</FONT>
	</td>
	<td class=mycborder >
	<html:text property="micrCode" styleClass="mytext" onkeypress="return numeralsOnly()" />
	<html:hidden property="bankCode"/>
	</td>
	</tr>
</table>

<tr>
	<td colspan="2" align="center">
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


