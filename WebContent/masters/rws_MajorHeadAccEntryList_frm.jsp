<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=400>
<tr><td align=right><html:link page="/MajorHead.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_MajorHead_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_MajorHead_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="400"   bgcolor="#8A9FCD">
	<tr>
		<td class=textborder>
			<font color="#FFFFFF">Major Head Office Form</font></td>
		<td align=right>
			<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;
		</td>
	</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="400" border=1 style="border-collapse:collapse" >
	<tr >
		<td  class="clrborder" align=center >
			<bean:message key="app.majorHeadCode" />
		</td>
		<td  class="clrborder" align=center >
			<bean:message key="app.majorHeadName" />
		</td>
		<td class="clrborder" align=center >
			<bean:message key="app.op" />
		</td>
	</tr>

<logic:iterate id="majorheadlist" name="majorHeads">
	<tr align="left" >
		<td  class="bwborder" align="center">
			<bean:write name="majorheadlist" property="majorHeadCode"/>
		</td>
		<td  class="bwborder">
			<bean:write name="majorheadlist" property="majorHeadName" />
		</td>
		<td class="bwborder">
			<a href="./MajorHead.do?majorHeadCode=<bean:write name='majorheadlist' property='majorHeadCode' />&mode=get"><font color="#6600CC">Edit</font></a>&nbsp;&nbsp;|&nbsp;
			<a href="./MajorHead.do?majorHeadCode=<bean:write name='majorheadlist' property='majorHeadCode' />&mode=delete"onclick="return deleteRec()"><font color="#990066">Delete</font></a>
		</td>
	</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
 

