<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=750>
<tr><td align=right>
<html:link page="/Section.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_SectionOffice_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_SectionOffice_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="750"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Section Office Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="750" border=1 style="border-collapse:collapse" >
<tr >

		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Head Office</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Circle Office</FONT>	</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Division Office</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Sub Division Office</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.code" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.name" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></td>


</tr>

<logic:iterate id="sectionlist" name="sections">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sectionlist" property="hon" /></FONT>
<html:hidden name="sectionlist" property="hoc" />
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="sectionlist" property="con" /></FONT>
<html:hidden name="sectionlist" property="coc" />
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="sectionlist" property="don" /></FONT>
<html:hidden name="sectionlist" property="doc" />
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="sectionlist" property="sdon" /></FONT>
<html:hidden name="sectionlist" property="sdoc" />
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sectionlist" property="soc" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="sectionlist" property="son" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<a href="./Section.do?soc=<bean:write name='sectionlist' property='soc'/>&sdoc=<bean:write name='sectionlist' property='sdoc' />&doc=<bean:write name='sectionlist' property='doc' />&coc=<bean:write name='sectionlist' property='coc' />&mode=get"><font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./Section.do?soc=<bean:write name='sectionlist' property='soc'/>&sdoc=<bean:write name='sectionlist' property='sdoc'/>&doc=<bean:write name='sectionlist' property='doc' />&coc=<bean:write name='sectionlist' property='coc' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

