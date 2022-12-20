<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=535>
<tr><td align=right><html:link page="/WaterLab.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_WQLabMaster_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_WQLabMaster_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<%
  int count=1;
 %>
<table  width="95%" bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Water Quality Test Form</font></B></td>
<td align=right><IMG SRC="/pred/images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="95%" border=1 style="border-collapse:collapse" >
<tr >
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sno</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.labCode" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366"><bean:message key="app.labName" /></FONT>
	</td>
	
    <td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Circle Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Division Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Mandal Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366"><bean:message key="app.location" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Lab Head</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Year Of Establishment</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Contact Number</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Level Code</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
	</td>
	</tr>

<logic:iterate id="labs" name="wqlabs">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%= count++ %></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="labs" property="labCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="labName" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="coc" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="doc" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="mancode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="location" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="desgnCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="labEstablishedYear" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="contactNum" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="levelCode" /></FONT>
</td>

<td  class=mycborder1 align=center>
<a href="./WaterLab.do?labCode=<bean:write name='labs' property='labCode' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
</td>
</tr>
</logic:iterate>
</table>
 
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

