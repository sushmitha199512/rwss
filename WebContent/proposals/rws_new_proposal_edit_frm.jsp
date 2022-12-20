<%@ include file="/commons/rws_header1.jsp"%>

<script language="JavaScript">
<!--
function addRemoveHabs()
{	
	var proposalId = document.getElementById("proposalId").value;
	var url = "switch.do?prefix=/proposals&page=/AddRemoveConsHabs.do&mode=addRemoveHabs&from=cons"
		    + "&proposalId="+proposalId;
	var properties = "width=548,height=285,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
	newWindow.moveTo(10,10);
}

function getSubprogrammes(that)
{
	var frm = that.form;
	frm.action = "switch.do?prefix=/proposals&page=/NewProposalEditData.do&mode=subprogrammes&programmeCode="+that.value;
	frm.submit();
}
function fnCancel(that)
{
	var frm = that.form;
	var url = "switch.do?prefix=/proposals&page=/NewProposalData.do";
	frm.action = url;
	frm.submit();
}

//-->
</script>
<html:javascript formName="EditNewProposalForm" />
<%@ include file="/commons/rws_header2.jsp"%>

<html:form action="/EditNewProposal" method="post" enctype="multipart/form-data" 
		   onsubmit="return validateEditNewProposalForm(this)">
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="New Proposals - Edit Form" />
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
	<table cellpadding="2">
	<tbody class="formTBody">
	<tr>
		<td><bean:message key="app.proposalid" /><span class="mandatory">*</span></td>
		<td><html:text property="proposalId" readonly="true" styleClass="thin-text-box"/></td>
	</tr>
	<tr>
		<td><bean:message key="app.workname" /><span class="mandatory">*</span></td>
		<td colspan="3">
			<html:text property="proposalName" styleClass="thin-text-box" size="75"
					   onkeypress="return textOnly()"/>
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.programme" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="programmeCode" onchange="javascript: getSubprogrammes(this)"
						 styleClass="combo">
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<html:options collection="programmes" name="labelValueBean" 
					property="value" labelProperty="label"/>
			</html:select>
		</td>
		<td><bean:message key="app.subprogramme" /></td>
		<td>
			<html:select property="subprogrammeCode" styleClass="combo">
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<html:options collection="subprogrammes" name="labelValueBean" 
					property="value" labelProperty="label"/>
			</html:select>
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.typeOfAsset" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="typeOfAsset" styleClass="combo">
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<html:options collection="assetTypes" name="labelValueBean" 
					property="value" labelProperty="label"/>
			</html:select>
		</td>
		<td><bean:message key="app.priority" /></td>
		<td>
			<html:select property="priorityCode" styleClass="combo">
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
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
		
		<!--  code added by santosh        -->
		<td><bean:message key="app.sanctioningLevel" /><span class="mandatory">*</span></td>
		<td>
			<html:select  property="sanctionLevel" styleClass="thin-text-box">
			<html:option value="HO">HEAD OFFICE</html:option>
			<html:option value="CO">CIRCLE OFFICE</html:option>
			</html:select>
			
		</td>
		<!--  end of code added by santosh -->
	</tr>
	<tr>
		<td><bean:message key="app.lineEstimate"/></td>
		<td colspan="3">
			<html:file property="lineEstimate" styleClass="thin-text-box"/>
			<c:set var="lineEstimatePath" value="${EditNewProposalForm.lineEstimatePath}"/>
			<c:if test="${not empty EditNewProposalForm.lineEstimatePath }">
				<c:out value='<a href="${lineEstimatePath}" target="_new">Show Uploaded File</a>' 
					   escapeXml="false"/>
			</c:if>
		</td>
	</tr>
	</tbody>
	</table>
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
		<html:button property="mode" styleClass="btext" onclick="fnCancel(this)">
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
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />