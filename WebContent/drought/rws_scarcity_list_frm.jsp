<%@ include file="/commons/rws_header1.jsp" %>

<%@ include file="/commons/rws_header2.jsp" %>
<html:html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">

<script language="JavaScript">

function openEditWindow(url)
{
	var width = 1000
	var height = 500;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
	+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
	+ "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
	//newWindow = window.open(url, "_blank", properties);
	newWindow.focus();
	}
function openDeleteWindow(url)
{
	 var width = 100;
	 var height = 100;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 	 
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	}
</script>

<table width=400>
<tr><td align=right><html:link page="/Scarcity.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
</tr>
</table>
<table    width="400"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Scarcity Reasons Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="400" border=1 style="border-collapse:collapse" >
<tr>
        <td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
		
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.scarcitycode" /></FONT></td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.scarcityname" /></FONT></td>
		
		</tr>
<%int count=1;%>
<logic:iterate id="scarlist" name="scarcity">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=count++%></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="scarlist" property="scarcityCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="scarlist" property="scarcityName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<a href="#1" onclick="openEditWindow('switch.do?prefix=/drought&page=/Scarcity.do?mode=get&scarcityCode=<bean:write name='scarlist' property='scarcityCode'/> ')">Edit&nbsp;|</a>&nbsp;
 <!-- <a href="#1" onclick="openDeleteWindow('switch.do?prefix=/drought&page=/Scarcity.do?mode=delete&scarcityCode=<bean:write name='scarlist' property='scarcityCode' />')">
<font color="#990066">Delete</font></a> -->
</td> 


</tr>
</logic:iterate>

</table>
</html:html>
<%@ include file="/commons/rws_footer.jsp"%>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>
<%@ include file="/commons/rws_alert.jsp"%>



