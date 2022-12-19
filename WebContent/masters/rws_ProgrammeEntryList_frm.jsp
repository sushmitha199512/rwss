<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<table width=700>
	<tr>
		<td align=right><html:link page="/Programme.do?mode=data">Back&nbsp;|&nbsp;</html:link>
			<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a> <html:link
				page="/rws_Programme_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
			<html:link page="/rws_Programme_xls.jsp" target="_new">Excel</html:link>
	</tr>
</table>
<table width="920" bgcolor="#8A9FCD">
	<tr>
		<td class=myfontclr><B><font color="#FFFFFF">Programes List</font></B></td>
		<td align=right><IMG
			SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12"
			onclick="winClose()" style="cursor: hand" alt="Close">&nbsp;&nbsp;</td>
	</tr>
</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="800" border=1
	style="border-collapse: collapse">
	<tr>
		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366">Prog Code</font></FONT></td>
		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366">Prog Name</font></FONT></td>
		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366">Prog Start Yr.</font></FONT></td>
		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366">Shares Details</font></FONT></td>
		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366"><bean:message key="app.status" /></font></FONT></td>
		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366">Prog End Date</font></FONT></td>

		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366">NRDWP-Related</font></FONT></td>
		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366">CM CoreDashboard</font></FONT></td>
		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366"></font>Centre/State/District</FONT></td>
		<td class=mycborder nowrap><FONT class=myfontclr><font
				color="#993366"><bean:message key="app.op" /></font></FONT></td>
	</tr>

	<logic:iterate id="programmelist" name="programmes">
		<tr align="left">
			<td class=mycborder1><FONT class=myfontclr1><bean:write
						name="programmelist" property="prgmCode" /></FONT></td>
			<td class=mycborder1><FONT class=myfontclr1><bean:write
						name="programmelist" property="prgmName" /></FONT></td>
			<td class=mycborder1><FONT class=myfontclr1><bean:write
						name="programmelist" property="prgmStartYr" /></FONT></td>
			<td class=mycborder1><FONT class=myfontclr1>Central
					Share:<bean:write name="programmelist" property="centralShare" />
			</FONT><br> <FONT class=myfontclr1>State Share
					&nbsp;&nbsp;&nbsp;:<bean:write name="programmelist"
						property="stateShare" />
			</FONT><br> <FONT class=myfontclr1>Public Share &nbsp;&nbsp;:<bean:write
						name="programmelist" property="publicShare" /></FONT><br> <FONT
				class=myfontclr1>Other Share &nbsp;&nbsp; :<bean:write
						name="programmelist" property="otherShare" /></FONT></td>
			<td class=mycborder1><FONT class=myfontclr1><bean:write
						name="programmelist" property="status" /></FONT></td>
			<td class=mycborder1><FONT class=myfontclr1><bean:write
						name="programmelist" property="prgmEndDate" /></FONT></td>
			<td class=mycborder1><FONT class=myfontclr1><bean:write
						name="programmelist" property="nrdwprelated" /></FONT></td>
			<td class=mycborder1><FONT class=myfontclr1><bean:write
						name="programmelist" property="cmcoredb" /></FONT></td>
			<td class=mycborder1><FONT class=myfontclr1><bean:write
						name="programmelist" property="progBelongTo" /></FONT></td>
			<td nowrap><a
				href="./Programme.do?prgmCode=<bean:write name='programmelist' property='prgmCode' />&mode=get"><font
					color="#6600CC">Edit</font></a><!-- &nbsp;&nbsp;|&nbsp; --><!-- <a href="./Programme.do?prgmCode=<bean:write name='programmelist' property='prgmCode' />&mode=delete" onclick="return deleteRec()"><font color="#990066" >Delete</font></a> -->
			</td>
		</tr>
	</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


