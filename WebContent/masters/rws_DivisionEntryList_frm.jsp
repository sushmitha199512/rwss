<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>

<table width=500>
<tr><td align=right><html:link page="/Division.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_DivisionOffice_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_DivisionOffice_xls.jsp" target="_new">Excel</html:link>
</td>
</tr>
</table>
<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Division Office Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
		<td  class=mycborder  >
		<FONT class=myfontclr><font color="#993366">SNo.</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Circle</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.code" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.division" /></FONT></td>		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></td>		
	</tr>
<% int sno=1; %>
<logic:iterate id="divisionlist" name="divisions">
<tr align="left" >
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><%=sno%></FONT>
<%sno=sno+1;%>
<html:hidden name="divisionlist" property="hoc" />
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="divisionlist" property="con" /></FONT>
<html:hidden name="divisionlist" property="coc" />
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="divisionlist" property="doc" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="divisionlist" property="don" /></FONT>
</td>

<td  class=mycborder1 align=center>
<a href="./Division.do?doc=<bean:write name='divisionlist' property='doc' />&coc=<bean:write name='divisionlist' property='coc' />&hoc=<bean:write name='divisionlist' property='hoc' />&mode=get"><font color="#6600CC">Edit<!-- &nbsp;&nbsp;| --></font></a>&nbsp;&nbsp;
<!--  <a href="./Division.do?doc=<bean:write name='divisionlist' property='doc' />&coc=<bean:write name='divisionlist' property='coc' />&hoc=<bean:write name='divisionlist' property='hoc' />&mode=delete" onclick="return deleteRec()" ><font color="#990066">Delete</font></a> --> 
</td>
</tr>
</logic:iterate>
</table>
 


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>