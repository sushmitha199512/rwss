<%@ include file="/commons/rws_header1.jsp"%>

<script language="JavaScript">
<!--
function fnCancel(that)
{
	var frm = that.form;
	frm.action = "switch.do?prefix=/proposals&page=/NewAdminProposalData.do";
	frm.submit();
}
function getSubprogrammes(that)
{
	var frm = that.form;
	frm.action = "switch.do?prefix=/proposals&page=/NewAdminProposalEditData.do&mode=subprogrammes"
			   + "&programmeCode="+that.value;
	frm.submit();
}

function addRemoveHabs()
{	
	var proposalId = document.getElementById("proposalId").value;
	var url = "switch.do?prefix=/proposals&page=/AddRemoveConsHabs.do&mode=addRemoveHabs&from=admin"
		    + "&proposalId="+proposalId;
	var properties = "width=548,height=285,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
	newWindow.moveTo(10,10);
}

function enablePhaseNo(phased)
{
	form = phased.form;
	if(form.phased[0].checked)
		document.getElementById("phaseNo").disabled = false;
	else
	if(form.phased[1].checked)
		document.getElementById("phaseNo").disabled = true;
}
//-->
</script>
<html:javascript formName="EditNewAdminProposalForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/EditAdminProposal" method="post" enctype="multipart/form-data"
	  onsubmit="return validateEditNewAdminProposalForm(this)">
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Administrative Sanctions - Edit Form" />
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

<tbody>
<tr>
<td>
<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
<tr>
<td>
<fieldset>
<legend><bean:message key="legend.proposalDetails" /></legend>
<label>
	<table>
	<tbody class="formTBody">
	<tr>
		<td nowrap><bean:message key="app.proposalid" /><span class="mandatory">*</span></td>
		<td><html:text property="proposalId" readonly="true" styleClass="thin-text-box"/></td>
	</tr>
	<tr>
		<td nowrap><bean:message key="app.workname" /><span class="mandatory">*</span></td>
		<td colspan="3">
			<html:text property="proposalName" styleClass="thin-text-box" size="74" 
					   onkeypress="return textOnly()"/>
		</td>
	</tr>
	<tr>
		<td nowrap><bean:message key="app.programme" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="programmeCode" styleClass="combo" onchange="javascript:getSubprogrammes(this)">
				<html:option value="">SELECT...</html:option>
				<html:options collection="programmes" name="labelValueBean" 
					property="value" labelProperty="label"/>
			</html:select>
		</td>
		<td nowrap><bean:message key="app.subprogramme" /></td>
		<td>
			<html:select property="subprogrammeCode" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<html:options collection="subprogrammes" name="labelValueBean" 
					property="value" labelProperty="label"/>
			</html:select>
		</td>
	</tr>
	<tr>
		<td nowrap><bean:message key="app.scheme" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="typeOfAsset" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<html:options collection="assetTypes" name="labelValueBean" 
					property="value" labelProperty="label"/>
			</html:select>
		</td>
		<td nowrap><bean:message key="app.priority" /></td>
		<td>
			<html:select property="priorityCode" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<html:options collection="priorities" name="labelValueBean" 
					property="value" labelProperty="label"/>
			</html:select>
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.estimatecost" /><span class="mandatory">*</span></td>
		<td>
			<html:text property="estimateCost" styleClass="thin-text-box" onkeypress="return decimalsOnly(event)"/>
		</td>
		<td nowrap><bean:message key="app.sanctionedAmount" /><span class="mandatory">*</span></td>
		<td>
			<html:text property="sanctionedAmount"  styleClass="thin-text-box" onkeypress="return decimalsOnly(event)" />
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.centralShare" /></td>
		<td><html:text property="centralShare" styleClass="thin-text-box" /></td>
		<td><bean:message key="app.stateShare" /> </td>
		<td><html:text property="stateShare" styleClass="thin-text-box" /></td>
	</tr>
	<tr>
		<td><bean:message key="app.gpShare" /></td>
		<td><html:text property="gpShare" styleClass="thin-text-box" /></td>
		<td><bean:message key="app.publicContribution" /></td>
		<td><html:text property="publicContribution" styleClass="thin-text-box" /></td>
	</tr>
	<tr>
		<td><bean:message key="app.others" /></td>
		<td><html:text property="others" styleClass="thin-text-box" /></td>
	</tr>
	<tr>
		<td><bean:message key="app.phased" /></td>
		<td>
			<html:radio property="phased" value="Y" onclick="javascript: enablePhaseNo(this)"/>Yes
			<html:radio property="phased" value="N" onclick="javascript: enablePhaseNo(this)"/>No
		</td>
		<td><bean:message key="app.phaseNo" /></td>
		<td><html:text property="phaseNo" styleClass="thin-text-box" disabled="true"/></td>
	</tr>
	
	<tr>
		<td class="myfontclr">Line Estimate</td>
		<td colspan="3">
			<html:file property="lineEstimate" size="30" styleClass="thin-text-box"/>
		</td>
	</tr>
	</tbody>
	</table>
