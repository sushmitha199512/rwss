<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>

<table width=500>
<tr><td align=right><html:link page="/ddwsPhyComp.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="../admin/rws_general_admn_loginsuccess.jsp">Home</a>
</tr>
</table>

<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">DDWS Physical Components</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">S.No</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">DDWS Comp Code</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">DDWS Comp Name</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Action</FONT>
	</td>
	</tr>
<logic:present name="ddwsPhyComps">
<%int i=1;%>
<logic:iterate id="ddwsPhyCompList" name="ddwsPhyComps">
<tr align="left" >
<td  class=mycborder1>
<FONT class=myfontclr1><%=i++%></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ddwsPhyCompList" property="ddwsPhyCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ddwsPhyCompList" property="ddwsPhyName" /></FONT>
</td>

 <td  class=mycborder1 align=center>
<a href="./ddwsPhyComp.do?ddwsPhyCode=<bean:write name='ddwsPhyCompList' property='ddwsPhyCode' />&ddwsPhyName=<bean:write name='ddwsPhyCompList' property='ddwsPhyName' />&mode=get"><font color="#6600CC">Edit&nbsp;</font></a>&nbsp;&nbsp;
<%-- <a href="./ddwsPhyComp.do?ddwsPhyCode=<bean:write name='ddwsPhyCompList' property='ddwsPhyCode' />&ddwsPhyName=<bean:write name='ddwsPhyCompList' property='ddwsPhyName' />&mode=delete"><font color="#6600CC">|&nbsp;Delete&nbsp;</font></a>&nbsp;&nbsp; --%>

</td> 


</tr>
</logic:iterate>
</logic:present>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
