<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0">
<table   width="100%" border=1 style="border-collapse:collapse" >
<tr><td class=myfontclr colspan=3><B>Water Quality Test Form</font></B></td></tr>
<tr >
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.labCode" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.labName" /></FONT>
	</td>
    <td class=mycborder align=center>
	<FONT class=myfontclr>Circle Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Division Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Mandal Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.location" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Lab Head</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr>Year Of Establishment</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Contact Number</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Level Code</FONT>
	</td>
	</tr>

<logic:iterate id="labs" name="wqlabs">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="labs" property="labCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="labName" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="coc" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="doc" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="mancode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="location" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="desgnCode" /></FONT>

</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="labEstablishedYear" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="contactNum" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="levelCode" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
