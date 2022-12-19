<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>

<table width=300>
<tr><td align=right><html:link page="/Hoffice.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>

<html:link page="/rws_Hoffice_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Hoffice_xls.jsp" target="_new">Excel</html:link>

</tr>
</table>

<table    width="300"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Head Of Office List</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="300" border=1 style="border-collapse:collapse" >
<tr >
	<td align=center class="textborder"><FONT class=myfontclr><font color="#993366"><bean:message key="app.sno"/></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.office" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366"><bean:message key="app.designation" /></FONT>
	</td>
</tr>
<% int i=1;%>
<logic:iterate id="hofficelist" name="hoffices">
<tr align="center" >
<td align="center" class="bwborder"><%= i++%></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="hofficelist" property="office" /></FONT>
</td>
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><bean:write name="hofficelist" property="designation" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
