<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>


<table width="75%">
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
<!-- <FONT class=myfontclr><font color="#993366"><bean:message key="app.spouseEmploy" />/</FONT><BR>-->
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
<!-- <FONT class=myfontclr1><bean:write name="emplist" property="spouseemployd" /></FONT><BR>-->
<FONT class=myfontclr1><bean:write name="emplist" property="spouseworking" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="apcatog" /></FONT><BR>
</td>


</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>


