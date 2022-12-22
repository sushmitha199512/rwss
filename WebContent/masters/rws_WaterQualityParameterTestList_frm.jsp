<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
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

<table width=700>
<tr><td align=right><html:link page="/WaterPTest.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_WQParameterTestMaster_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_WQParameterTestMaster_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table width="700" bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Water Quality Parameter Test Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="700" border=1 style="border-collapse:collapse" >
<tr>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.testCode" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Parameter Code</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Parameter Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Min Per Val</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Max Per Val</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Undesirable Effect Outside the Desirable Limit</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
	</td>
	</tr>
<c:set var="waterptestlistExists" value="false" />
<logic:iterate id="waterptestlist" name="waterptests">
<c:set var="waterptestlistExists" value="true" />
<tr align="left" >
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="testName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="waterptestlist" property="testPCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="testPName" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="minPerVal" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="maxPerVal" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="undesirableEffect" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>

<a href="#1" onclick=openEditWindow('./WaterPTest.do?testPCode=<bean:write name='waterptestlist' property='testPCode' />&testCode=<bean:write name='waterptestlist' property='testCode' />&mode=get')>
<font color="#6600CC"><b>Edit</b></font></a>&nbsp;|&nbsp;
<a href="#1" onclick=openDeleteWindow('./WaterPTest.do?testPCode=<bean:write name='waterptestlist' property='testPCode' />&testCode=<bean:write name='waterptestlist' property='testCode' />&mode=delete')><font color="#990066" ><b>Delete</b></font></a>

</td>
</tr>
</logic:iterate>
<c:if test="${waterptestlistExists=='false'}">
<tr><td  class=mycborder1 colspan="7" align=center nowrap><font size="2pt"> No Records</font></td></tr>
</c:if>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

