<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<table width=550>
<tr><td align=right><html:link page="/AssetCompType.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="../admin/rws_general_admn_loginsuccess.jsp">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_AssetCompType_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_AssetCompType_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table    width="550" bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Asset Component Type Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="550" border=1 style="border-collapse:collapse" >
<tr >
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetType" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetCompTypeCode" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetCompTypeName" /></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
	</td>

	</tr>

<logic:iterate id="assetcomponenttypelist" name="assetCompTypes">
<tr align="left" >
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="assetcomponenttypelist" property="assetTypeName" /></FONT>
<html:hidden name="assetcomponenttypelist" property="assetTypeCode"/>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetcomponenttypelist" property="assetCompTypeCode" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="assetcomponenttypelist" property="assetCompTypeName" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<a href="./AssetCompType.do?assetTypeCode=<bean:write name='assetcomponenttypelist' property='assetTypeCode' />&assetCompTypeCode=<bean:write name='assetcomponenttypelist' property='assetCompTypeCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./AssetCompType.do?assetTypeCode=<bean:write name='assetcomponenttypelist' property='assetTypeCode' />&assetCompTypeCode=<bean:write name='assetcomponenttypelist' property='assetCompTypeCode' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
