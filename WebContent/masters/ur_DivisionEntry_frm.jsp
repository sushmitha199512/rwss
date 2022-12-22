<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="divisionOfficeForm" />
<SCRIPT LANGUAGE="JavaScript">

function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/UrDivision.do?mode=data"
	document.forms[0].submit();
}


</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="UrDivision.do"  >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Division Office Entry Form" />
	<jsp:param name="TWidth" value="350" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="390" >
<tr>
<td>
	<table  border=0  width="350"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.headOffice" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hoc" value="2" styleClass="mytext" readonly="true" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.circleOffice" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="coc" styleClass="mycombo" onchange="javascript:getData()">
		<html:option value="00"><font class=myfontclr1>SELECT...</html:option>
		<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.doc" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="doc" value="<%=(String)request.getAttribute(\"code\")%>" styleClass="mytext" maxlength="1" readonly="true"/>
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.don" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="don" value="" styleClass="mytext" maxlength="20" />
		</td>
		</tr>
<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Division Status</FONT>
		</td>
		<td  class=mycborder >
		<html:select property="divStatus" >
<html:option value="I" >I</html:option>	   
      <html:option value="UI">UI</html:option>

</html:select>
		</td>
		</tr>
		</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateDivisionOfficeForm(divisionOfficeForm)" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="350"/>
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>




