<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>


<table width="97%">
<tr>
<td align="right">
<td align="right"><html:link page="/Employee.do?mode=DeptOptForms">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_Emp_Deptopt_List_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Emp_Deptopt_xls.jsp" target="_new">Excel</html:link></td>
</td>
</tr>
</table>


<table  width="100%" height="10"  bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><font color="#FFFFFF">Emp Department Opted Report</font></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="16" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;
</td>
</tr>
</table>

<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" width="99%" border=1 style="border-collapse:collapse">
<tr>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT></FONT>
		</td>
		
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector"/>/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode"/></FONT></FONT>
		</td>
		
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empname" /></FONT></FONT><br>
		</td>
		
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.deptOpt" /></FONT></FONT>
		</td>
		
		<td class=mycborder align=center nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.doj1" /></FONT></FONT>
		</td>
		
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" /></FONT><BR>
		</td>
		
		
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" />/</FONT><BR>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.presentdesig" /></FONT>
		</td>
		
		<td  class=mycborder nowrap>
		
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.spouseEmploy" /></FONT><BR>
	</td>
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.apcatog" /></FONT><BR>
		</td>
					
			
		</tr>
		
	
<% int a=1; %>
<logic:notEmpty name="DeptReport">
<logic:iterate id="emplist" name="DeptReport">

<tr>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=a++ %></FONT>
</td>

<td  class=mycborder1 nowrap>
<br><FONT class=myfontclr1><bean:write name="emplist" property="roc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="hoc" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="coc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="doc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="sdoc"/></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="deptopted" /></FONT><br>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="doj" /></FONT>
</td>


<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="qual" /></FONT>
</td>


<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="presentdesig" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="spouseemployd" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="apcatog" /></FONT>
</td>

</tr>

</logic:iterate>
</logic:notEmpty>
<logic:empty name="DeptReport">
<script>
alert("No Employees Under this Selection Criteria");
//document.location.href="./masters/Employee.do?mode=DeptOptForms";
document.location.href="switch.do?prefix=/masters&page=/Employee.do&mode=DeptOptForms";
</script>
</logic:empty>
</table>

<%@ include file="/commons/rws_footer.jsp"%>


