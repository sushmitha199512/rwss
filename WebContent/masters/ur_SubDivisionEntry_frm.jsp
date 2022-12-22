<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="subdivisionOfficeForm" />
<SCRIPT LANGUAGE="JavaScript">

function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/UrSubDivision.do?mode=data";
	document.forms[0].submit();
}



</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="UrSubDivision.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Sub Division Office Entry Form" />
	<jsp:param name="TWidth" value="400" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="440" >
<tr>
<td>
	<table  border=0  width="400"  align=center  style="margin-bottom:5;margin-top:5">

<tr>

		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.headOffice"/><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hoc" value="2" styleClass="mytext" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.circleOffice"/><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="coc" style="width:170px" styleClass="mycombo" onchange="javascript:getData()" >
		<html:option value="00"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.divisionOffice"/><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="doc" style="width:170px" styleClass="mycombo" onchange="javascript:getData()" >
		<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="divcodes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.subdivisionOfficeCode"/><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sdoc" value="<%=(String)request.getAttribute(\"code\")%>" styleClass="mytext" maxlength="1" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.subdivisionOfficeName"/><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sdon" value="" styleClass="mytext" maxlength="20" />
		</td>
		</tr>


	</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateSubdivisionOfficeForm(subdivisionOfficeForm)"/>
 
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