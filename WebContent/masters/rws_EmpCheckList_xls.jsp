<%@ include file="/commons/rws_header1.jsp" %>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rws_EmpCheckList_xls.xls");
%>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department,
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
 
<tr><td colspan=5 class="textborder">Emp CheckList Form</td></tr>
<tr class="bwborder">

		<td align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT>
		</FONT>
		</td>
	
		<td nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector" />/</FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode1"/></FONT>
		</td>
	
		<td nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.surname" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.name1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.gender" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.relation" /></FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dob" /></FONT></FONT>
		</td>
			
		<td nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.ndistrict" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.nmandal" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><center><bean:message key="app.nrevenue"/></center></FONT></FONT>
		</td>
		
		<td>
		<FONT class=myfontclr><font color="#993366">&nbsp;<bean:message key="app.zone" /></FONT></FONT>
		</td>

		<td  nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual211" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual12" /></FONT></FONT>
		</td>
		
		<td nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.tempdesig1" /></FONT></FONT>
		</td>
		
		<td  align=center colspan=2>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.otherDet" /></FONT></FONT>
		</td>
	
</tr>
<% int a=1; %>
<logic:iterate id="emplist" name="emps">

<tr>
<td  class=mycborder1 align=center>
<FONT class="bwborder"><%=a++ %></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="roc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="hoc" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="coc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="doc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="sdoc"/></FONT><BR>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="surname" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="gender" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="dob" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="ndist" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nmand" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nrevenue" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="zone" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="qualName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual1" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual2" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="desig" /></FONT>
</td>

<td  class=mycborder1 colspan=2>
<FONT class=myfontclr1><bean:write name="emplist" property="otherDet" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>

</body>
</html>

