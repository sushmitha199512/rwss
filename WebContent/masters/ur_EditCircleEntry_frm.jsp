<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="circleOfficeForm" />
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="UrCircle.do?mode=edit" onsubmit="return validateCircleOfficeForm(this)">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Circle Office Entry Form" />
	<jsp:param name="TWidth" value="400" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="440" >
<tr>
<td>
	<table  border=0  width="400"  align=center  style="margin-bottom:5;margin-top:5">

		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.hoc" />&nbsp;</FONT></td>
		<td  class=mycborder >
		<html:text property="hoc"  styleClass="mytext" maxlength="1" readonly="true" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.coc" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="coc" styleClass="mytext" maxlength="2" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.con" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="con"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Save" onclick="return winView()" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="400"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

