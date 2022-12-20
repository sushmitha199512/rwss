<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="circleOfficeForm" />
<%@ include file="/reports/rws_header2.jsp" %>
<html:form action="UrCircle.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Circle Office Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table  bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.hoc" />&nbsp;<font color="#ff6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hoc" value="2" styleClass="mytext"  readonly="true"/>
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.coc" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder ><html:text property="coc" value="<%=(String)request.getAttribute(\"code\")%>" styleClass="mytext" maxlength="2" readonly="true"/></td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.con" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="con" value="" styleClass="mytext" maxlength="20" />
		</td>
		</tr>
</table>

<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick= "return validateCircleOfficeForm(circleOfficeForm)" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View All the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
