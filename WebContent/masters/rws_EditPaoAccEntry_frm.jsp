 <%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_user_restriction.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<script language="JavaScript">
function autocompletion()
{
      // alert("auto comp");
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
function fnSave()
{
	if (confirm("Do you want save the record?"))
	{
		document.forms[0].action="switch.do?prefix=/masters&page=/PaoAction.do&mode=edit";
		document.forms[0].submit();
	}
}
</script>
 <body onload="autocompletion()">
<html:form action="/PaoAction">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Pay and Office Entry Form" />
	<jsp:param name="TWidth" value="560" />
</jsp:include>
	 
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" width="460" border=1 style="border-collapse:collapse;">
<tr>
<td>
	<table  border=0  width="596"  align=center  >
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr><bean:message key="app.distcode" /><font color="#FF6666">*</font></FONT>
	</td>
	<td>	
	<html:text property="distcode"  styleClass="mytext" maxlength="2" size="32" readonly="true" />
	</TD>
		<td class="mycborder">
	<FONT class=myfontclr>Choose<font color="#FF6666">*</font></FONT>
	</td>
	<TD class="mycborder">&nbsp;&nbsp;&nbsp;&nbsp;
	<html:radio property="paoapao" value="P"/><FONT class=myfontclr>PAO</FONT>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<html:radio property="paoapao" value="A"/><FONT class=myfontclr>APAO</FONT>
	</TD>
	</TR>
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.paocode" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class="mycborder">	
	<html:text property="paocode"  styleClass="mytext" maxlength="4" size="32" readonly="true"/>
	</TD>
	<TD class="mycborder">
	<FONT class=myfontclr>PAO Name<font color="#FF6666"></font></FONT>
	</td>
	<td class="mycborder">	
	<html:text property="paoName"  styleClass="mytext" size="32" onkeypress="return textOnly(event)"/>
	</TD>
	 </TR>
	 <tr>
	 <TD class="mycborder">
	<FONT class=myfontclr>Address1<font color="#FF6666"></font></FONT>
	</TD>
	<TD><html:textarea property="address1"/></TD>
	
	<td class="mycborder">
	<FONT class=myfontclr>Address2<font color="#FF6666"></font></FONT></td>
	<td><html:textarea property="address2"/></td>
	 </tr>
	 
	<TR>
	<td class="mycborder">
	<FONT class=myfontclr>Address3<font color="#FF6666"></font></FONT></td>
	<td><html:textarea property="address3"/></td>
	
	<td class="mycborder">
	<FONT class=myfontclr><bean:message key="app.city" /><font color="#FF6666"></font></FONT></td>
	<td><html:text property="city"  styleClass="mytext" size="32" /></td>
	
	</tr>
	<TR>

	<td class="mycborder">
	<FONT class=myfontclr><bean:message key="app.pin" /><font color="#FF6666"></font></FONT></td>
	<td><html:text property="pin"  styleClass="mytext" size="32" maxlength="6" onkeypress="return numeralsOnly(event)"/></td>

		<td class="mycborder">
	<FONT class=myfontclr><bean:message key="app.phone" /><font color="#FF6666"></font></FONT></td>
	<td><html:text property="phone"  styleClass="mytext" size="32" maxlength="10"  onkeypress="return numeralsOnly(event)"/></td>
	</TR>
	<TR >
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.email" /><font color="#FF6666"></font></FONT></TD>
	<TD><html:text property="email"  styleClass="mytext" size="32" maxlength="50"/></TD>
	
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.fax" /><font color="#FF6666"></font></FONT>
	<TD><html:text property="fax"  styleClass="mytext" size="32" maxlength="10" /></TD>
	</tr>
	</table>
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
	<tr>
	<td colspan="2" align="center">
		 <html:button property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="fnSave()"/> 
	     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="560"/>
</jsp:include>

</html:form>
</body>
</td>
</tr>
<%@ include file="/commons/rws_alert.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>


