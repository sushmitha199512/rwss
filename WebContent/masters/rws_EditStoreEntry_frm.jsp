<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>




<html:form action="Stores.do?mode=edit" onsubmit=" return winView() ">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Stores Entry Form" />
	<jsp:param name="TWidth" value="560" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="460">
<tr>
<td>
	<table  border=0  width="596"  align=center  >
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.district" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="district" styleClass="mytext" />
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.mandal" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="mandal" styleClass="mytext" />
	</td>
	</tr>
	<tr >
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.subdivision" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="subdivision" styleClass="mytext" />
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.storeCode" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text  property="storeCode" styleClass="mytext" readonly="true" />
     </td>
	</tr>
	<tr >
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.location" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="location" styleClass="mytext" />
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.storeInCharge" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="storeInCharge" styleClass="mytext" />
	</td>
	</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.empcode" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="empcode" styleClass="mytext" />
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.postheld" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="postheld"  styleClass="mytext" style="width:100px" />
		<a href="javascript: showCalendar(document.storeForm.postheld);"></font><IMG SRC="/pred/images/calendar.gif" width="20" border="0" height="17" align="absmiddle"></a></td>
	</td>
	</tr>
</table>

<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Save"  />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="560"/>
</jsp:include>

</html:form>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>


