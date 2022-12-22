<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=400>
<tr><td align=right><html:link page="/SourceType.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_SourceType_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_SourceType_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="400"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Source Type Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="400" border=1 style="border-collapse:collapse" >
<tr >
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sourceTypeCode" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sourceTypeName" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></td>

</tr>

<logic:iterate id="sourcetypelist" name="sourceTypes">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcetypelist" property="sourceTypeCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="sourcetypelist" property="sourceTypeName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<a href="./SourceType.do?sourceTypeCode=<bean:write name='sourcetypelist' property='sourceTypeCode' />&mode=get"><font color="#6600CC">Edit&nbsp;</font></a>
</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>