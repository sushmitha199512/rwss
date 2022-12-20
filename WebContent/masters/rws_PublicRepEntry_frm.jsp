<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="repForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="PublicRep.do">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Public Representatives Entry Form" />
	<jsp:param name="TWidth" value="350" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="390" >
<tr>
<td>
	<table  border=0  width="350"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
		<td  class="myfontclr" ><bean:message key="app.repCode" /><font color="#FF6666">*</font></td>
		<td  class="myfontclr" >
		<html:text property="publicRepCode" value="<%=(String)request.getAttribute(\"repcode\")%>" styleClass="mytext" maxlength="2" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class="myfontclr" ><bean:message key="app.repName" /><font color="#FF6666">*</font></td>
		<td  class="myfontclr" >
		<html:text property="publicRepName" value="" styleClass="mytext" maxlength="20" />
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
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateRepForm(repForm)" />
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	<html:submit property="mode" title="View the Fields" styleClass="btext" value="View" />
	</td>
	</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="350"/>
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


