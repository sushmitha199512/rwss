<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetSubCompParamForm" />

<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="AssetSubCompParam.do?mode=edit" onsubmit="return validateAssetSubCompTypeForm(this)">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Asset Sub Component Parameter Entry Form" />
	<jsp:param name="TWidth" value="400" />
</jsp:include>


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="440" >
<tr>
<td>
	<table  border=0  width="430"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
		<td class="mycborder">
		<FONT class=myfontclr><bean:message key="app.assetTypeCode" /><font color="#FF6666">*</font></FONT></td>
		<td>
		<html:text property="assetTypeCode" styleClass="mytext" style="width:123px" readonly="true"/>
	</tr>
	<tr>
		<td class="mycborder">
		<FONT class=myfontclr>Asset Component Type<font color="#FF6666">*</font></FONT>
		</td>
		<td>
		<html:text property="assetCompTypeCode" styleClass="mytext" style="width:123px" readonly="true"/>
		</td>
	</tr>
	<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Asset SubComponent Type Code<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="assetSubCompTypeCode" styleClass="mytext" readonly="true" />
		</td>
	</tr>
    <tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Measurement Type<font color="#FF6666">*</font></FONT>
	</td>
	<td  class=mycborder >
		<html:text property="measurementType"  styleClass="mytext" maxlength="30" />
		</td>
	</tr>
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Unit Of Measurement<font color="#FF6666">*</font></FONT>
	</td>
	<td  class=mycborder >
		<html:text property="unitOfMeasure"  styleClass="mytext" maxlength="30" />
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
	<jsp:param name="TWidth" value="400"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
