<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="storeForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Stores.do?mode=data";
	document.forms[0].submit();
}
//-->
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="Stores.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Stores Entry Form" />
	<jsp:param name="TWidth" value="560" />
</jsp:include>

<table  bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="460">
<tr>
<td>
	<table  border=0  width="596"  align=center  >
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.district" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:select property="district" style="width:123px" styleClass="mycombo" onchange="javascript:getData()">
	<html:option value=""><font class=myfontclr1>Select...</html:option>
	<html:options collection="dists" name="rwsMaster" property="dcode" labelProperty="distNoName" />
	</html:select>
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.mandal" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:select property="mandal" style="width:123px" styleClass="mycombo" >
	<html:option value=""><font class="myfontclr1">Select...</html:option>
	<html:options collection="mandals" name="rwsMaster" property="mandalCode" labelProperty="distNoName" />
	</html:select>
	</td>
	</tr>
	<tr >
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.subdivision" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:select property="subdivision" style="width:123px" styleClass="mycombo" onchange="javascript:getData()">
	<html:option value=""><font class="myfontclr1">Select...</html:option>
	<html:options collection="subdivs" name="rwsMaster" property="sdoc" labelProperty="distNoName" />
	</html:select>
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.storeCode" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text value="<%=(String)request.getAttribute(\"code\")%>" property="storeCode" styleClass="mytext" readonly="true" />
	</td>
	</tr>
	<tr >
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.location" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="location" value="" styleClass="mytext" />
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.storeInCharge" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="storeInCharge" value="" styleClass="mytext" />
	</td>
	</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.empcode" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:select property="empcode" style="width:123px" styleClass="mycombo" >
	<html:option value=""><font class="myfontclr1">Select...</html:option>
	<html:options collection="empcodes" name="rwsMaster" property="empcode" labelProperty="distNoName" />

	</html:select>
	</td>
	<td  class=mycborder>
		
	<FONT class=myfontclr><bean:message key="app.postheld" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="postheld" value="" styleClass="mytext" style="width:100px" />
		<a href="javascript: showCalendar(document.storeForm.postheld);"></font><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
	</td>
	</tr>
</table>

<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateStoreForm(storeForm)"/>
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="560"/>
</jsp:include>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>