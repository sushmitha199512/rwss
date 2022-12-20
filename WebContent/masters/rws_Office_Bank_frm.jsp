<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<script language="javaScript">
function getBranchcode()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/office.do?mode=branch";
	document.forms[0].submit();
}

function getDivisioncode()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/office.do?mode=division";
	document.forms[0].submit();
}
</script>
<script language="javascript">
function validate()
{
	var len=document.forms[0].accNo.value;
	if(document.forms[0].circleCode.value=='0')
	{
		alert("please Select CircleCode");
		return false;
	}	
	else if(document.forms[0].divisionCode.value=='0')
	{
		alert("please Select DivisionCode");
		return false;
	}	
	
else if(document.forms[0].bankCode.value=='')
	{
		alert("please Select Bank Code");
		return false;
	}
	 else if(document.forms[0].branchCode.value=='')
	{
		alert("please Select Branch code");
				return false;
	}
	else  if(document.forms[0].accNo.value=='')
	{
		alert("please Enter Account No");
				return false;
	}
	else if(len.length!=15)
	{
		alert("Account Number must be 15 Digits");
		document.forms[0].accNo.value="";
		return false;
	}
	
	else
		{
		
	document.forms[0].action="switch.do?prefix=/masters&page=/office.do?mode=save";
	document.forms[0].submit();
}
}
</script>
<html:form action="office.do" >
	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
			<tr align="right">
<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>
			
			</tr>  
		</table>
	</caption>

</table>

<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Account Information  Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >

<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Bank:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	
	<html:select property="bankCode" styleClass="mycombo" style="width:123px" >
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="bankcode">
	<html:options collection="bankcode" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Circle:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	
	<html:select property="circleCode" styleClass="mycombo" style="width:123px" onchange="javascript:getDivisioncode()">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="circlecode">
	<html:options collection="circlecode" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Division:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	
	<html:select property="divisionCode" styleClass="mycombo" style="width:123px" onchange="javascript:getBranchcode()" >
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="divisioncode">
	<html:options collection="divisioncode" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</td>
	</tr>
	
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Branch:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:select property="branchCode" styleClass="mycombo" style="width:123px">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="branchcode">
	<html:options collection="branchcode" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Account No:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="accNo"  styleClass="mytext" maxlength="15" onkeypress="return numeralsOnly()"/>
	</td>
	</tr>
</table>

<tr>
	<td colspan="2" align="center">
	<html:button property="mode" title="Save the Fields" styleClass="btext" value="save" onclick="return validate()"/> 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

