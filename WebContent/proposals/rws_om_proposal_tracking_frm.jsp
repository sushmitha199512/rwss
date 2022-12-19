<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--
function getProposalIds(that)
{
	var url = "switch.do?prefix=/proposals&page=/OMProposalTrackingData.do&financialYear=" + that.value;
	form = that.form;
	form.action = url;
	form.submit();
}
//-->
</script>
<html:javascript formName="OMTrackProposalForm" />

<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/OMProposalTracking" onsubmit="return validateOMTrackProposalForm(this)">

<table align="center" cellpadding="0" cellspacing="0">
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="O&M Proposal Tracking" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
</tr>
</thead>

<tfoot summary="Page footer with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>
<tbody summary="Page body">
<tr>
<td>
	<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" cellspacing="2" cellpadding="2"
		   rules="none" style="border-collapse:collapse" class="formTBody">
	<tr>
		<td>
			<bean:message key="app.financialYear" /><span class="mandatory">*</span>
		</td>
		<td>
			<html:select property="financialYear" onchange="javascript: getProposalIds(this)" 		
						 styleClass="combo">
				<html:option value="">SELECT...</html:option>		 
				<html:options collection="financialYears" name="labelValueBean" 
					property="value" labelProperty="label" />
			</html:select>
		</td>
	</tr>
	<logic:present name="proposalIds">
	<tr>
		<td>
			<bean:message key="app.proposalId" /><span class="mandatory">*</span>
		</td>
		<td>
			<html:select property="proposalId" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<html:options collection="proposalIds" name="labelValueBean" 
					property="value" labelProperty="label" />
			</html:select>
		</td>
	</tr>
	</logic:present>
	<logic:notPresent name="proposalIds">
	<tr>
		<td><bean:message key="app.proposalId" /><span class="mandatory">*</span></td>
		<td>
			<html:text property="proposalId" onkeypress="javascript: upperOnly()" 
					   styleClass="thin-text-box" />
		</td>
	</tr>
	</logic:notPresent>
	<tr>
		<td colspan="2" align="center">
			<html:submit styleClass="btext">Submit</html:submit>
		</td>
	</tr>
	</table>
</td>
</tr>
</tbody>

</table>
</html:form>

</body>
</html>