<%@ include file="/commons/rws_header1.jsp" %>
</head>
<body topmargin="0" leftmargin="0" bgcolor="#edf2f8">
 
<table align=center>
<tr><td align=right><a  onclick="javascript:window.close()">Close</a></td></tr>
<tr><td>
<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff">
<tr>
<tr bgcolor="#8A9FCD"><td colspan=8><b><font face=verdana size=2 color="#ffffff">Source Finalisation List</font></b></td></tr>
<tr>
	<td align=center class="clrborder">Sanction Date</td>
	<td align=center class="clrborder">Habitation</td>
	<td align=center class="clrborder">Source</td>
	<td align=center class="clrborder">Programme</td>
	<td align=center class="clrborder">SubProgramme</td>
	<td align=center class="clrborder">Site Identification Date</td>
	<td align=center class="clrborder">Site Finalise Date</td>
	<td align=center class="clrborder">Finalised By</td>
</tr>

<logic:iterate id="wqFinalStatusList" name="wqFinalStatus">
 <tr align="left" bgcolor="#ffffff">

<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="wqFinalStatusList" property="drillDate" /></FONT>
 </td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="wqFinalStatusList" property="habName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="wqFinalStatusList" property="sourceName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="wqFinalStatusList" property="prgmName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="wqFinalStatusList" property="subprgmName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="wqFinalStatusList" property="siteIdenData" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="wqFinalStatusList" property="finalDate" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="wqFinalStatusList" property="preparedBy" /></FONT>
</td>

</tr>
</logic:iterate>
	
</table>
</td></tr>
</table>
</body>
</html>