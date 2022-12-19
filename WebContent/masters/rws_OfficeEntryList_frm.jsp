<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<script language="javascript">
//methods added by swapna on 14-07-2011
function openDeleteWindow(roc) {
	var width = 1;
	var height = 1;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
		 var url= ;
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
function openEditWindow(roc) {
		var width = 850;
		
	var height = 550;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
		 	
			var url= "/pred/masters/Office.do?mode=get&roc="+roc;
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	newWindow = window.open(url, "_New", properties);
		//alert("in4" );
	newWindow.focus();
}
</script>
<table width=770>
<tr><td align=right><html:link page="/switch.do?prefix=/masters&page=/Office.do&mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_Office_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Office_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="770"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Office Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="770" border=1 style="border-collapse:collapse" >
<tr >
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366">S.No.</FONT></td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.code" /></FONT></td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.address" /></FONT></td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.phone" /></FONT></td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.fax" /></FONT></td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.email" /></FONT></td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.building" /></FONT></td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.hof" /></FONT></td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.project" /></FONT></td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></td>
		
		</tr>
<%int sno=1;%>
<logic:iterate id="rwsofficelist" name="offices">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=sno++%></FONT></td> 
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="roc" /></FONT></td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="address" /></FONT><br>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="location" /></FONT><br>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="area" /></FONT><br>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="city" /></FONT><br>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="pin" /></FONT></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="phone" /></FONT></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="fax" /></FONT></td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="email" /></FONT></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="building" /></FONT></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="hof" /></FONT></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="rwsofficelist" property="project" /></FONT></td>

<!-- <td  class=mycborder1 align=center>
<a href="./masters/Office.do?roc=<bean:write name='rwsofficelist' property='roc' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;
<a href="./masters/Office.do?roc=<bean:write name='rwsofficelist' property='roc' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td> -->
<td nowrap>
<a href="#1" onclick="openEditWindow('<bean:write name='rwsofficelist' property='roc' />')">
<font color="#6600CC"><b>Edit</b></font></a>&nbsp;|&nbsp;
<a href="/pred/masters/Office.do?mode=delete&roc=<bean:write name='rwsofficelist' property='roc' />"><font color="#990066" ><b>Delete</b></font></a>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

