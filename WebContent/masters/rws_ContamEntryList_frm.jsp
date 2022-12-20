<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=500>
<tr><td align=right><html:link page="/Contam.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_Contam_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Contam_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Contamination List Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.contamCode" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366"><bean:message key="app.contamName" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
	</td>
	</tr>
		<%
			String csrfToken = "";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken", csrfToken);
		%>
<logic:iterate id="contamlist" name="contams">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="contamlist" property="contamCode" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="contamlist" property="contamName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<a href="./Contam.do?contamCode=<bean:write name='contamlist' property='contamCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./Contam.do?contamCode=<bean:write name='contamlist' property='contamCode' />&mode=getdelete&model=del" ><font color="#990066">Delete</font></a>

<%-- <a href="./Contam.do?contamCode=<bean:write name='contamlist' property='contamCode' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
 --%>
</td>
</tr>
</logic:iterate>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
