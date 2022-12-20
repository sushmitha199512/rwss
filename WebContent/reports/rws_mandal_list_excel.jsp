<%@ include file="/commons/rws_header1.jsp"%>

<%@ page contentType = "application/vnd.ms-excel" %>
<html:html>
<HEAD>
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0"> 
<TITLE>DistrictList</TITLE>
<head>
</HEAD>
<p>

<BODY>
<p align="center">
<table bgcolor="#8A9FCD">
<tr>
<td class=myfontclr colspan="6" align="center"><B><font color="#FFFFFF">WaterSoft Rural Water Supply <br></font></B></td>
</table>

<table width="55%" bgcolor="#8A9FCD">
<tr><td class=myfontclr colspan="6" align="center"><B><font color="#FFFFFF">Mandals List</font></B></td></tr></table>
<table  bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#ffffff">
<td align="center" class=btext colspan="6">District Name:<%=session.getAttribute("distname")%></td>
</tr>
</table>

	<TABLE border="1" cellspacing="0" cellpadding="0" width="55%">
	<tr bgcolor="#ffffff">
		<td class=clrborder align="center" colspan="2">Sl.No</td>
		<td align="center" class=clrborder colspan="2">Mandal Code</td>
		<td align="center" class=clrborder colspan="2">Mandal Name</td>
	</tr>
	<% int count=0; %>
	
	<logic:iterate id="employee" name="mandaldisplay">
	<% count=count+1;%>
	<tr>
		<td align="center" class="bwborder" colspan="2" ><%=count%></td>
		<td align="center" class=bwborder colspan="2">&nbsp;<bean:write name="employee" property="mcode" /></td>
		<td align="left" class=bwborder colspan="2">&nbsp;<bean:write name="employee" property="mname" /></td>
	</logic:iterate>
	</TABLE>
<!-- <table><tr><td></td></tr> --> 
</BODY>
</p>
</html:html>
