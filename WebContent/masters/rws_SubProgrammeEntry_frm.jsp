<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="subprogrammeForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/SubProgramme.do?mode=data";
	document.forms[0].submit();
}

//-->
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>


<html:form action="/SubProgramme.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Sub Programme Entry Form" />
	<jsp:param name="TWidth" value="320" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" >
<tr>
<td>
	<table  border=0  width="356"  align=center  style="margin-bottom:5;margin-top:5">
<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Programme<font color="#FF6666">*</font></FONT>
		</td>
		<td class=mycborder>
		<html:select property="prgmCode" styleClass="mycombo" style="width:150px" onchange="javascript:getData()">
		<html:option value="">SELECT..</html:option>
		<html:options collection="programmes" name="labelValueBean"  property="value" labelProperty="label" />
		</html:select>
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Sub Programme Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="subprgmCode" value="<%=(String)request.getAttribute(\"code\")%>" styleClass="mytext" maxlength="2" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Sub Programme Name<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="subprgmName" value="" styleClass="mytext" maxlength="30" />
		</td>
		</tr>
		
		</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateSubprogrammeForm(subprogrammeForm)" /> 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="320"/>
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>