<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=750>
<tr><td align=right><html:link page="/Supplier.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_Supplier_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Supplier_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="750"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Supplier Entry Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="750" border=1 style="border-collapse:collapse" >
<tr >
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.supplierCode" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.supplierName" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.address" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.phone" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.fax" /></FONT>	</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.email" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.supplierRegNo" /></FONT>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
</tr>

<logic:iterate id="supplierlist" name="suppliers">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="supplierCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="supplierName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="address" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="supplierlist" property="area" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="supplierlist" property="location" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="supplierlist" property="city" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="supplierlist" property="pin" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="phone" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="fax" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="email" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="supplierRegNo" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<a href="./Supplier.do?supplierCode=<bean:write name='supplierlist' property='supplierCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./Supplier.do?supplierCode=<bean:write name='supplierlist' property='supplierCode' />&mode=delete"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
