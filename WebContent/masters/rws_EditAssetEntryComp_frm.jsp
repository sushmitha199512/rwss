<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/Asset.do?mode=edit" onsubmit="return validateAssetForm(this)">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Asset Entry Form" />
	<jsp:param name="TWidth" value="560" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="540" >
<tr>
<td>
<table  border=0  width="596"  align=center  >
	<tr>
    <TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.assetCode" /><font color="#FF6666">*</font></FONT>
	</TD>
    <TD><html:text property="assetCode"  styleClass="mytext" readonly="true" /></TD>
    <TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.assetTypeCode" /><font color="#FF6666">*</font></FONT>
	</TD>
    <TD>
	<html:select property="assetTypeCode" styleClass="mycombo" style="width:123px" >
	<html:option value=""><font class=myfontclr1>SELECT...</html:option>
	<html:options collection="assetTypes" name="rwsMaster" property="assetTypeCode" labelProperty="assetTypeNoName" />
	</html:select>
	</TD>
	</TR>
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.habitation" /><font color="#FF6666">*</font></FONT>
	</TD>
    <TD>
	<html:text property="habCode" styleClass="mytext" style="width=123px" />
	
	
	</TD>
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.dateofCreation" /><font color="#FF6666">*</font></FONT>
	</TD>
    <TD><html:text property="dateofCreation"  styleClass="mytext" style="width:100px" />
	<a href="javascript: showCalendar(document.assetForm.dateofCreation);"></font><IMG SRC="/pred/images/calendar.gif" width="20" border="0" height="17" align="absmiddle"></a></TD>

	</TR>
	<TR>
    <TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.yield" /><font color="#FF6666">*</font></FONT></TD>
    <TD><html:text property="yield" styleClass="mytext"  /></TD>
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.pumpingHours" /><font color="#FF6666">*</font></FONT>
	</TD>
    <TD><html:text property="pumpingHours" styleClass="mytext"  /></TD>
	</TR>
	<TR >
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.assetStatus" /><font color="#FF6666">*</font></FONT>
	</TD>
    <TD>
	<html:select property="assetStatus" styleClass="mycombo" style="width=123px">
	<html:option value=""><font class=myfontclr1>SELECT...</html:option>
	<html:option value="W">Working</html:option>
	<html:option value="N">Not Working</html:option>
	<html:option value="D">Dried</html:option>
	</html:select>
	</TD>
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.assetCost" /><font color="#FF6666">*</font></FONT></TD>
    <TD><html:text property="assetCost" styleClass="mytext"  /></TD>
	</TR>
	<TR >
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.startYear" /><font color="#FF6666">*</font></FONT></TD>
    <TD><html:text property="startYear" styleClass="mytext" /></TD>
    <TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.endYear" /><font color="#FF6666">*</font></FONT></TD>
    <TD>
	<html:text property="endYear" styleClass="mytext"  />
	</TD></TR>
	</table>
<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Submit" onclick="return winView()" />
	<html:button property="page" title="Save the Fields" styleClass="btext" value="Back" onclick="javascript:location.href='/pred/Asset.do?mode=view'"/>
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="560"/>
</jsp:include>

</html:form>
<table    width="700"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Asset Component Form</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="700" border=1 style="border-collapse:collapse" >
<tr >
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Asset</td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetTypeCode" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetCompCode" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.uom" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.dimension" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.valueOfWork" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.remarks" /></td>
	
	</tr>

<logic:iterate id="assetcomplist" name="assetComps">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetcomplist" property="assetName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetcomplist" property="assetTypeName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetcomplist" property="assetCompCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetcomplist" property="uom" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetcomplist" property="dimension" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetcomplist" property="valueOfWork" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetcomplist" property="remarks" /></FONT>
</td>


</tr>
</logic:iterate>
</table>
<br>
<table    width="700"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Habatitaions in the Asset</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="700" border=1 style="border-collapse:collapse" >
<tr >
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.panchCode" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.panchName" /></td>
</tr>

<logic:iterate id="assethablist" name="assethabs">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assethablist" property="habCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assethablist" property="habName" /></FONT>
</td>
</tr>
</logic:iterate>
</table>

</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>
