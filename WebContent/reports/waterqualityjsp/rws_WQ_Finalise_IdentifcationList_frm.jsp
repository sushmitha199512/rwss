<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width="100%">
<tr><td align=right>
<html:link page="/WaterFinalIden.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_WaterFinalIden_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_WaterFinalIden_xls.jsp" target="_new">Excel</html:link>
</td>
</tr>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="14"><B><font color="#FFFFFF">Water Source Identification and Finalisation List</B></td>
<td align="center">
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close"></td>
</tr>
<tr >
	<td class="clrborder" align="center" rowspan="2">Habitation</td>
	<td class="clrborder" align="center" rowspan="2">Source</td>
	<td class="clrborder" align="center" rowspan="2">Programme & SubProgramme</td>
	<td class="clrborder" align="center" rowspan="2">Work Id</td>
	<td class="clrborder" align="center" colspan="3">Recommondations</td>
	<td class="clrborder" align="center" colspan="3">References</td>
	<td class="clrborder" align="center" rowspan="2">Lab Chemist</td>
	<td class="clrborder" align="center" rowspan="2">Finalised</td>
	<td class="clrborder" align="center" rowspan="2">Identifcation&nbsp;Date & Finalise&nbsp;Date</td>
	<td class="clrborder" align="center" rowspan="2">Remarks</td>
	<td class="clrborder" align="center" rowspan="2"><bean:message key="app.op" /></td>
</tr>
<tr>
	<td class="clrborder" align="center">Casing</td>
	<td class="clrborder" align="center">Depth</td>
	<td class="clrborder" align="center">Yield</td>
	<td class="clrborder" align="center">Source</td>
	<td class="clrborder" align="center">Depth</td>
	<td class="clrborder" align="center">Yield</td>
</tr>
<logic:iterate id="watersamplereslist" name="waterSrcFinIden">
<tr align="left" >
<td  class="bwborder" ><bean:write name="watersamplereslist" property="habCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="sourceCode" /></td>
<td  class="bwborder" >
<bean:write name="watersamplereslist" property="prgmName" /><br>
<bean:write name="watersamplereslist" property="subprgmName" />
</td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="workCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="casing" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="depth" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="yield" /><br>
<td  class="bwborder" nowrap>
<bean:write name="watersamplereslist" property="source1" /><br>
<bean:write name="watersamplereslist" property="source2" /><br>
<bean:write name="watersamplereslist" property="source3" />
</td>
<td  class="bwborder" >
<bean:write name="watersamplereslist" property="depth1" /><br>
<bean:write name="watersamplereslist" property="depth2" /><br>
<bean:write name="watersamplereslist" property="depth3" />
</td>
<td  class="bwborder" >
<bean:write name="watersamplereslist" property="yield1" /><br>
<bean:write name="watersamplereslist" property="yield2" /><br>
<bean:write name="watersamplereslist" property="yield3" />
</td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="empcode" /><br>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="finalised" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="siteIdenData" /><br>
<bean:write name="watersamplereslist" property="finalDate" />
</td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="remarks" /><br>
<td  class="bwborder"  nowrap>
<a href="./WaterFinalIden.do?workCode=<bean:write name='watersamplereslist' property='workCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>
<a href="./WaterFinalIden.do?workCode=<bean:write name='watersamplereslist' property='workCode' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>

</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>