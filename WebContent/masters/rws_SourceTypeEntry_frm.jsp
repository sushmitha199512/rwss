<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="sourceTypeForm" />
<%@ include file="/commons/rws_header2.jsp" %>
<script>
function autocompletion()
{
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
</script>
 <body onload="autocompletion()">
<html:form action="SourceType.do?" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Source Type Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1"  width="340" style="border-collapse:collapse;">
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.sourceTypeCode" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sourceTypeCode" value="<%=(String)request.getAttribute(\"scode\")%>" styleClass="mytext" readonly="true" maxlength="3" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.sourceTypeName" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sourceTypeName" value="" styleClass="mytext" maxlength="30" />
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
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save"  onclick=" return validateSourceTypeForm(sourceTypeForm)" /> 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
</body>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>