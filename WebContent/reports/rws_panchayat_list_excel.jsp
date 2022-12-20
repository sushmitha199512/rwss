<%@ include file="/commons/rws_header1.jsp"%>

<%@ page contentType = "application/vnd.ms-excel" %>
<html:html>
<HEAD>
<TITLE>PanchayatList</TITLE>
<head>
</HEAD>
<p>
<BODY>
<p align="center">
<table bgcolor="#8A9FCD">
<tr>
<td class=myfontclr colspan="5" align="center"><B><font color="#FFFFFF">WaterSoft Rural Water Supply <br></font></B></td>
</table>

<table    width="55%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr colspan="5" align="center"><B><font color="#FFFFFF">Panchayats List</font></B></td></tr></table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#ffffff">
<td align="center" class=btext colspan="5">District Name:<%=session.getAttribute("distname")%></td>
</tr>
</table>

<TABLE border="1" cellspacing="0" cellpadding="0" width="55%">
	<tr bgcolor="#ffffff">
	<td class=clrborder align="center">Sl.No</td>
	<td align="center" class=clrborder>Mandal Code</td>
	<td align="center" class=clrborder>Mandal Name</td>
	<td align="center" class=clrborder>Panchayat Code</td>
	<td align="center" class=clrborder>Panchayat Name</td>
	</tr>	

	<% int count=0; %>
	<logic:iterate id="employee" name="panchayatdisplay">
	<% count=count+1;%>
	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
		<td align="center" class="bwborder"><%=count %></td>
		<td align="center" class=bwborder>&nbsp;<bean:write name="employee" property="mcode" /></td>
		<td align="left" class=bwborder><bean:write name="employee" property="mname" /></td>
		<td align="center" class=bwborder>&nbsp;<bean:write name="employee" property="pcode" /></td>
		<td align="left" class=bwborder><bean:write name="employee" property="pname" /></td>
	</logic:iterate>
 </TABLE>

</BODY>
</p>
</html:html>