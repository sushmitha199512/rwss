<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=700>
<tr><td align=right><html:link page="/switch.do?prefix=/masters&page=/PaoAction.do&mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_Pao_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Pao_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table width="700"   bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Pay and Account Office List</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="700" border=1 style="border-collapse:collapse" >
<tr >
	<td class="mycborder" align=center valign="top">
	<FONT class=myfontclr><font color="#993366">S. No.</FONT></td>
	<td class="mycborder" align=center valign="top">
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.distcode" /></FONT></td>
	<td class="mycborder" align=center valign="top">
	<FONT class=myfontclr><font color="#993366">District</FONT></td>
	<td class="mycborder" align=center valign="top">
	<FONT class=myfontclr><font color="#993366">PAO/APAO</FONT></td>
	<TD class="mycborder" align=center valign="top">
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.paocode" /></FONT></td>
	<TD class="mycborder" align=center valign="top">
	<FONT class=myfontclr><font color="#993366">PAO Name</FONT></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.address" /></FONT></td>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.phone" /></FONT></td>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.email" /></FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.fax" /></FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></TD>
	</tr>
<%int i = 1; %>
<logic:iterate id="paoofficelist" name="paos">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=i++ %></FONT>
</td><td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="distcode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="dname" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="paoapao" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="paocode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="paoName" /></FONT>
</td>
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><bean:write name="paoofficelist" property="address1" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="location" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="area" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="city" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="pin" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="paoofficelist" property="phone" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="paoofficelist" property="email" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="paoofficelist" property="fax" /></FONT>
</td>

<td align=center>
<a href="./PaoAction.do?paocode=<bean:write name='paoofficelist' property='paocode' />&mode=get">
<font color="#6600CC">Edit&nbsp;</font></a>|&nbsp;
<a href="./PaoAction.do?paocode=<bean:write name='paoofficelist' property='paocode'/>&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>

</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

