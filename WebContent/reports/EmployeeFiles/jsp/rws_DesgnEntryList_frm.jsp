<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=550>
<tr><td align=right><html:link page="/Desgn.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_Designation_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Designation_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table width="550" bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Desgination Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="550" border=1 style="border-collapse:collapse" >
<tr>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">SNo</FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnCode" />&nbsp;</FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnAcr" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
	</td>
	</tr>
<% int count = 1; %>
<logic:iterate id="desgnlist" name="desgns">
<tr>
<td class=mycborder1 align=center>
<FONT class=myfontclr1><%=count++ %></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="desgnlist" property="desgnCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="desgnlist" property="desgnAcr" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="desgnlist" property="desgnName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<a href="./Desgn.do?desgnCode=<bean:write name='desgnlist' property='desgnCode' />&mode=get">
<font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./Desgn.do?desgnCode=<bean:write name='desgnlist' property='desgnCode' />&mode=delete" onclick="return deleteRec()">
<font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>