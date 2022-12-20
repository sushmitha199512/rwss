<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width="100%">
<tr><td align=right>
<html:link page="/WaterSampleRes.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_WaterSampleTestRes_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_WaterSampleTestRes_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="9"><B><font color="#FFFFFF">Water Sample Test Result List</B></td>
<td align="center">
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close"></td>
</tr>
<tr >
	<td class="clrborder" align="center">S.No.</td>
	<td class="clrborder" align="center">Collected Date</td>
	<td class="clrborder" align="center">Tested Date</td>
	<td class="clrborder" align="center">Source</td>
	<td class="clrborder" align="center">Type of Test</td>
	<td class="clrborder" align="center">Lab</td>
	<td class="clrborder" align="center">Remarks / Recommendations</td>
	<td class="clrborder" align="center">Potable Source</td>
	<td class="clrborder" align="center">Update Source</td>
	<td class="clrborder" align="center"><bean:message key="app.op"/></td>
	</tr>
<%int index = 1; %>
<logic:iterate id="watersamplereslist" name="watersampleres">
<tr align="left" >
<td  class="bwborder" ><%=index++%></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="forwadedOn" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="preparedOn" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="sourceName" /></td>
<td  class="bwborder" nowrap><bean:write name="watersamplereslist" property="testName" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="labName" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="recommendations" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="condemnSource" /><br>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="updateSource" /></td>
<td  class="bwborder"  nowrap>
 <a href="./WaterSampleRes.do?testId=<bean:write name='watersamplereslist' property='testId' />&mode=get"><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
<a href="./WaterSampleRes.do?testId=<bean:write name='watersamplereslist' property='testId' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>

</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>