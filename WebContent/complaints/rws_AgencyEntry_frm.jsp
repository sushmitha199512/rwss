<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="agencyForm" />


<html:form action="/Agency.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Agency Entry Form" />
	<jsp:param name="TWidth" value="325" />
</jsp:include>


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="365" >
<tr>
<td>
	<table  border=0  width="350"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
			<td  class="textborder" >
				Agency Code<font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:text property="agencyCode" value="" style="width:60px" styleClass="mytext" maxlength="4" />
			</td>
		</tr>
		
		<tr>
			<td  class="textborder" >
				Agency Name<font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:text property="agencyName" value=""  style="width:200px" styleClass="mytext"/>
			</td>
		</tr>
		
		</table>

	<tr>
		<td colspan="2" align="center">
			 <html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save"  onclick=" return validateAgencyForm(AgencyForm)" />
		 	 <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
			 <html:submit property="mode" title="view the Fields" styleClass="btext" value="View"  />
		 
		</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="325"/>
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>