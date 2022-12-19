<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=600>
<tr><td align=right><html:link page="/AssetSubCompParam.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_AssetSubCompParamType_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_AssetSubCompParamType_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table    width="600"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Asset SubComponent Parameter Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="600" border=1 style="border-collapse:collapse" >
	<tr >
	<td class="clrborder" align=center><bean:message key="app.assetType" /></td>
	<td class="clrborder" align=center>Asset Component Type</td>
	<td class="clrborder" align=center>Asset SubComponent Type</td>
	<td class="clrborder" align=center>Measurement Type</td>
	<td class="clrborder" align=center>Unit of Measurement</td>
	<td class=clrborder align=center><bean:message key="app.op" /></td>
	</tr>

<logic:iterate id="assetSubCompParamList" name="assetSubCompParams">
<tr align="left" >
<td  class=bwborder nowrap>
<bean:write name="assetSubCompParamList" property="assetTypeName" />
</td>
<td  class=bwborder >
<bean:write name="assetSubCompParamList" property="assetCompTypeName" />
</td>
<td  class=bwborder nowrap>
<bean:write name="assetSubCompParamList" property="assetSubCompTypeName" />
</td>
<td  class=bwborder nowrap>
<bean:write name="assetSubCompParamList" property="dimension" />
</td>
<td  class=bwborder nowrap>
<bean:write name="assetSubCompParamList" property="uom" />
</td>

<td  class=bwborder align=center nowrap>
<a href="./AssetSubCompParam.do?assetTypeCode=<bean:write name='assetSubCompParamList' property='assetTypeCode' />&assetCompTypeCode=<bean:write name='assetSubCompParamList' property='assetCompTypeCode' />&assetSubCompTypeCode=<bean:write name='assetSubCompParamList' property='assetSubCompTypeCode' />&dimension=<bean:write name='assetSubCompParamList' property='dimension' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./AssetSubCompParam.do?assetTypeCode=<bean:write name='assetSubCompParamList' property='assetTypeCode' />&assetCompTypeCode=<bean:write name='assetSubCompParamList' property='assetCompTypeCode' />&assetSubCompTypeCode=<bean:write name='assetSubCompParamList' property='assetSubCompTypeCode' />&dimension=<bean:write name='assetSubCompParamList' property='dimension' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>
 
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
