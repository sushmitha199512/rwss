<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table widht=500>
<tr>
<td align="right">
<html:link page="/Employee.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_EmpEntry_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_EmpEntry_xls.jsp" target="_new">Excel</html:link>
</td>
</tr>
</table>

<table  width="100%" height="10"  bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><font color="#FFFFFF">Employee Form</font></td>
<td align=right>
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>

<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" width="99%" border=1 style="border-collapse:collapse" CELLPADDING="75">
<tr>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT>
		</FONT>
		</td>
	
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector" />/</FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode1"/></FONT></td>
	
		<td  class=mycborder   >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.surname" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.name1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.relation" />/</FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.gender" />./</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dob" />.</FONT></FONT>
		</td>
			
					
		<td  class=mycborder >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.ndistrict" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.nmandal" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><center><bean:message key="app.nrevenue"/>.</center></FONT></FONT>
		</td>
		
		<td  class=mycborder >
		<FONT class=myfontclr><font color="#993366">&nbsp;<bean:message key="app.zone1" />.</FONT></FONT>
		</td>

		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.deptOpt" /></FONT></FONT>
		</td>
		

		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual21" /></FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual12" /></FONT></FONT>
		</td>
					
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnCode" />./</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.tempdesig1" /></FONT></FONT>
		</td>

		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.seniority" /></FONT></FONT>
		</td>
		
				
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.workSpecial" /></FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.section" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.otherDet" /></FONT></FONT>
		</td>
	
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></FONT>
		</td>
		</tr>

<% int a=1; %>
<logic:iterate id="emplist" name="emps">

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

<td  class=mycborder1 align=center >
<BR><FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="surname" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="gender" /></FONT><BR><BR>
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

<TD class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="dept" /></FONT>
</TD>

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

<td  class=mycborder1 nowrap align=center colspan=2>
<a href="./Employee.do?empcode=<bean:write name='emplist' property='empcode' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;
<a href="./Employee.do?empcode=<bean:write name='emplist' property='empcode' />&mode=delete" ><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp" %>


