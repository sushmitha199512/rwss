<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=750>
<tr><td align=right><html:link page="/Stores.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_Store_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Store_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="750"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Store Entry Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="750" border=1 style="border-collapse:collapse" >
<tr >
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.district" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.mandal" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.subdivision" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.storeCode" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.location" /></FONT>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.storeInCharge" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Employee</FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.postheld" /> </FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /> </FONT></td>
	</tr>

<logic:iterate id="storelist" name="stores">
<tr align="left" >
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="storelist" property="district" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="storelist" property="mandal" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="storelist" property="subdivision" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="storeCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="location" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="storeInCharge" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="storelist" property="empcode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="postheld" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<a href="./Stores.do?storeCode=<bean:write name='storelist' property='storeCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./Stores.do?storeCode=<bean:write name='storelist' property='storeCode' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

