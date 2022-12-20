	<%@ include file="/commons/rws_header1.jsp" %>
	<html:javascript formName="assetForm" />
	<%@ include file="/commons/rws_header2.jsp" %>
	<tr height="96%">
	<td align="center" valign="middle">

	<html:form action="Asset?mode=submit" onsubmit="return validateAssetForm(this)">

	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/images/r_t_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=320>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#FFFFFF" face=verdana size=2><B>Design Parameters of HeadWorks </B><font></td>
	    <td align=right><IMG SRC="/pred/images/icon_help.gif" WIDTH="12" HEIGHT="12" >&nbsp;
		<IMG SRC="/pred/images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="window.close()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/images/r_t_right1.gif" ALT=""></TD>
</TABLE>

	<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border="1" style="border-collapse:collapse;" width="360" align="center">
	<tr>
	<TD class="mycborder">
	<FONT class=myfontclr>Diameter<font color="#FF6666">&nbsp;(mts)&nbsp;*</font></FONT>
	</TD>
    <TD><html:text property="diameter" styleClass="mytext" value="" maxlength="3"/></TD>
	</tr>
	<tr>
	<TD class="mycborder">
	<FONT class=myfontclr>Depth<font color="#FF6666">&nbsp;(mts)&nbsp;*</font></FONT>
	</TD>
    <TD><html:text property="depth" styleClass="mytext" value="" maxlength="3"/></TD>
	</tr>
	<tr>
	<TD class="mycborder">
	<FONT class=myfontclr>Design Period<font color="#FF6666">&nbsp;(minutes)&nbsp;*</font></FONT></TD>
    <TD><html:text property="yield" styleClass="mytext" value="" maxlength="3"/></TD>
	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Save" onclick="return winView()" />
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 
	
	</td>
	</tr>
	</table>
	
 <jsp:include page="TableFotter.jsp">
	<jsp:param name="TWidth" value="320"/>
</jsp:include>

</html:form>

</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>

