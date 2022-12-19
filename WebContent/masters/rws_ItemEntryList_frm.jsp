<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=500>
<tr><td align=right><html:link page="/Item.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_Item_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Item_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Item Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.itemCode" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Item Name</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.district" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.itemYear" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.units" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.rate" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></td>
		</tr>

<logic:iterate id="itemlist" name="items">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="itemCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="itemName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="dname" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="finyear" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="units" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="rate" /></FONT>
</td>

<td  class=mycborder1 >
<a href="./Item.do?itemCode=<bean:write name='itemlist' property='itemCode' />&mode=get"><font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./Item.do?itemCode=<bean:write name='itemlist' property='itemCode' />&mode=delete"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>