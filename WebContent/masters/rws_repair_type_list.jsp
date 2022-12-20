<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<table width=500>
<tr><td align=right><html:link page="/repair.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="../admin/rws_general_admn_loginsuccess.jsp">Home</a>
</tr>
</table>

<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Repair Type List</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
<td class=mycborder align=center>
	<font class=myfontclr><font color="#993366">S.No</FONT>
	</td>
	<td class=mycborder align=center>
	<font class=myfontclr><font color="#993366"><font color="#993366">Repair Code</FONT>
	</td>
	<td class=mycborder align=center>
	<font class=myfontclr><font color="#993366">Repair Description</FONT>
	</td>
	<td class=mycborder align=center>
	<font class=myfontclr><font color="#993366">Action</FONT>
	</td>
	</tr>
<logic:present name="repairs">
<%int i=1;%>
<logic:iterate id="repairList" name="repairs">
<tr align="left" >
<td  class=mycborder1>
<FONT class=myfontclr1><%=i++%></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="repairList" property="repairCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="repairList" property="repairName" /></FONT>
</td>


 <td  class=mycborder1 align=center>
<a href="./repair.do?repairCode=<bean:write name='repairList' property='repairCode' />&repairName=<bean:write name='repairList' property='repairName' />&mode=get"><font color="#6600CC">Edit&nbsp;</font></a>&nbsp;&nbsp;
</td>  


</tr>
</logic:iterate>
</logic:present>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>




