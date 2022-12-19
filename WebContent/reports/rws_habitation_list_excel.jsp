<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType = "application/vnd.ms-excel" %>
<html:html>
<BODY>
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0"> 
<HEAD><TITLE>PanchayatList</TITLE>
</HEAD>
<P>
<p align="center">
<table bgcolor="#8A9FCD">
<tr>
<td class=myfontclr colspan="9" align="center"><B><font color="#FFFFFF">WaterSoft Rural Water Supply <br></font></B></td>
</table>


<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr colspan="9" align="center"><B><font color="#FFFFFF">HabitationLists</font></B></td></tr></table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#ffffff"><td align="center" class=btext colspan="9">District :<%=session.getAttribute("distname")%></td>
</tr>

</table>

	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#ffffff">
	<td class=clrborder>Sl.No</td>
	<td align="center" class=clrborder>Mandal Code</td>
	<td align="center" class=clrborder>Mandal Name</td>
	<td align="center" class=clrborder>Panchayat Code</td>
	<td align="center" class=clrborder>Panchayat Name</td>
	<td align="center" class=clrborder>Village Code</td>
	<td align="center" class=clrborder>Village Name</td>
	<td align="center" class=clrborder>Habitation Code</td>
	<td align="center" class=clrborder>Habitation Name</td>
	</tr>
	<% int count=0; %>
	
	<logic:iterate id="employee" name="habitationdisplay">
	<% count=count+1;%>
	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
		<td  class="bwborder" ><%=count %></td>
		<td align="center" class=bwborder>&nbsp;<bean:write name="employee" property="mcode" /></td>
		<td align="left" class=bwborder><bean:write name="employee" property="mname" /></td>
		<td align="center" class=bwborder>&nbsp;<bean:write name="employee" property="pcode" /></td>
		<td align="left" class=bwborder><bean:write name="employee" property="pname" /></td>
		<td align="center" class=bwborder>&nbsp;<bean:write name="employee" property="vcode" /></td>
		<td align="left" class=bwborder><bean:write name="employee" property="vname" /></td>
        <td align="center" class=bwborder>&nbsp;<bean:write name="employee" property="panchcode" /></td>
		<td align="left" class=bwborder><bean:write name="employee" property="panchname" /></td>
	</tr>
	</logic:iterate>
	</TABLE>

</html:html>


