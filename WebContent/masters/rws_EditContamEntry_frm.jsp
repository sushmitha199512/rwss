<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="contamForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<%
//System.out.println(request.getParameter("model")+"*^^^^^^");
%>

<%-- <html:form action="Contam.do?mode=edit" onsubmit="return validateContamForm(this)"> --%>
<html:form action="Contam.do?mode=edit" onsubmit="return validateContamForm(this)">

<%
			String csrfToken = "";
					nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
					csrfToken = valUtil.getCSRFCode();
					session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Contamination Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.contamCode" /><font color="#FF6666">*</font></FONT></FONT>
	</td>
	<td class=mycborder >
	<html:text property="contamCode" styleClass="mytext" readonly="true"/>
	</td></tr>
	<tr >
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.contamName" /><font color="#FF6666">*</font></FONT></FONT>
	</td>
	<td class=mycborder >
	<html:text property="contamName" styleClass="mytext" />
	</td>
	</tr>
</table>


<tr>
	<td colspan="2" align="center">
	
	
	<html:submit title="Save the Fields" styleClass="btext" value="Save"      onclick="return validateContamForm(contamForm)" /> 
     

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


