<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_b_left1.gif'/>" ALT=""></TD>
	  <TD  bgcolor="green" width=<%=request.getParameter("TWidth")%>>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	   <font color="red" face=verdana size=2><B>Note:****</B><font>
	  <font color="white" face=verdana size=2><B><%=request.getParameter("msg")%></B><font></td>
	  </tr>
	  </table>

</td>
	  <TD WIDTH="20" ><IMG SRC="<rws:context page='/images/r_b_right1.gif'/>" ALT=""></TD>
</TABLE>
