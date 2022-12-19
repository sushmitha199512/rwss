<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="workSpecialForm" />

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

<html:form action="WorkSpecial.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Work Specialzation Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Skill Code:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="workSpecCode" value="<%=(String)request.getAttribute(\"code\")%>" styleClass="mytext" readonly="true" />
	</td></tr>
	<tr >
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.workSpecName" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="workSpecName"  styleClass="mytext" />
	</td>
	</tr>
</table>

<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save"  onclick="return validateWorkSpecialForm(workSpecialForm)"/>
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View List of Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>