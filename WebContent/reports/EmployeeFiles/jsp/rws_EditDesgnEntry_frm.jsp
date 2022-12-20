<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="desgnForm" />
<script language="javascript">
<!--

function textOnly(evt)
{
	alpha(event)
	evt = (evt) ? evt : event;
	var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
	if (charCode > 31 && (charCode < 48 || charCode > 57) && (charCode < 65 || charCode > 90) &&
		(charCode < 97 || charCode > 122) && charCode == 46	&& charCode == 32 && charCode == 44 && 
		 charCode == 45 && charCode == 40 && charCode == 41 && charCode == 58 && charCode == 59 &&
		 charCode == 91 && charCode == 93 && charCode == 92 && charCode == 47)
	{
		alert("Other Charaters are not allowed");      
        return false;
    }
	upperOnly();
}

//-->
</script>

<%@ include file="/commons/rws_header2.jsp" %>
 <html:form action="Desgn.do" onsubmit="return winView()">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Designation Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.desgnCode" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="desgnCode"  styleClass="mytext" maxlength="2" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.desgnAcr" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="desgnAcr"  styleClass="mytext" maxlength="10" onkeypress="return textOnly(event);"/>
		</td>
		</tr>
		
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.desgnName" /><font color="#FF6666">*</font></FONT></td>
		<td  class=mycborder >
		<html:text property="desgnName"  styleClass="mytext" maxlength="30" onkeypress="return textOnly(event);"/>
		</td>
		</tr>
		<tr>
		<td class=mycborder>
		<FONT class=myfontclr><bean:message key="app.desgnType" /><font color="#FF6666">*</FONT></FONT></td>
		<td class=mycborder><html:select property="desgnType" style="width:130px" styleClass="mycombo">
			<html:option value="">Select..</html:option>
			<html:option value="T">Temporary</html:option>
			<html:option value="P">Permanent</html:option>
		</html:select>
		</td>
		
		</tr>
		</table>
</td>
</tr>
	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Update" onclick="return validateDesgnForm(desgnForm)" />
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 
	</td>
</tr>

</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

