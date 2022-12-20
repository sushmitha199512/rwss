<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=500>
<tr><td align=right><html:link page="/WaterTest.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_WQTestMaster_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_WQTestMaster_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Water Quality Test Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.testCode" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366"><bean:message key="app.testName" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366"><bean:message key="app.testPeriod" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
	</td>
	</tr>

<logic:iterate id="watertestlist" name="watertests">
<tr align="left" >
<td  class=mycborder1  >
<FONT class=myfontclr1><bean:write name="watertestlist" property="testCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="watertestlist" property="testName" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="watertestlist" property="testPeriod" /></FONT>
</td>
<td  class=mycborder1 align=center>
<a href="./WaterTest.do?testCode=<bean:write name='watertestlist' property='testCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
<a href="./WaterTest.do?testCode=<bean:write name='watertestlist' property='testCode' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>

</td>
</tr>
</logic:iterate>
</table>
 
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>