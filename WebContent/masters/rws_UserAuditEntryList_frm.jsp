<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_admin_authorization_struts.jsp"%>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<% //System.out.println("Entered into the UserAuditEntryList_frm.jsp");%>

<table width=100%>
<tr><td align=right>
	<!--<html:link page="/UserAuit.do?mode=data">Back&nbsp;|&nbsp;</html:link>-->
	
	<!--may be error in bottom line-->
   <a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
	<!--
	<html:link page="/rws_Hoffice_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
	<html:link page="/rws_Hoffice_xls.jsp" target="_new">Excel</html:link>
	-->
</tr>
</table>

<table  width=100%   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#ffffff">User Audit List of 
<%= request.getAttribute("circleOfficeName")%>
......</font></B><font color="#FFFFFF"> <small>from <%= request.getParameter("fromDate")%><small> to </small><%=request.getParameter("toDate")%>

</small></font></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<% int i=1;
    ArrayList labelcol2 = (ArrayList)request.getAttribute("useraudits");
	int cnty=labelcol2.size();
	System.out.println("sizeeeee is"+cnty);
%>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width=100% border=1 style="border-collapse:collapse" >

<tr>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.sno" /></FONT></td>
	
	<!-- <td class=myborder  align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.userid"/></FONT></td> 
	
	<td class=mycborder align=center><FONT class=myfontclr>
	<font color="#993366"><bean:message key="app.authtype" /></FONT></td> -->
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.userid" /></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.accessdate" /></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.accesstime" /></FONT></td>
	
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.module" /></FONT></td> 
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.page" /></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.address" /></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.host" /></FONT></td>
	<td class=mycborder align=center><FONT class=myfontclr><font color="#993366"><bean:message key="app.browser" /></FONT></td>
	
</tr>

<%if(cnty != 0) 
{
%>
<logic:iterate id="userauditlist" name="useraudits">
<tr align="center" >
<td align="center" class="bwborder"><%= i++%></td>
<!-- <td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="userId" /></FONT></td>-->

<!-- <td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="authType" /></FONT></td> -->
<td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="userId" /></FONT></td>
<td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="accessDate" /></FONT></td>
<td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="accessTime" /></FONT></td>

<td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="module" /></FONT></td> 
<td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="page" /></FONT></td>
<td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="address" /></FONT></td>
<td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="host" /></FONT></td>
<td  class=mycborder1 align="left"><FONT class=myfontclr1><bean:write name="userauditlist" property="browser" /></FONT></td>
</tr>
</logic:iterate>
</table>
<%} else {%>
<table  width=100%>
<tr><td align="center" class=myfontclr1><B><font class=myfontclr1>No Records To Display</font></B></td>

</table>
<%} %>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>