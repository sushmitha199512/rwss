<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=400>
<tr><td class="myfontclr1" align="right">
<html:link page="/PublicRep.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_PublicRep_rpt.jsp?mode=print" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_PublicRep_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="400"   bgcolor="#8A9FCD">
<tr><td class="myfontclr"><B><font color="#FFFFFF">Public Representatives Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="400" border=1 style="border-collapse:collapse" >
	<tr >
		<td  class="clrborder" align=center><bean:message key="app.repCode" /></td>
		<td  class="clrborder" ><bean:message key="app.repName" /></td>
		<td  class="clrborder" align=center><bean:message key="app.op" /></td>

	</tr>

	<logic:iterate id="publicreplist" name="publicReps">
		<tr align="left" >
			<td  class="bwborder" align=center >
			<bean:write name="publicreplist" property="publicRepCode" />
			</td>
			<td  class="bwborder" >
			<bean:write name="publicreplist" property="publicRepName" />
			</td>
			<td  class="bwborder" align=center>
			<a href="./PublicRep.do?publicRepCode=<bean:write name='publicreplist' property='publicRepCode' />&mode=get"><font color="#6600CC">Edit&nbsp;</font></a>
			</td>
		</tr>
	</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


