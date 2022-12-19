<%@ include file="/commons/rws_header1.jsp"%>

<%@ page contentType = "application/vnd.ms-excel" %>
<html>
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
<td class=myfontclr colspan="13" align="center"><B><font color="#FFFFFF">WaterSoft Rural Water Supply <br></font></B></td>
</table>

<table bgcolor="#8A9FCD">
<tr>
<td class=myfontclr colspan="13" align="center"><B><font color="#FFFFFF">Districts List</font></B></td>
</table>
<!-- <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="65%" border=1 style="border-collapse:collapse" ></table> -->

	<TABLE border="1" cellspacing="0" cellpadding="0" width="50%">
	<tr bgcolor="#ffffff">
		<td class=clrborder colspan="1">Sl.No</td>
		<td align="center" class=clrborder colspan="2">District Code</td>
		<td align="center" class=clrborder colspan="2">District Name</td>
		<td align="center" class=clrborder colspan="2">Total Mandals</td>
		<td align="center" class=clrborder colspan="2">Total Panchayats</td>
		<td align="center" class=clrborder colspan="2">Total Villages</td>
		<td align="center" class=clrborder colspan="2">Total Habitations</td>
	</tr>		

	<% int count=0; %>
	<logic:iterate id="employee" name="panchayatdisplays">
	<% count=count+1;%>
		<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
			<td  class="bwborder" colspan="1"><%=count %></td>
			<td align="center" class=bwborder colspan="2"><bean:write name="employee" property="dcode" /></td>
			<td align="left" class=bwborder colspan="2"><bean:write name="employee" property="dname" /></td>
			<td align="center" class=bwborder colspan="2"><bean:write name="employee" property="mcount" /></td>
	        <td align="center" class=bwborder colspan="2"><bean:write name="employee" property="pcount" /></td>
	        <td align="center" class=bwborder colspan="2"><bean:write name="employee" property="vcount" /></td>
	        <td align="center" class=bwborder colspan="2"><bean:write name="employee" property="panchcount" /></td>
		</tr>
		<%if(count==22){%>	
			
			<tr>
			<td colspan="5">Total:</td>
			
			
			<td align="center" class=bwborder colspan="2"><bean:write name="employee" property="totalMcount" /></td>
			<td align="center" class=bwborder colspan="2"><bean:write name="employee" property="totalPcount" /></td>
			<td align="center" class=bwborder colspan="2"><bean:write name="employee" property="totalVcount" /></td>
			<td align="center" class=bwborder colspan="2"><bean:write name="employee" property="totalHabcount" /></td>
			</tr>
			<%}%>
			</logic:iterate>
	</TABLE>

</BODY>
</p>
</html>





