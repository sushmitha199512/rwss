<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
 
<tr><td colspan=5 class="textborder">Employee Form</td></tr>
<tr class="bwborder">

	<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector"/>&nbsp;</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode"/></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empname" /></FONT></FONT><br>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.deptOpt" /></FONT></FONT>
		</td>
		
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.doj1" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" /></FONT><BR>
		</td>
		
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" />/</FONT><BR>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.presentdesig" /></FONT><BR>
		
		</td>
		
		<td  class=mycborder align=center>

		<FONT class=myfontclr><font color="#993366"><bean:message key="app.spouseWorking" /></FONT><BR>
		
		</td>
	
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.apcatog" /></FONT><BR>
		</td>
					
			
		</tr>
		
	
<% int a=1; %>
<logic:iterate id="emplist" name="DeptReport">

<tr>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=a++ %></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="roc"/></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="hoc" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="coc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="doc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="sdoc"/></FONT><BR>

</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR><br>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="deptopted" /></FONT><BR><br>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="doj" /></FONT><BR><br>
</td>


<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="qual" /></FONT><BR>
</td>


<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="presentdesig" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>

<FONT class=myfontclr1><bean:write name="emplist" property="spouseworking" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="apcatog" /></FONT><BR>
</td>


</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>


