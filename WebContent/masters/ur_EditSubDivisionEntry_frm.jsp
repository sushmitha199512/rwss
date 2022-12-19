<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="subdivisionOfficeForm" />
<%@ include file="/commons/rws_header2.jsp" %>





<html:form action="UrSubDivision.do?mode=edit" onsubmit="return validateSubdivisionOfficeForm(this)">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="SubDivision Office Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">

<tr>

		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.hoc" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hoc"  styleClass="mytext" maxlength="1" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.coc" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="coc"  styleClass="mytext" maxlength="2" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.doc" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="doc"  styleClass="mytext" maxlength="1" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.sdoc" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sdoc"  styleClass="mytext" maxlength="1" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.sdon" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sdon"  styleClass="mytext" maxlength="20" />
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
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


