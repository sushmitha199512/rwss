<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
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
<tr><td colspan=5 class="textborder">Emp Status Entry Report</td></tr>
<tr class="bwborder">

		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector"/>&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode"/></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode" />/</FONT></FONT>
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

		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.localzone1" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.zone" /></FONT></FONT>
		</td>
	
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" /></FONT><BR>
		</td>
				
		</tr>
		
	
<% int a=1; %>
<logic:iterate id="emplist" name="empsReport">

<tr>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=a++ %></FONT>
</td>

<td class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="roc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="hoc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="coc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="doc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="sdoc" /></FONT><br>

</td>

<td class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR><br>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT><BR>
</td>

<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="emplist" property="dob" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<br><FONT class=myfontclr1><bean:write name="emplist" property="appointdate" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="doj" /></FONT><BR><br>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="localzone" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="zoneName" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT><BR>
</td>

</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>


