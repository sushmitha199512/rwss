,<%@ include file="/commons/rws_header1.jsp"%>
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
<td class=myfontclr colspan="7" align="center"><B><font color="#FFFFFF">WaterSoft Rural Water Supply <br></font></B></td>
</table>

<table width="100%"  bgcolor="#8A9FCD">
<tr><td class=myfontclr colspan="7" align="center"><B><font color="#FFFFFF">Villages List</font></B></td></tr></table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD" width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#ffffff">
<td align="center" class=btext colspan="7">District Name:<%=session.getAttribute("distname")%></td>
</tr>
</table>

	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#ffffff">
		<td class=clrborder>Sl.No</td>
		<td class=clrborder>Mandal Code</td>
		<td class=clrborder>Mandal Name</td>
		<td class=clrborder>Panchayat Code</td>
		<td class=clrborder>Panchayat Name</td>
		<td align="center" class=clrborder>Village Code</td>
		<td align="center" class=clrborder>Village Name</td>
	</tr>	

	<% int count=0; %>
	<logic:iterate id="employee" name="villagedisplay">
	<% count=count+1;%>
	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
		<td  align="center" class="bwborder" ><%=count %></td>
		<td align="center" class=bwborder>&nbsp;<bean:write name="employee" property="mcode" /></td>
		<td align="left" class=bwborder><bean:write name="employee" property="mname" /></td>
		<td align="center" class=bwborder>&nbsp;<bean:write name="employee" property="pcode" /></td>
		<td align="left" class=bwborder><bean:write name="employee" property="pname" /></td>
		<td align="center" class=bwborder>&nbsp;<bean:write name="employee" property="vcode" /></td>
		<td align="left" class=bwborder><bean:write name="employee" property="vname" /></td>
	</logic:iterate>
	</TABLE>
</BODY>
</p>
</html:html>


