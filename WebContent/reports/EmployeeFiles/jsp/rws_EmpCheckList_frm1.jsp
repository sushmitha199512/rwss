<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table widht=500>
<tr>
<td align="right">
<html:link page="/Employee.do?mode=checklist">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_EmpCheckList_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_EmpEntry_xls.jsp" target="_new">Excel</html:link></td>

</tr>
</table>

<table  width="99%" height="15"  bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><font color="#FFFFFF">Employee Form</font></td>
<td align=right>
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="99%" border=1 style="border-collapse:collapse" CELLPADDING="75">
<tr>
		<td class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT></FONT>
		</td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector" />/</FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode1"/></FONT></td>
		
		<td  class=mycborder   >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.surname" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.name1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.social1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.relation" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.gender" />./</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.religion" />./</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dob" />.</FONT></FONT>
		</td>
		

		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.ndistrict" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.nmandal" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.nrevenue"/></FONT></FONT>
		</td>
		
		<td  class=mycborder >
		<FONT class=myfontclr><font color="#993366">&nbsp;<bean:message key="app.zone" />.</FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual21" /></FONT></FONT>
		</td>
					
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnName" /></FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnType" />./</FONT></FONT>
		
		</td>

		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.seniority" /></FONT></FONT>
		</td>
	
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.workSpecial" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.otherDet" /></FONT></FONT>
		</td>
		
	</tr>
	
<%if(session.getAttribute("emps")!=null && ((java.util.ArrayList)session.getAttribute("emps")).size()!=0)
{ %>

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
<FONT class=myfontclr1><bean:write name="emplist" property="sdoc"/></FONT>
</td>

<td  class=mycborder1  align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="surname" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="social" /></FONT>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="gender" /></FONT>,&nbsp;
<FONT class=myfontclr1><bean:write name="emplist" property="religion" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="dob" /></FONT><BR>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="ndist" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nmand" /></FONT><BR><br>
<FONT class=myfontclr1><bean:write name="emplist" property="nrevenue" /></FONT>
</td>

<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="emplist" property="zone" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="qualName" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual2" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="desig" /></FONT><BR><BR>

</td>
		
<TD class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="seniority" /></FONT>
</TD>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="workSpecial" /></FONT><BR>
</td>


<td  class=mycborder1  align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="otherDet" /></FONT>
</td>
</tr>
</logic:iterate>

<%} 
else{%>
<tr><td align="center" colspan="20"><b>No Records</b></td></tr>
<%}%>
</table>

<%@ include file="/commons/rws_footer.jsp"%>


