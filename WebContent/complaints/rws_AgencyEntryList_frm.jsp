<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width=400>
<tr><td align=right><html:link page="/Agency.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<%-- <html:link page="/rws_MajorHead_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_MajorHead_xls.jsp" target="_new">Excel</html:link> --%>
</tr>
</table>
<table    width="400"   bgcolor="#8A9FCD">
	<tr>
		<td class=textborder>
			<font color="#FFFFFF">Agency Form</font></td>
		<td align=right>
			<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;
		</td>
	</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="400" border=1 style="border-collapse:collapse" >
	<tr >
		<td  class="clrborder" align=center >
			Sl.No.
		</td>
		<td  class="clrborder" align=center >
			Agency Name
		</td>
		<td class="clrborder" align=center >
			Agency Code
		</td>
		<td class="clrborder" align=center >
			Options
		</td>
	</tr>
<%int i=0; %>
<logic:iterate id="agencylist" name="Agencys">
	<tr align="left" >
		<td  class="bwborder" align="center">
			<%=i++ %>
		</td>
		<td  class="bwborder" align="center">
			<bean:write name="agencylist" property="agencyCode"/>
		</td>
		<td  class="bwborder">
			<bean:write name="agencylist" property="agencyName" />
		</td>
		<td class="bwborder">
			<a href="./Agency.do?agencyCode=<bean:write name='agencylist' property='agencyCode' />&mode=get"><font color="#6600CC">Edit</font></a>&nbsp;&nbsp;|&nbsp;
			<a href="./Agency.do?agencyCode=<bean:write name='agencylist' property='agencyCode' />&mode=delete"onclick="return deleteRec()"><font color="#990066">Delete</font></a>
		</td>
	</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
 

