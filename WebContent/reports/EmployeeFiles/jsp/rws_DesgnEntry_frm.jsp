<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="desgnForm" />
<%@ include file="/commons/rws_header2.jsp" %>
 <html:form action="Desgn.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Designation Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.desgnCode" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="desgnCode" value="<%=(String)request.getAttribute(\"code\")%>" styleClass="mytext" maxlength="2" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.desgnAcr" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="desgnAcr" value="" styleClass="mytext" maxlength="10" onkeypress="return alpha(event);" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.desgnName" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="desgnName" value="" styleClass="mytext" maxlength="30" onkeypress="return alpha(event);" />
		</td>
		</tr>
		<tr>
		
		<td class=mycborder>
		<FONT class=myfontclr><bean:message key="app.desgnType" /><font color="#FF6666">*</FONT></FONT></td>
		<td class=mycborder><html:select property="desgnType" value="" style="width:130px" styleClass="mycombo">
			<html:option value="">Select..</html:option>
			<html:option value="T">Temporary</html:option>
			<html:option value="P">Permanent</html:option>
		</html:select>
		</td>
	</tr>
		
		</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateDesgnForm(desgnForm)" />
      <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

