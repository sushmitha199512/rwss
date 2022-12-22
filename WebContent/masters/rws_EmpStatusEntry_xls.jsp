<%@ include file="/commons/rws_header1.jsp" %>
<%

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rws_EmpStatusEntry_xls.xls");
%>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department,
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
 
<tr><td colspan=5 class="textborder">Employee Form</td></tr>
	<tr class="bwborder">
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT></FONT>
		</td>
		
		<td  class=mycborder>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector"/>/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode"/></FONT></FONT>
		</td>
		
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empname" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.fatherName" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dob" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.appointdate1" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.doj1" /></FONT></FONT>
		</td>

		<td  class=mycborder >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.localzone1" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.zone" /></FONT></FONT>
		</td>
	
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" /></FONT>
		</td>
				
		</tr>
		
	
<% int a=1; %>
<logic:iterate id="emplist" name="empsReport">

<tr>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=a++ %></FONT>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="roc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="hoc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="coc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="doc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="sdoc" /></FONT>
</td>

<td class=mycborder1>
<FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT>
</td>

<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="emplist" property="dob" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<br><FONT class=myfontclr1><bean:write name="emplist" property="appointdate" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="doj" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="localzone" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="zoneName" /></FONT>
</td>

<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT>
</td>

</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>


