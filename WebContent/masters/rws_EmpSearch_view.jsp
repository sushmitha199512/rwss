<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%// System.out.println("In view Jsp");%>
<script language="JavaScript">

</script>

<table width="97%">
<tr>

<td align="right">
<a href="javascript:history.go(-1)">Back </a>
</tr>
</table>

<form>
<table  width="100%" height="10"  bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><font color="#FFFFFF">Employee List</font></td>
<td align=right>
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>

<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" width="99%" border=1 style="border-collapse:collapse" CELLPADDING="75">
<tr>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT>
		</FONT>
		</td>
	<%// System.out.println("In view Jsp 1 ");%>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector" />/</FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode1"/></FONT></td>
	<%// System.out.println("In view Jsp 2");%>
		<td  class=mycborder >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode1" /></FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.surname1" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.name1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.gender" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.relation1" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dob1" /></FONT></FONT>
		</td>
			<%// System.out.println("In view Jsp 3 ");%>				
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.ndistrict1" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.nmandal1" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><center><bean:message key="app.nrevenue"/></center></FONT></FONT>
		</td>
		<%// System.out.println("In view Jsp 4");%>
		<td  class=mycborder align=center nowrap>
		<FONT class=myfontclr><font color="#993366">&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="app.zone1"/>&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT>
		</td>

		<td  class=mycborder align=center nowrap>
		<FONT class=myfontclr><font color="#993366">&nbsp;&nbsp;<bean:message key="app.deptOpt" /></FONT></FONT></td>
		<%// System.out.println("In view Jsp 5 ");%>

		<td  class=mycborder  nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" />&nbsp;&nbsp;</FONT></FONT><br> 
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual211" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual12" /></FONT></FONT>
		</td>
			<%// System.out.println("In view Jsp 6 ");%>		
		<td class=mycborder  nowrap>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnCode1" /></FONT></FONT><br>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.tempdesig11" /></FONT></FONT>
		</td>
			<%// System.out.println("In view Jsp 7");%>
		<td  class=mycborder align=center colspan=2>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.otherDet" /></FONT></FONT>
		</td>
	</tr>

<% int a=1; %>
<logic:notEmpty name="emps">
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
<%// System.out.println("In view Jsp 8");%>
<td class=mycborder1>
<BR><FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="surname" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="gender" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="dob" /></FONT><BR>
</td>
<%// System.out.println("In view Jsp 9");%>
<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="ndist" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nmand" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nrevenue" /></FONT>
</td>
<%// System.out.println("In view Jsp 10");%> 
<td class=mycborder1  align="center">
<FONT class=myfontclr1>&nbsp;<bean:write name="emplist" property="zone"/>&nbsp;</FONT>
</td>

<TD class=mycborder1  align="center">
<FONT class=myfontclr1><bean:write name="emplist" property="dept" /></FONT>
</TD>
<%// System.out.println("In view Jsp 11");%>
<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="qualName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual1" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual2" /></FONT>
</td>
<%// System.out.println("In view Jsp 12");%>
<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="desig" /></FONT>
</td>
<%// System.out.println("In view Jsp 13");%>
<td class=mycborder1 colspan=2>
<FONT class=myfontclr1><bean:write name="emplist" property="otherDet" /></FONT>
</td>
</tr>
</logic:iterate>
</logic:notEmpty>
<logic:empty name="emps">
<script>
alert("Employee(s) Does Not Exist");
document.location.href="./switch.do?prefix=/masters&page=/EmpSearch.do&mode=EmployeeList&mode1=init";
</script>
</logic:empty>
</table>
</form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp" %>