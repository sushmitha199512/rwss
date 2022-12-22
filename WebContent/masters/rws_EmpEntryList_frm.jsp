<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="JavaScript">

function insertRecord()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=data";
	document.forms[0].submit();
}

//added by swapna  on 14-07-2011
function openDeleteWindow(url) {
	var width = 1;
	var height = 1;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
		 
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
function openEditWindow(url) {
	var width = 850;
	var height = 550;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
		 
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
</script>

<table width="97%">
<tr>
<td align="right">
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_EmpEntry_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_EmpEntry_xls.jsp" target="_new">Excel</html:link></td>
</tr>
<tr>
<td align="right">
<html:link page="/Employee.do?mode=data">Back To InsertEmp&nbsp;</html:link>

</tr>
</table>

<html:form action="/Employee.do?mode=data" >
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
	
		<td  class=mycborder >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode1" /></FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.surname1" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.name1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.gender" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.relation1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dob1" /></FONT></FONT>
		</td>
							
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.ndistrict1" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.nmandal1" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><center><bean:message key="app.nrevenue"/></center></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center nowrap>
		<FONT class=myfontclr><font color="#993366">&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="app.zone1"/>&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT>
		</td>

		<td  class=mycborder align=center nowrap>
		<FONT class=myfontclr><font color="#993366">&nbsp;&nbsp;<bean:message key="app.deptOpt" /></FONT></FONT></td>
		

		<td  class=mycborder  nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" />&nbsp;&nbsp;</FONT></FONT><br> 
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual211" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual12" /></FONT></FONT>
		</td>
					
		<td class=mycborder  nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnCode1" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.tempdesig11" /></FONT></FONT>
		</td>
			
		<td  class=mycborder align=center colspan=2>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.otherDet" /></FONT></FONT>
		</td>
	
		<td  class=mycborder align=center colspan=2 nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></FONT>
		</td>
		</tr>

<% int a=1; %>
<logic:iterate id="emplist" name="emps">

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

<td class=mycborder1>
<BR><FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="surname" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="gender" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="dob" /></FONT><BR>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="ndist" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nmand" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nrevenue" /></FONT>
</td>

<td class=mycborder1  align="center">
<FONT class=myfontclr1>&nbsp;<bean:write name="emplist" property="zone"/>&nbsp;</FONT>
</td>

<TD class=mycborder1  align="center">
<FONT class=myfontclr1><bean:write name="emplist" property="dept" /></FONT>
</TD>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="qualName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual1" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual2" /></FONT>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="desig" /></FONT>
</td>

<td class=mycborder1 colspan=2>
<FONT class=myfontclr1><bean:write name="emplist" property="otherDet" /></FONT>
</td>

<!-- <td  class=mycborder1 align=center colspan=2 nowrap>
<a href="./masters/Employee.do?empcode=<bean:write name='emplist' property='empcode'/>&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;
 <a href="#1" onclick="fnDelete('<bean:write name='emplist' property='empcode'/>')" style="color:blue"><font color="#990066">Delete</font></a>
</td> -->
<td nowrap>
<%-- <a href="./switch.do?prefix=/masters&page=/Employee.do?mode=get&empcode=<bean:write name='emplist' property='empcode'/> " style="color:blue">Edit&nbsp;</a> --%>
 <a href="#1" onclick=openEditWindow('./switch.do?prefix=/masters&page=/Employee.do?mode=get&empcode=<bean:write name='emplist' property='empcode'/>')>
<font color="#6600CC"><b>Edit</b></font></a> &nbsp;|&nbsp;
<a href="#1" onclick=openDeleteWindow('./switch.do?prefix=/masters&page=/Employee.do?empcode=<bean:write name='emplist' property='empcode'/>&mode=delete')><font color="#990066" ><b>Delete</b></font></a>

</td>
</tr>
</logic:iterate>
</table>

<table width="99%">
<tr>
    <td colspan="2" align="right">
    <html:submit property="mode" value="Insert New Record" styleClass="btext"/>
  	</td>
	</tr>
	
</table>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp" %>


