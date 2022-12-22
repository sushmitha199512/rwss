<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%if(request.getParameter("detailedWise")!=null && request.getParameter("detailedWise").equalsIgnoreCase("01"))
			{%>
	
<FONT class=myfontclr><font color="#993366" size="3">Designation Wise </font></FONT>
				<%} %>
			
<%if(request.getParameter("detailedWise")!=null && request.getParameter("detailedWise").equalsIgnoreCase("02"))
			{%>
<FONT class=myfontclr><font color="#993366" size="3">&nbsp;Zone Wise  </font></FONT>
<%} %>

<%if (request.getParameter("sector")!=null && !request.getParameter("sector").equals("0")) {%>
<FONT class=myfontclr><font color="#993366" size="3"> &nbsp;Sector Wise </font></FONT>
<%} %>
<br>
<br>
<table width="95%">
<tr>
<td align="right"><html:link page="/Employee.do?mode=StatusForms">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;&nbsp;|</a>
<html:link page="/rws_EmpStatusEntry_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_EmpStatusEntry_xls.jsp" target="_new">Excel</html:link></td>

</tr>
</table>

<table  width="99%" height="15"  bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><font color="#FFFFFF">Employee Status Report</font></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="16" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;
</td>
</tr>
</table>

<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" width="99%" border=1 style="border-collapse:collapse">
<tr>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector"/>/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode"/></FONT></FONT>
		</td>
		
		<td  class=mycborder>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode"/>/</FONT></FONT><br>
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

		<td  class=mycborder  >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.localzone1" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.zone" /></FONT></FONT>
		</td>
	
		<td  class=mycborder >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" /></FONT><BR>
		</td>
				
		</tr>

<% int a=1; %>
<logic:notEmpty name="empsReport">
<logic:iterate id="emplist" name="empsReport">
<tr>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=a++ %></FONT>
</td>
<td class=mycborder1 nowrap>
<br><FONT class=myfontclr1><bean:write name="emplist" property="roc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="hoc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="coc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="doc" /></FONT><br>
<FONT class=myfontclr1><bean:write name="emplist" property="sdoc" /></FONT><br>

</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT><BR>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="dob" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<br><FONT class=myfontclr1><bean:write name="emplist" property="appointdate" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="doj" /></FONT><BR><br>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="localzone" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="zoneName" /></FONT><BR>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT>
</td>
</tr>
</logic:iterate>
</logic:notEmpty>
<logic:empty name="empsReport">
<script>
alert("Employee(s) Does Not Exist");
document.location.href="./switch.do?prefix=/masters&page=/Employee.do?mode=StatusForms";
</script>
</logic:empty>

</table>
<%@ include file="/commons/rws_footer.jsp"%>


