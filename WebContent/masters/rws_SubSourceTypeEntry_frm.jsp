<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
 <html:javascript formName="subSourceTypeForm" />
<script language="JavaScript">
<!--
function autocompletion()
{
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}

function getsubSourceCode()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/SubSourceType.do?mode=data";
	document.forms[0].submit();
}
//-->
</script>
<%@ include file="/commons/rws_header2.jsp" %>
 <body onload="autocompletion()">
<html:form action="SubSourceType.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Sub Source Type Entry Form" />
	<jsp:param name="TWidth" value="334" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1"  width="370" style="border-collapse:collapse;">
<tr>
<td>
	<table  border=0  width="370"  align=center  style="margin-bottom:5;margin-top:5">
<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.sourceType" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="sourceTypeCode" styleClass="mycombo" style="width:123" onchange="javascript:getsubSourceCode()" >
		<html:option value=""><font class=myfontclr1>SELECT...</html:option>
		<html:options collection="sourceTypeCodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.subSourceTypeCode" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="subSourceTypeCode" value="<%=(String)request.getAttribute(\"scode\")%>" styleClass="mytext" maxlength="2" readonly="true"/>
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.subSourceTypeName" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="subSourceTypeName" value="" styleClass="mytext" maxlength="30" />
		</td>
		</tr>
		</table>
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateSubSourceTypeForm(subSourceTypeForm)" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="334"/>
</jsp:include>

</html:form>
</body>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>