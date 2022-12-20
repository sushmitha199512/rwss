<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetSubCompParamForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/AssetSubCompParam.do?mode=data";
	document.forms[0].submit();
}
//-->
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="AssetSubCompParam.do">

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
		<FONT class=myfontclr><bean:message key="app.typeOfAsset" /><font color="#FF6666">*</font></FONT></td>
	<td>
		<html:select property="assetTypeCode" styleClass="mycombo" style="width:123px" onchange="javascript:getData()">
		<html:option value=""><font class=myfontclr1>SELECT...</html:option>
		<html:options collection="assetTypes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</tr>
	<tr>
	<td class="mycborder">
		<FONT class=myfontclr>Asset Component Type<font color="#FF6666">*</font></FONT>
	</td>
	<td>
		<html:select property="assetCompTypeCode" styleClass="mycombo" style="width:123px" onchange="javascript:getData()">
		<html:option value=""><font class=myfontclr1>SELECT...</html:option>
		<html:options collection="assetCompTypes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	</tr>
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Asset Sub Component Type<font color="#FF6666">*</font></FONT>
	</td>
	<td  class=mycborder >
		<html:select property="assetSubCompTypeCode" styleClass="mycombo" style="width:123px" onchange="javascript:getData()">
		<html:option value=""><font class=myfontclr1>SELECT...</html:option>
		<html:options collection="assetSubCompTypes" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	</tr>
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Measurement Type<font color="#FF6666">*</font></FONT>
	</td>
	<td  class=mycborder >
		<html:text property="measurementType" value="" styleClass="mytext" maxlength="30" />
	</td>
	</tr>
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Unit Of Measurement<font color="#FF6666">*</font></FONT>
	</td>
	<td  class=mycborder >
		<html:text property="unitOfMeasure" value="" styleClass="mytext" maxlength="30" />
	</td>
	</tr>
	</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateAssetSubCompParamForm(assetSubCompParamForm)" />
 
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

