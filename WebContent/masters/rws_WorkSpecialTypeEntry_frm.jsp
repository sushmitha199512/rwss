<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<tr height="96%">
<td align="center" valign="middle">

<html:form action="AssetType.do?mode=edit" onsubmit=" return winView() ">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Asset Type Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.assetTypeCode" /></FONT>
	</td>
	<td class=mycborder >
	<html:text property="assetTypeCode" styleClass="mytext" />
	</td></tr>
	<tr >
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.assetTypeName" /></FONT>
	</td>
	<td class=mycborder >
	<html:text property="assetTypeName" styleClass="mytext" />
	</td>
	</tr>
</table>

<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Submit"  />
 
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