</label>
</fieldset>
</td>
</tr>
<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.habitationDetails" /></legend>
	<label>
	<table id="proTable" border="1" bordercolor="#000000" width="600" style="border-collapse:collapse">
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
		<th><bean:message key="app.habitationCode" /></th>
		<th><bean:message key="app.habitationName" /></th>
		<th><bean:message key="app.population" /></th>
		<th><bean:message key="app.status" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:forEach items="${sessionScope.habs}" var="item" varStatus="status">	
	<c:set var="index" value="${status.index}" />
	<tr class="<c:out value='row${index%2}'/>" id="<c:out value='row${index}'/>">
		<td align="center" align="center">
			<c:out value="${item.habCode}" />
			<input type="hidden" name="habcodes" value="<c:out value='${item.habCode}'/>">
		</td>
		<td><c:out value="${item.habName}" /></td>
		<td align="right"><fmt:formatNumber minFractionDigits="0" value="${item.population}" /></td>
		<td><c:out value="${item.status}" /></td>

	</tr>
	</c:forEach>
	<input type="hidden" name="noOfWorks" value="<c:out value='${index+1}'/>">
	</tbody>
	<tfoot class="gridLabel">
		<tr bgcolor="#8A9FCD">
			<th align="left" colspan="7">
				Total No. of Selected habitations:&nbsp;<c:out value='${index+1}'/>
			</th>
		</tr>
		<c:set var="officeType" value="${sessionScope.RWS_USER.officeName}" />
		<c:if test="${officeType == 'Sub Division Office'|| officeType == 'Head Office' || officeType == 'Circle Office'}">
		<tr>
			<td align="left" colspan="7">
				<c:if test="${RWS_USER.headOfOffice == 'true'}">
				<html:button property="mode" style="width: 150px" styleClass="btext" 
							 onclick="javascript: addRemoveHabs()">
					<bean:message key="button.addRemoveHabs" />
				</html:button>
				</c:if>
				<c:if test="${RWS_USER.headOfOffice == 'false'}">
				<html:button property="mode" style="width: 150px" styleClass="btext" disabled="true"
							 onclick="javascript: addRemoveHabs()">
					<bean:message key="button.addRemoveHabs" />
				</html:button>
				</c:if>
			</td>
		</tr>
		</c:if>
	</tfoot>
	</table>
	<html:hidden property="noOfHabs"/>
	</label>
	</fieldset>
</td>
</tr>

<tr>
<td align="center">
	<html:submit property="mode" styleClass="btext">
		<bean:message key="button.save" />
	</html:submit>
	<html:reset styleClass="btext">
		<bean:message key="button.clear" />
	</html:reset>
	<html:button property="mode" styleClass="btext" onclick="javascript: fnCancel(this)">
		<bean:message key="button.cancel" />
	</html:button>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
</html:form>
<script language="JavaScript">
<!--
	frm = document.forms[0];
	if(frm.phased[0].checked)
		document.getElementById("phaseNo").disabled = false;
	else
	if(frm.phased[1].checked)
		document.getElementById("phaseNo").disabled = true;
//-->
</script>
</body>
</html>