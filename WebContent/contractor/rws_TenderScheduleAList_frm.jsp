<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width="90%">
<tr><td align=right><html:link page="/TenderSchedule.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_TenderScheduleA_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_TenderScheduleA_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table   width="90%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Tender Schedule A Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
<tr >
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Type of Asset</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366"><bean:message key="app.workId" /></FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Work Component</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Work Sub Component </FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Quantity </FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Unit Rate </FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Amount</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
	</td>
	</tr>

<logic:iterate id="tenderScheduleAlist" name="tenderScheduleA">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="assetTypeCode" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="workId" /></FONT>
</td>

<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="assetComponentCode" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="assetSubCompTypeName" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="quantity" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="unitRate" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="amount" /></FONT>
</td>


<td  class=mycborder1 align=center>
<a href="switch.do?prefix=/contractor&page=/TenderSchedule.do?workId=<bean:write name='tenderScheduleAlist' property='workId' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="switch.do?prefix=/contractor&page=/TenderSchedule.do?workId=<bean:write name='tenderScheduleAlist' property='workId' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
