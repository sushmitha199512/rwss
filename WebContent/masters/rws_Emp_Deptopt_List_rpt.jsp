<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department,
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<caption align=right>
<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
</caption>
<tr><td colspan=5 class="textborder">Employee DepartmentOpted Report</td></tr>
<tr class="bwborder">

		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT></FONT>
		</td>
		
		<td  class=mycborder>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector"/></FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode"/></FONT></FONT>
		</td>
		
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empname" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.deptOpt" /></FONT></FONT>
		</td>
		
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.doj1" /></FONT></FONT>
		</td>
		
		<td  class=mycborder>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" /></FONT><BR>
		</td>
		
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" /></FONT><BR>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.presentdesig" /></FONT><BR>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.spouseEmploy" /></FONT><BR>
		</td>
	
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.apcatog" /></FONT>
		</td>
	
		</tr>
			
<% int a=1; %>
<logic:iterate id="emplist" name="DeptReport">

<tr>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=a++ %></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="roc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="hoc" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="coc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="doc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="sdoc"/></FONT><BR>
</td>

<td  class=mycborder1  nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="deptopted" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="doj" /></FONT><BR>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="qual" /></FONT><BR>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="presentdesig" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="spouseemployd" /></FONT><BR>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="apcatog" /></FONT><BR>
</td>

</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
</body>

