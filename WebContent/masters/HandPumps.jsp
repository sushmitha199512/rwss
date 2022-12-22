	<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetCompForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function viewDet()
{
	location.href="AssetComp.do?mode=view";
}
function getAssetTypeCode()
{
	var assetTypeCode=assetCompForm.assetTypeCode.value;
	document.forms[0].action="/AssetComp.do?mode=data&assetTypeCode="+assetTypeCode;
	document.forms[0].submit();
}
function getAssetCode()
{
	var assetCode=assetCompForm.assetCode.value;
	document.forms[0].action="/AssetComp.do?mode=data&assetCode="+assetCode;
	document.forms[0].submit();
}


//-->
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>

<tr height="96%">
<td align="center" valign="middle">

<html:form action="/AssetComp.do?mode=insert" onsubmit="return validateAssetCompForm(this)">

<jsp:include page="TableHeader.jsp">
	<jsp:param name="TableName" value="Asset Component Entry Form" />
	<jsp:param name="TWidth" value="730" />
</jsp:include>

<table  bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="770" >
<tr>
<td>
<table  border=0  width="760"  align=center  >
	<tr>
	<td class="mycborder" nowrap>
	<FONT class=myfontclr><bean:message key="app.assetTypeCode" /><font color="#FF6666">*</font></FONT></td>
	<td>
	<html:text property="assetTypeCode" styleClass="mytext" property="assetTypeCode" value="<%=request.getParameter(\"assetT\")%>" style="width:90px" />
	</td>
	<td class="mycborder" nowrap>
	<FONT class=myfontclr>Asset Component Type<font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="assetCompTypeCode" styleClass="mycombo" style="width:123px" >
	<html:option value=""><font class=myfontclr1>Select...</html:option>
	<html:options collection="assetCompTypes" name="rwsMaster" property="assetCompTypeCode" labelProperty="distNoName" />
	</html:select>
	</td>
	<td class="mycborder" nowrap>
	<FONT class=myfontclr><bean:message key="app.assetCode" /><font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="assetCode" styleClass="mycombo" style="width:123px" onchange="getAssetCode()">
	<html:option value=""><font class=myfontclr1>Select...</html:option>
	<html:options collection="assets" name="rwsMaster" property="assetCode" labelProperty="assetTypeNoName" />
	</html:select>
	</td>
	</tr>
	<tr>
	<td class="mycborder" nowrap>
	<FONT class=myfontclr><bean:message key="app.assetCompCode" /><font color="#FF6666">*</font></FONT></td>
	<td><html:text property="assetCompCode" value="<%=(String)session.getAttribute(\"code\")%>" styleClass="mytext" readonly="true" style="width:60px" /></td>
	<td class="mycborder">
	<FONT class=myfontclr><bean:message key="app.habCode" /><font color="#FF6666">*</font></FONT></td>
	<td colspan=2> 
	<html:select property="uom" styleClass="mycombo" style="width:200px" >
	<html:option value=""><font class=myfontclr1>Select...</html:option>
	<html:options collection="habs" name="rwsMaster" property="habCode" labelProperty="distNoName" />
	</html:select>
	</td>
	</tr>
	</table>
	<hr size=1 style="color:#8A9FCD">
	 <table  border=0  width="760"  align=center  id="hp">
	<tr>
	<td class="mycborder" >
	<FONT class=myfontclr>Location<font color="#FF6666">*</font></FONT></td>
	<td><html:text property="location" value="" styleClass="mytext" /></td>
	<td class="mycborder" >
	<FONT class=myfontclr>Year Of Drilling<font color="#FF6666">*</font></FONT></td>
	<td><html:text property="uom" value="" styleClass="mytext" /></td>
	<td class="mycborder">
	<FONT class=myfontclr>Diameter<font color="#FF6666">*</font></FONT></td>
	<td><html:text property="dimension" value="" styleClass="mytext" /></td>
	</tr>
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr>Depth<font color="#FF6666">*</font></FONT></td>
	<td><html:text property="valueOfWork" value="" styleClass="mytext" /></td>
	<td class="mycborder">
	<FONT class=myfontclr>Casing Type</FONT></td>
	<td><html:select property="valueOfWork" styleClass="mycombo" style="width:123px" >
	<html:option value=""><font class=myfontclr1>Select...</html:option>
	<html:option value="PVC">PVC</html:option>
	<html:option value="PVC">MS</html:option>
	</html:select></td>
	<td class="mycborder" nowrap>
	<FONT class=myfontclr>No Of GI Pipes<font color="#FF6666">*</font></FONT></td>
	<td><html:text property="dimension" value="" styleClass="mytext" /></td>
	</tr>
	<tr>
	<td class="mycborder" nowrap>
	<FONT class=myfontclr>Static Water Level<font color="#FF6666">*</font></FONT></td>
	<td><html:text property="valueOfWork" value="" styleClass="mytext" /></td>
	<td class="mycborder" nowrap>
	<FONT class=myfontclr>Summer Water Level</FONT></td>
	<td><html:text property="valueOfWork" value="" styleClass="mytext" /></td>
	<td class="mycborder">
	<FONT class=myfontclr>Yield<font color="#FF6666">*</font></FONT></td>
	<td><html:text property="dimension" value="" styleClass="mytext" /></td>
	</tr>
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr>Platform<font color="#FF6666">*</font></FONT></td>
	<td><html:select property="valueOfWork" styleClass="mycombo" style="width:123px" >
	<html:option value=""><font class=myfontclr1>Select...</html:option>
	<html:option value="existing">Existing</html:option>
	<html:option value="not">Not</html:option>
	</html:select></td>
	<td class="mycborder">
	<FONT class=myfontclr>Status</FONT></td>
	<td><html:select property="valueOfWork" styleClass="mycombo" style="width:123px" >
	<html:option value=""><font class=myfontclr1>Select...</html:option>
	<html:option value="working">Working</html:option>
	<html:option value="seasonal">Seasonal Dry</html:option>
	<html:option value="condemned">Condemned</html:option>
	</html:select></td>
	</tr>
	</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Submit" onclick="return winView()" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:button property="page" title="Delete the Fields" styleClass="btext" value="View"  onclick="viewDet()" />
	 
	</td>
</tr>
</table>

 <jsp:include page="TableFotter.jsp">
	<jsp:param name="TWidth" value="730"/>
</jsp:include>

</html:form>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>



	