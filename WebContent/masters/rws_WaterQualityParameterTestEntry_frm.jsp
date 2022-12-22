<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="wqPTestForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/WaterPTest.do?mode=data";
	document.forms[0].submit();
}
//-->
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="WaterPTest.do" >

	<%
			String csrfToken = "";
					nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
					csrfToken = valUtil.getCSRFCode();
					session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />


<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Quality Parameter Test Entry Form" />
	<jsp:param name="TWidth" value="375" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"   width="340" >
<tr>
<td>
	<table  border=0  width="410"  align=center  style="margin-bottom:5;margin-top:5">
<tr>
<td  class=mycborder >
		<FONT class=myfontclr>Test Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="testCode" style="width:150px" onchange="javascript:getData()">
		<html:option value="" >SELECT...</html:option>
		<html:options collection="watertests" name="rwsMaster"  property="testCode" labelProperty="testCodeDisplay" />
		</html:select>
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Testing Parameter Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="testPCode" value="<%=(String)request.getAttribute(\"code\")%>" style="width:50px" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Testing Parameter Name<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="testPName" value=""  style="width:150px" />
		
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Minimum permissible value</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="minPerVal" value="" styleClass="mytext" maxlength="5" style="width:150px" onkeypress="return numeralsOnly(event)" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Maximum permissible value</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="maxPerVal" value="" styleClass="mytext" maxlength="5" style="width:150px" onkeypress="return numeralsOnly(event)" />
		</td>
		</tr>
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Undesirable Effect Outside the Desirable Limit</FONT>
		</td>
		<td  class=mycborder >
		<html:textarea property="undesirableEffect"  style="width:150px;height:80px"  />
		
		</td>
		</tr>
		
	</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateWqPTestForm(wqPTestForm)" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="375"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>