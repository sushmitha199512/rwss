<%@ include file="/commons/rws_user_restriction.jsp" %>
 <%@ include file="/commons/rws_header1.jsp" %>

<script language="JavaScript">
<!--
function autocompletion()
{
      // alert("auto comp");
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
function fnGet()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/PaoAction.do&mode=data";
	document.forms[0].submit();
}
function validateFn()
{
if(document.forms[0].distcode.value == "" || document.forms[0].distcode.value == "00" ||document.forms[0].distcode.value == null)
{
	alert("Select District");
	return false;
}
else if(!document.forms[0].paoapao[0].checked)
{
	if(!document.forms[0].paoapao[1].checked)
	{
		alert("Select PAO/APAO");
		return false;
	}
}
else
{
	return true;
}
}
//-->
</script>

<%@ include file="/commons/rws_header2.jsp" %>
<body onload="autocompletion()">
<html:form action="PaoAction.do">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Pay & Accounts Office Entry Form" />
	<jsp:param name="TWidth" value="560" />
</jsp:include>
	 
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" width="460" border=1 style="border-collapse:collapse;">
<tr>
<td>
	<table  border=0  width="596"  align=center  >
	<tr>
	<td class="mycborder">
	<FONT class=myfontclr><bean:message key="app.district" /><font color="#FF6666">*</font></FONT>
	</td>
	<td>	
	<html:select property="distcode" style="width:180px" styleClass="mycombo" onchange="fnGet()">
	<html:option value="00"><font class="myfontclr1">Select...</html:option>
	<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
	</html:select>
	</TD>
	<%String maxPao = (String)request.getAttribute("maxPao");%>
	<td class="mycborder">
	<FONT class=myfontclr>Choose<font color="#FF6666">*</font></FONT>
	</td>
	<TD class="mycborder">&nbsp;&nbsp;&nbsp;&nbsp;
	<html:radio property="paoapao" value="P"/><FONT class=myfontclr>PAO</FONT>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<html:radio property="paoapao" value="A"/><FONT class=myfontclr>APAO</FONT>
	</TD>
	</TR>
	<tr>
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.paocode" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class="mycborder">	
	<html:text property="paocode"  value="<%=maxPao%>"  styleClass="mytext"  maxlength="4" size="32"  readonly="true"/>
	</TD>
	
	 <td class="mycborder">
	<FONT class=myfontclr>PAO Name<font color="#FF6666"></font></FONT></td>
	<td><html:text property="paoName"  value=""  styleClass="mytext" size="32"  maxlength="20"  onkeypress="return textOnly(event)"/></td>
	
	
	</TR>
	<TR>
		<TD class="mycborder">
	<FONT class=myfontclr>Address1</FONT>
	</TD>
	<TD><html:textarea property="address1"  value=""  /></TD>
	
	<TD class="mycborder">
	<FONT class=myfontclr>Address2</FONT>
	</TD>
	<TD><html:textarea property="address2"  value=""  /></TD>
	</tr>
	<TR>
	<TD class="mycborder">
	<FONT class=myfontclr>Address3</FONT>
	</TD>
	<TD><html:textarea property="address3"  value=""  /></TD>
	
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.city" /><font color="#FF6666"></font></FONT></TD>
	<TD><html:text property="city"  value="" styleClass="mytext"  maxlength="15" size="32" /></TD>
	</TR>
	<TR >
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.pin" /><font color="#FF6666"></font></FONT></TD>
	<TD><html:text property="pin"  value=""  styleClass="mytext" size="32"  maxlength="6" onkeypress="return numeralsOnly(event)"/></TD>
	
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.phone" /></FONT>
	<TD><html:text property="phone"  value="" styleClass="mytext" maxlength="10" size="32" onkeypress="return numeralsOnly(event)"/></TD>
	</tr>
	<TR >
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.email" /><font color="#FF6666"></font></FONT></TD>
	<TD><html:text property="email"  value="" styleClass="mytext" size="32"  maxlength="50"/></TD>
	
	<TD class="mycborder">
	<FONT class=myfontclr><bean:message key="app.fax" /></FONT>
	<TD><html:text property="fax" value=""  styleClass="mytext"  maxlength="10"  size="32"/></TD>
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
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save"  onclick="return validateFn()" /> 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="560"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>