<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=500>
<tr><td align=right><html:link page="/milestonestage.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="../admin/rws_general_admn_loginsuccess.jsp">Home</a>
</tr>
</table>

<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">MileStone Stages</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">S.No</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">MileStone Code</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">MileStone Stage Code</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">MileStone Stage Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">DDWS Linked</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Action</FONT>
	</td>
	</tr>
<logic:present name="mileStoneSages">
<%int i=1;%>
<logic:iterate id="mileStoneSages" name="mileStoneSages">
<tr align="left" >
<td  class=mycborder1>
<FONT class=myfontclr1><%=i++%></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="mileStoneSages" property="mileStoneCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="mileStoneSages" property="mileStoneStageCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="mileStoneSages" property="mileStoneStageName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<logic:equal value="Y" name="mileStoneSages" property="ddwsLinked">
<FONT class=myfontclr1>Yes</FONT>
</logic:equal>
<logic:equal value="N" name="mileStoneSages" property="ddwsLinked">
<FONT class=myfontclr1>No</FONT>
</logic:equal>
</td>

<td  class=mycborder1 align=center>
<a href="./milestonestage.do?mileStoneCode=<bean:write name='mileStoneSages' property='mileStoneCode' />&mileStoneStageCode=<bean:write name='mileStoneSages' property='mileStoneStageCode' />&mileStoneStageName=<bean:write name='mileStoneSages' property='mileStoneStageName' />&ddwsLinked=<bean:write name='mileStoneSages' property='ddwsLinked' />&mode=get"><font color="#6600CC">Edit&nbsp;</font></a>&nbsp;&nbsp;

</td> 


</tr>
</logic:iterate>
</logic:present>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
