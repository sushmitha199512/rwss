<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width="100%">
<tr><td align=right>
<html:link page="/DrillStatus.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_WQ_DrillingStatus_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_WQ_DrillingStatus_xls.jsp" target="_new">Excel</html:link>
</td></tr>
</table>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="4"><B><font color="#FFFFFF">Source Finalisation Drilling  List</B></td>
<td align="center">
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close"></td>
</tr>
<tr >
	<td class="clrborder" align="center">Work Code</td>
	<td class="clrborder" align="center">Drilling Status</td>
	<td class="clrborder" align="center">Drilling Date</td>
	<td class="clrborder" align="center">Yield</td>
	<td class="clrborder" align="center"><bean:message key="app.op" /></td>
</tr>

<logic:iterate id="wqDrillList" name="wqDrillStatus">
<tr align="left" >
<td  class="bwborder" align="center"><bean:write name="wqDrillList" property="workCode" /></td>
<td  class="bwborder" align="center"><bean:write name="wqDrillList" property="drillStatus" /></td>
<td  class="bwborder" align="center"><bean:write name="wqDrillList" property="drillDate" /></td>
<td  class="bwborder" align="center"><bean:write name="wqDrillList" property="yield" /></td>
<td  class="bwborder"  nowrap align="center">
<a href="./DrillStatus.do?workCode=<bean:write name='wqDrillList' property='workCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
<a href="./DrillStatus.do?workCode=<bean:write name='wqDrillList' property='workCode' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>