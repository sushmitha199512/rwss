<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<script type="text/javascript">
function autocompletion()
{     
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
</script>
<html:javascript formName="majorHeadForm" />

<body onload="autocompletion()">
<html:form action="/MajorHead.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Major Head Account Entry Form" />
	<jsp:param name="TWidth" value="325" />
</jsp:include>


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="365" >
<tr>
<td>
	<table  border=0  width="350"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
			<td  class="textborder" >
				Major Head Code<font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:text property="majorHeadCode" value="" style="width:60px" styleClass="mytext" maxlength="4"  onkeypress="return numeralsOnly(event)"/>
			</td>
		</tr>
		
		<tr>
			<td  class="textborder" >
				Major Head Name<font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:text property="majorHeadName" value=""  style="width:200px" styleClass="mytext" onkeypress="return textOnly(event)"/>
			</td>
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
			 <html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save"  onclick=" return validateMajorHeadForm(majorHeadForm)" />
		 	 <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
			 <html:submit property="mode" title="view the Fields" styleClass="btext" value="View"  />
		 
		</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="325"/>
</jsp:include>

</html:form>

</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>