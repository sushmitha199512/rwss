<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="qualForm" />
<script language="javascript">
function autocompletion()
{
      // alert("auto comp");
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}

function textOnly(evt)
{
	alpha(event)
	evt = (evt) ? evt : event;
	var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
	if (charCode > 31 && (charCode < 48 || charCode > 57) && (charCode < 65 || charCode > 90) &&
		(charCode < 97 || charCode > 122) && charCode == 46	&& charCode == 32 && charCode == 44 && 
		 charCode == 45 && charCode == 40 && charCode == 41 && charCode == 58 && charCode == 59 &&
		 charCode == 91 && charCode == 93 && charCode == 92 && charCode == 47){
		alert("Other Charaters are not allowed");      
        return false;
    }
	upperOnly();
}

//-->
</script>
<%@ include file="/commons/rws_header2.jsp" %>
<body onload="autocompletion()">
<html:form action="Qual.do?mode=edit" onsubmit="return winView()">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Qualification Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="340" >
<tr>
<td>
	<table  border=0  width="270"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.qualCode" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="qualCode"  styleClass="mytext" maxlength="2" readonly="true" />
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.qualName" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="qualName" styleClass="mytext" maxlength="10" onkeypress="return textOnly(event);"/>
		</td>
		</tr>
		</table>
</td>
</tr>
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Update" onclick="return validateQualForm(qualForm)"  />
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	</td>
</tr>

</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
