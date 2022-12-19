<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=700>
<tr><td align=right><html:link page="/SubProgramme.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_SubProgramme_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_SubProgramme_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table   width="700"   bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Sub Programme List</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="700" border=1 style="border-collapse:collapse" >
<tr >
		<td  class=mycborder align="center">
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.programme" /></FONT></FONT></td>
		<td  class=mycborder align="center">
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.subprgmCode" /></FONT></FONT></td>
		<td  class=mycborder align="center">
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.subprgmName" /></FONT></FONT></td>
		<td  class=mycborder align="center"><FONT class=myfontclr><font color="#993366">Action</font></td>
</tr>

<logic:iterate id="subprgmlist" name="subprogrammes">
<tr align="left" >
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><bean:write name="subprgmlist" property="prgmName" /></FONT>
<html:hidden name="subprgmlist" property="prgmCode" />
</td>
<td  class=mycborder1 align="center">
<FONT class=myfontclr1><bean:write name="subprgmlist" property="subprgmCode" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="subprgmlist" property="subprgmName" /></FONT>
</td>

<td class=mycborder1 align=center nowrap>
<a href="./SubProgramme.do?subprgmCode=<bean:write name='subprgmlist' property='subprgmCode' />&prgmCode=<bean:write name='subprgmlist' property='prgmCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>


</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


<!--   <a href="./SubProgramme.do?subprgmCode=<bean:write name='subprgmlist' property='subprgmCode' />&prgmCode=<bean:write name='subprgmlist' property='prgmCode' />&mode=delete"><font color="#990066">Delete</font></a> 
 -->
