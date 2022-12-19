<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="divisionOfficeForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/Division.do?mode=edit" onsubmit="return validateDivisionOfficeForm(this)">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Division Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.hoc" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hoc"  styleClass="mytext" maxlength="1" readonly="true" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.coc" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="coc"  styleClass="mytext" maxlength="2" readonly="true" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.doc" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="doc"  styleClass="mytext" maxlength="1" readonly="true" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.don" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="don"  styleClass="mytext" />
		</td>
		</tr>
<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Division Status</FONT>
		</td>
		<td  class=mycborder >
		<html:select property="divStatus" >
	      <html:option value="">Select</html:option>
      <html:option value="UI">UI</html:option>
 <html:option value="I">I</html:option>
</html:select>
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
	<html:submit title="Save the Fields" styleClass="btext" value="Save" onclick="return winView()" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


