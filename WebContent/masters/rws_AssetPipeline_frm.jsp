	<%@ include file="/commons/rws_header1.jsp" %>
	<html:javascript formName="assetForm" />
	<%@ include file="/commons/rws_header2.jsp" %>
	<tr height="96%">
	<td align="center" valign="middle">

	<html:form action="Asset?mode=submit" onsubmit="return validateAssetForm(this)">

	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/images/r_t_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=500>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#FFFFFF" face=verdana size=2><B>Design Parameters of Pipeline Entry</B><font></td>
	    <td align=right><IMG SRC="/pred/images/icon_help.gif" WIDTH="12" HEIGHT="12" >&nbsp;
		<IMG SRC="/pred/images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="window.close()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/images/r_t_right1.gif" ALT=""></TD>
</TABLE>

	<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border="1" style="border-collapse:collapse;" width="540" align="center">
	<tr>
	<TD class="mycborder">
	<FONT class=myfontclr>Type<font color="#FF6666">*</font></FONT>
	</TD>
    <TD><html:select property="diameter" styleClass="mycombo" >
	<html:option value="pvc">PVC</html:option>
	<html:option value="hdpe">HDPE</html:option>
	<html:option value="di">DI</html:option>
	<html:option value="ci">CI</html:option>
	<html:option value="bwsc">BWSC</html:option>
	<html:option value="grp">GRP</html:option>
	<html:option value="ms">MS</html:option>
	</html:select>
	</TD>
	<TD class="mycborder">
	<FONT class=myfontclr>Class<font color="#FF6666">&nbsp;(mm)&nbsp;*</font></FONT>
	</TD>
    <TD><html:text property="depth" styleClass="mytext" value="" maxlength="3"/></TD>
	</tr>
	<tr>
	<TD class="mycborder">
	<FONT class=myfontclr>Diameter<font color="#FF6666">&nbsp;(mts)&nbsp;*</font></FONT></TD>
    <TD><html:text property="yield" styleClass="mytext" value="" maxlength="3"/></TD>
	<TD class="mycborder">
	<FONT class=myfontclr>Length<font color="#FF6666">&nbsp;(mts)&nbsp;*</font></FONT></TD>
    <TD><html:text property="yield" styleClass="mytext" value="" maxlength="3"/></TD>
	</tr>
	<tr>
	<TD class="mycborder">
	<FONT class=myfontclr>Valves<font color="#FF6666">*</font></FONT></TD>
    <TD><html:text property="yield" styleClass="mytext" value="" maxlength="3"/></TD>
	<TD class="mycborder">
	<FONT class=myfontclr>Public Stand Posts<font color="#FF6666"></font></FONT></TD>
    <TD><html:text property="yield" styleClass="mytext" value="" maxlength="3"/></TD>
	</tr>
	<tr>
	<TD class="mycborder">
	<FONT class=myfontclr>House Connections<font color="#FF6666"></font></FONT></TD>
    <TD><html:text property="yield" styleClass="mytext" value="" maxlength="3"/></TD>
	</tr>
	<tr>
	<td colspan="4" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Submit" onclick="return winView()" />
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 
	
	</td>
	</tr>
	</table>
	
 <jsp:include page="TableFotter.jsp">
	<jsp:param name="TWidth" value="500"/>
</jsp:include>

</html:form>

</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>

