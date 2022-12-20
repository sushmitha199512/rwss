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
<tr><td colspan=10 class="textborder">Employee Form</td></tr>
<tr >

		<td align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT></FONT>
		</td>
	
		<td  align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector" />/</FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode1"/></FONT>
		</td>
	
		<td >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.surname" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.name1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.social1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.relation" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.gender" />./</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.religion" />./</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dob" />.</FONT></FONT>
		</td>
						
		<td>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.ndistrict" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.nmandal" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><center><bean:message key="app.nrevenue"/>.</center></FONT></FONT>
		</td>
		
		<td>
		<FONT class=myfontclr><font color="#993366">&nbsp;<bean:message key="app.zone" /></FONT></FONT>
		</td>

		<td >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.deptOpt" /></FONT></FONT>
		</td>
		
		<td  align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual21" /></FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual12" /></FONT></FONT>
		</td>
					
		<td  align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" />./</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desig" /></FONT></FONT>
		</td>
	
		<td  align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.seniority" /></FONT></FONT>
		</td>
										
		<td align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.workSpecial" /></FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.section" /></FONT></FONT>
		</td>
		
		<td  align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.otherDet" /></FONT></FONT>
		</td>
	
		</tr>
<% int a=1; %>
<logic:iterate id="emplist" name="emps">

<tr>
<td  class=mycborder1 align=center>
<FONT class="bwborder"><%=a++ %></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="roc"/></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="hoc" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="coc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="doc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="sdoc"/></FONT><BR>
</td>

<td  class=mycborder1 align=center >
<BR><FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="surname" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="social" /></FONT>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="gender" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="religion" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="dob" /></FONT><BR>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="ndist" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nmand" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nrevenue" /></FONT>
</td>

<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="emplist" property="zone" /></FONT>
</td>

<td class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="dept" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="qualName" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual1" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual2" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnCode" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="desig" /></FONT>
</td>

<TD class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="seniority" /></FONT>
</TD>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="workSpecial" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="section" /></FONT><BR>
</td>


<td  class=mycborder1  align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="otherDet" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>

</body>
</html>
