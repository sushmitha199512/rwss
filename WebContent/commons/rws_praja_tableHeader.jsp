<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>

<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_t_left1.gif'/>" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=<%=request.getParameter("TWidth")%>>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B><%=request.getParameter("TableName")%></B><font></td>
	    <td align=right><IMG SRC="<rws:context page='/images/icon_help.gif'/>" WIDTH="12" HEIGHT="12" >&nbsp;
		<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClosePraja()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_t_right1.gif'/>" ALT=""></TD>
</TABLE>