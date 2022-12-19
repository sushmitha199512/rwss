<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=500>
<tr><td align=right><html:link page="/reasons.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="../admin/rws_general_admn_loginsuccess.jsp">Home</a>
</tr>
</table>

<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Reasons for Delay List</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">S.No</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Reason Code</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Reason Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Action</FONT>
	</td>
	</tr>
<logic:present name="reasons">
<%int i=1;%>
<logic:iterate id="reasonsList" name="reasons">
<tr align="left" >
<td  class=mycborder1>
<FONT class=myfontclr1><%=i++%></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="reasonsList" property="reasonCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="reasonsList" property="reasonName" /></FONT>
</td>


 <td  class=mycborder1 align=center>
<a href="./reasons.do?reasonCode=<bean:write name='reasonsList' property='reasonCode' />&reasonName=<bean:write name='reasonsList' property='reasonName' />&mode=get"><font color="#6600CC">Edit&nbsp;</font></a>&nbsp;&nbsp;

</td>  


</tr>
</logic:iterate>
</logic:present>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
