<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>




<html:form action="Supplier.do?mode=edit" onsubmit=" return winView() ">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Supplier Entry Form" />
	<jsp:param name="TWidth" value="560" />
</jsp:include>

<table  bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="460">

<tr>
<td>
	<table  border=0  width="596"  align=center  >
	<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.supplierCode" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="supplierCode"  styleClass="mytext" maxlength="3" readonly="true" />
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.supplierName" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="supplierName"  styleClass="mytext" maxlength="30" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.street" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="address"  styleClass="mytext" maxlength="20" />
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.area" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="area"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.location" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="location"  styleClass="mytext" maxlength="20" />
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.city" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="city"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.pin" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="pin"  styleClass="mytext" maxlength="6" />
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.phone" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="phone"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.fax" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="fax"  styleClass="mytext" maxlength="20" />
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.email" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="email"  styleClass="mytext" maxlength="50" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.supplierRegNo" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="supplierRegNo"  styleClass="mytext" maxlength="5" />
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



