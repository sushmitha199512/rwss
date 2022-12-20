<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>

<html:form action="Tslimit">
<table cellpadding="0" cellspacing="0" border="0">
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Technical Sanction Monetary Limit" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
</tr>
</thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>
    <table width="100%" bgcolor="#DEE3E0" border="1" bordercolor="#000000" style="border-collapse:collapse" 
	class="userDetails" cellpadding="0" cellspacing="0" align="center">
	<thead>
	<tr>
		<th>Office</th>
		<th>Designation</th>
		<th>Lower Limit</th>
		<th>Upper Limit</th>
	</tr>
	</thead>
	<tbody bgcolor="#ffffff">
	<tr>
		<td>
			<html:text property="office1" styleClass="gridText" readonly="true"/>
			
		</td>
		<td>
			
			<html:text property="designation1" styleClass="gridText" readonly="true"/>
			

		</td>
		<td><html:text property="lowerLimit1" styleClass="gridText" readonly="true" /></td>
		<td><html:text property="upperLimit1" styleClass="gridText" /></td>
	</tr>
	<tr>
		<td>
			
			<html:text property="office2" styleClass="gridText" readonly="true"/>
			
		</td>
		<td>
			
			<html:text property="designation2" styleClass="gridText" readonly="true"/>
		</td>
		<td>
			<html:text property="lowerLimit2" styleClass="gridText" readonly="true"/>
		</td>
		<td>
			<html:text property="upperLimit2" styleClass="gridText" />
		</td>
	</tr>
	<tr>
		<td> 
			
			<html:text property="office3" styleClass="gridText" readonly="true"/>
			
			
			
		</td>
		<td>
			
			<html:text property="designation3" styleClass="gridText" readonly="true"/>
		</td>
		<td><html:text property="lowerLimit3" styleClass="gridText" readonly="true" /></td>
		<td><html:text property="upperLimit3" styleClass="gridText" /></td>
	</tr>
	<tr>
		<td>
			
			<html:text property="office4" styleClass="gridText" readonly="true"/>
		</td>
		<td>
			
			<html:text property="designation4" styleClass="gridText" readonly="true"/>
		</td>
		<td><html:text property="lowerLimit4" styleClass="gridText" readonly="true" /></td>
		<td><html:text property="upperLimit4" styleClass="gridText" /></td>
	</tr>
	<tr>
		<td>
			
			<html:text property="office5" styleClass="gridText" readonly="true"/>
		</td>
		<td>
			
			<html:text property="designation5" styleClass="gridText" readonly="true"/>
		</td>
		<td><html:text property="lowerLimit5" styleClass="gridText" readonly="true" /></td>
		<td><html:text property="upperLimit5" styleClass="gridText" value=""/></td>
	</tr>
	</tbody>
	<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

	<tr>
	<td colspan="4" align="center">
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Update"/> 
					<!-- onclick="return validateContamForm(tslimitForm)" />      -->
	</td>
	</tr>
</table>


</td>
</tr>
</tbody>
</table>
</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>