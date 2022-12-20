<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>

<table width=750>
<tr><td align=right><html:link page="/AssetSubCompType.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="../admin/rws_general_admn_loginsuccess.jsp">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_AssetSubCompType_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_AssetSubCompType_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table width="750" bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Asset Sub Component Type Form</font></B></td>
<td align=right><IMG SRC="/pred/images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="750" border=1 style="border-collapse:collapse" >
<tr >
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetType" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Asset Component Type</td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Asset Sub Component Type Code</td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Asset Sub Component Type Name</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
	</td>

	</tr>

<logic:iterate id="assetSubCompType" name="assetSubCompTypes">
<tr align="left" >
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="assetSubCompType" property="assetTypeName" /></FONT>
<html:hidden name="assetSubCompType" property="assetTypeCode"/>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="assetSubCompType" property="assetCompTypeName" /></FONT>
<html:hidden name="assetSubCompType" property="assetCompTypeCode"/>
</td>
<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="assetSubCompType" property="assetSubCompTypeCode" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="assetSubCompType" property="assetSubCompTypeName" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<a href="./AssetSubCompType.do?assetTypeCode=<bean:write name='assetSubCompType' property='assetTypeCode' />&assetCompTypeCode=<bean:write name='assetSubCompType' property='assetCompTypeCode' />&assetSubCompTypeCode=<bean:write name='assetSubCompType' property='assetSubCompTypeCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./AssetSubCompType.do?assetTypeCode=<bean:write name='assetSubCompType' property='assetTypeCode' />&assetCompTypeCode=<bean:write name='assetSubCompType' property='assetCompTypeCode' />&assetSubCompTypeCode=<bean:write name='assetSubCompType' property='assetSubCompTypeCode' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>
 
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
