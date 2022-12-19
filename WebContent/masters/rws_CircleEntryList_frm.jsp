<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=500>
<tr><td align=right><html:link page="/Circle.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_CircleOffice_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_CircleOffice_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Circle Office Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
		<td  class=mycborder align="center">
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.headOffice" /></FONT>
		</td>
		<td  class=mycborder align="center">
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.circleOfficeCode" /></FONT></td>
		<td  class=mycborder align="center">
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.circleOfficeName" /></FONT>
		</td>
		<td  class=mycborder align="center">
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
		</td>
	</tr>

<logic:iterate id="circlelist" name="circles">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="circlelist" property="hon" /></FONT>
<html:hidden name="circlelist" property="hoc" />
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="circlelist" property="coc" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="circlelist" property="con" /></FONT>
</td>
<td  class=mycborder1 align="center">
<a href="./Circle.do?hoc=<bean:write name='circlelist' property='hoc' />&coc=<bean:write name='circlelist' property='coc' />&mode=get">
<font color="#6600CC">Edit<!-- &nbsp;&nbsp;| --></font></a>&nbsp;&nbsp;

 
<!-- <a href="./Circle.do?hoc=<bean:write name='circlelist' property='hoc' />&coc=<bean:write name='circlelist' property='coc' />&mode=delete" onclick="return deleteRec()">
<font color="#990066">Delete</font></a>   -->
</td>
</tr>
</logic:iterate>
</table>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

