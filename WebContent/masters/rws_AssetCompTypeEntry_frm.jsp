<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function getAssetCompCode()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/AssetCompType.do?mode=data";
	document.forms[0].submit();
}
//-->
</SCRIPT>
<html:javascript formName="assetCompTypeForm" />

<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>

<html:form action="AssetCompType.do" >
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
	<jsp:param name="TableName" value="Asset Component Type Entry Form" />
	<jsp:param name="TWidth" value="400" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="440" >
<tr>
<td>
	<table  border=0  width="430"  align=center  style="margin-bottom:5;margin-top:5">
<tr>
	<td class="mycborder">
	<FONT class=myfontclr><bean:message key="app.typeOfAsset" /><font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="assetTypeCode" styleClass="mycombo" style="width:123px" onchange="javascript:getAssetCompCode()">
	<html:option value=""><font class=myfontclr1>SELECT...</html:option>
	<html:options collection="assetTypes" name="labelValueBean" property="value" labelProperty="label" />
	</html:select>
	</tr>
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr><bean:message key="app.assetCompTypeCode" /><font color="#FF6666">*</font></FONT></td>
	<td><html:text property="assetCompTypeCode" value="<%=(String)request.getAttribute(\"code\")%>" styleClass="mytext" readonly="true" /></td>
	</tr>
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr><bean:message key="app.assetCompTypeName" /><font color="#FF6666">*</font></FONT></td>
	<td><html:text property="assetCompTypeName" value="" styleClass="mytext" maxlength="20" /></td>
	</tr>
	
	</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateAssetCompTypeForm(assetCompTypeForm)" /> 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="400"/>
</jsp:include>

</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

