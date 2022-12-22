<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--

function fnShowHideSubmit(elem, id)
{	
	var msg = "Please select atleast one proposal to submit.";
	var submitPanel = document.getElementById("submitPanel");
				
	if(submitPanel.style.display == "none" && isSelected(elem, id, msg))
	{
		if(submitPanel.style.display == "none")
			submitPanel.style.display = "block";
		else
		if(submitPanel.style.display == "block")
			submitPanel.style.display = "none";
	}
	else
	{
		if(submitPanel.style.display == "block")
		{	submitPanel.style.display = "none";
		}
	}
}

function fnShowOffices(that)
{
	var officeCode = document.getElementById("actionTo").value;
	var newWindow = window.open("switch.do?prefix=/proposals&page=/ShowForwardOffices.do&officeCode="+officeCode,
		"","width=270,height=240");
}
function getOffices(that)
{
	form = that.form;
	form.action = "switch.do?prefix=/estimates&page=/NewEstSanctionData.do";
	form.submit();
}

function showWorkDetails(that)
{
	form = that.form;
	var workId = form.workId.value;
	if(workId.length == 14)
	{
		var url = "switch.do?prefix=/estimates&page=/ShowWorkDetails.do?workId="+workId;
		var newWindow = window.open(url,"","scrollbar=true");
	}
	else
	{
		alert("Please select a Work");
	}
	
}
function fnShowWorkComponents(workId)
{
	var workId = workId.name;
	var url = "switch.do?prefix=/estimates&page=/ShowWorkComponents.do&type=new&workId="+workId;
	var properties = 'width=300,height=150,toolbar=no,status=no,menubar=no,location=no,directories=no,'
				   + 'scrollbars=yes,copyhistory=no,resizable=yes';
	var newWindow = window.open(url,'',properties);
	newWindow.moveTo(10,10);
}

function validateSubmit(frm)
{
	if(validateSubmitForm(frm))
	{
		var url = "switch.do?prefix=/estimates&page=/NewEstSanctionAction.do"
				+ "&mode=Submit";
		frm.action = url;
		frm.submit();
	}

	return false;
}
function fnSanction(frm,elem,id)
{
	if(validateNewEstTechForm(frm))
	{
		if(isSelected(elem,id, 'Please select atleast one estimate for sanction.'))
			return true;
		else
			return false;	
	}	
	
	return false;	
}
function fnEditEstimate(frm, workId)
{
	var url = "switch.do?prefix=/estimates&page=/EditNewEstimate.do&mode=data&workId="+workId;
	frm.action = url;
	frm.submit();
}
//-->
</script>
<html:javascript formName="NewEstTechForm" />

<%@ include file="/commons/rws_header2.jsp" %>

<c:set var="estimatesForAEE" value="${requestScope.pendingEstimates[0]}" />
<c:set var="estimatesForDEE" value="${requestScope.pendingEstimates[1]}" />
<c:set var="estimatesForEE" value="${requestScope.pendingEstimates[2]}" />
<c:set var="estimatesForSE" value="${requestScope.pendingEstimates[3]}" />
<c:set var="estimatesForCE" value="${requestScope.pendingEstimates[4]}" />

<c:set var="submittedForAEE"
	value="${requestScope.submittedEstimates[0]}" />
<c:set var="submittedForDEE"
	value="${requestScope.submittedEstimates[1]}" />
<c:set var="submittedForEE"
	value="${requestScope.submittedEstimates[2]}" />
<c:set var="submittedForSE"
	value="${requestScope.submittedEstimates[3]}" />
<c:set var="submittedForCE"
	value="${requestScope.submittedEstimates[4]}" />

<c:set var="showSanPanel" value="false" />
<c:set var="pending" value="false" />

<html:form action="NewEstSanctionAction">
	<table align="center" cellpadding="0" cellspacing="0">
		<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
		<thead summary="Page header with round corner images">
			<tr>
				<td><jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName"
			value="New Estimates - Technical Sanctions" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include></td>
	</tr>
</thead>

<tfoot summary="Page footer with round corner images">
	<tr>
		<td><jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%" />
	</jsp:include></td>
	</tr>
</tfoot>

<tbody class="formTbody">
	<tr>
		<td>
		<table border="1" bordercolor="#8A9FCD" rules="none"
			style="border-collapse:collapse">
			<tr>
				<td>
				<fieldset><legend><bean:message key="legend.rwsOffices" /></legend>
				<label>
				<table>
					<tbody class="formTBody">
						<tr>
							<td class="column1"><bean:message key="app.headoffice" /></td>
							<td class="column2"><logic:equal name="RWS_USER"
								property="headOfficeCode" value="0">
								<html:select property="headOfficeCode"
									onchange="javascript: fnGetOffices(this)" styleClass="combo">
									<html:option value="">
										<bean:message key="app.pleaseSelect" />
									</html:option>
									<html:options collection="headOffices" name="labelValueBean"
										property="value" labelProperty="label" />
								</html:select>
							</logic:equal> <logic:notEqual name="RWS_USER"
								property="headOfficeCode" value="0">
								<html:text property="headOfficeName"
									styleClass="thin-text-box" name="RWS_USER" readonly="true" />
								<html:hidden property="headOfficeCode" name="RWS_USER" />
							</logic:notEqual></td>
							<td class="column3"><bean:message key="app.circle" /></td>
							<td class="column4"><logic:equal name="RWS_USER"
								property="circleOfficeCode" value="00">
								<html:select property="circleOfficeCode"
									onchange="javascript: fnGetOffices(this)" styleClass="combo">
									<html:option value="">
										<bean:message key="app.pleaseSelect" />
									</html:option>
									<logic:notEmpty name="circles">
										<html:options collection="circles" name="labelValueBean"
											property="value" labelProperty="label" />
									</logic:notEmpty>
								</html:select>
							</logic:equal> <logic:notEqual name="RWS_USER"
								property="circleOfficeCode" value="00">
								<html:text property="circleOfficeName"
									styleClass="thin-text-box" name="RWS_USER" readonly="true" />
								<html:hidden property="circleOfficeCode" name="RWS_USER" />
							</logic:notEqual></td>
						</tr>
						<tr>
							<td class="column1"><bean:message key="app.division" /></td>
							<td class="column2"><logic:equal name="RWS_USER"
								property="divisionOfficeCode" value="0">
								<html:select property="divisionOfficeCode"
									onchange="javascript: fnGetOffices(this)" styleClass="combo">
									<html:option value="">
										<bean:message key="app.pleaseSelect" />
									</html:option>
									<logic:notEmpty name="divisions">
										<html:options collection="divisions" name="labelValueBean"
											property="value" labelProperty="label" />
									</logic:notEmpty>
								</html:select>
							</logic:equal> <logic:notEqual name="RWS_USER"
								property="divisionOfficeCode" value="0">
								<html:text property="divisionOfficeName"
									styleClass="thin-text-box" name="RWS_USER" readonly="true" />
								<html:hidden property="divisionOfficeCode" name="RWS_USER" />
							</logic:notEqual></td>
							<td class="column3"><bean:message key="app.subdivision" /></td>
							<td class="column4"><logic:equal name="RWS_USER"
								property="subdivisionOfficeCode" value="00">
								<html:select property="subdivisionOfficeCode"
									styleClass="combo" onchange="javascript: fnGetOffices(this)">
									<html:option value="">
										<bean:message key="app.pleaseSelect" />
									</html:option>
									<logic:notEmpty name="subdivisions">
										<html:options collection="subdivisions"
											name="labelValueBean" property="value"
											labelProperty="label" />
									</logic:notEmpty>
								</html:select>
							</logic:equal> <logic:notEqual name="RWS_USER"
								property="subdivisionOfficeCode" value="00">
								<html:text property="subdivisionOfficeName"
									styleClass="thin-text-box" name="RWS_USER" readonly="true" />
								<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
							</logic:notEqual></td>
						</tr>
					</tbody>
				</table>
				</label>
				</fieldset>
				</td>
			</tr>

		<tr id="techSanPanel" style="display:none">
		<td>
		<fieldset><legend>Technical Sanction Details</legend>
		<label>
			<table>
			<tbody class="formTBody">
			<tr>
					<td class="column1">
						<bean:message key="app.tsOffice" /><span class="mandatory">*</span>
					</td>
					<td class="column2">
						<html:text property="tsOffice" styleClass="thin-text-box" readonly="true" />
					</td>
					<td class="column3">
						<bean:message key="app.tsGivenBy" /><span class="mandatory">*</span>
					</td>
					<td class="column4">
						<html:text property="tsGivenBy" styleClass="thin-text-box" readonly="true" />
						<html:hidden property="tsGivenBy" value="<%= RWS_USER.getDesignationCode()%>" />
					</td>
				</tr>
				<tr>
					<td class="column1">
						<bean:message key="app.tsNo"/><span class="mandatory">*</span>
					</td>
					<td class="column2">
						<html:text property="tsEndtNo" styleClass="thin-text-box" onkeypress="upperOnly()" />
					</td>
					<td class="column3">
						<bean:message key="app.tsDate"/><span class="mandatory">*</span>
					</td>
					<td class="column4">
						<html:text property="tsEndtDate" styleClass="thin-text-box" maxlength="10" size="14" />
						 <a href="javascript: showCalendar(document.NewEstTechForm.tsEndtDate);">
							<img src="<rws:context page='/images/calendar.gif'/>"
								border="0" align="absmiddle"></a>
					</td>
				</tr>
				<tr>
					<td class="column1">
						<bean:message key="app.tsAmount"/><span class="mandatory">*</span>
						<br><span style="font:menu">(Rs. in lakhs)</span>
					</td>
					<td class="column2">
						<html:text property="tsAmount" styleClass="thin-text-box" 
								   onkeypress="return decimalsOnly(event)" />
					</td>
					<td class="column3">
						<bean:message key="app.ssrYear"/><span class="mandatory">*</span>
					</td>
					<td class="column4">
						<html:select property="ssrYear" styleClass="combo">
							<html:option value="">SELECT...</html:option>
							<html:options collection="ssrYears" name="labelValueBean" 
										  property="value" labelProperty="label" />
						</html:select>
					</td>
				</tr>	
			</tbody>
			</table>
		</label>
		</fieldset>
		</td>
		</tr>

<c:if test="${not empty estimatesForAEE}">
<c:set var="pending" value="true" />
<tr>
<td>
	<fieldset><legend>Estimates pending for Technical Sanctions in the perview of AEE</legend>
	<label>
	<table width="750" cellpadding="0" cellspacing="0" border="1"
			bordercolor="#000000" style="border-collapse:collapse">
	<thead class="gridLabel">
		<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th><bean:message key="app.workId" /></th>
			<th><bean:message key="app.source" /></th>
			<th><bean:message key="app.financialYear" /></th>
			<th><bean:message key="app.totalComponents" /></th>
			<th>
				<bean:message key="app.estimateAmount"/><br>
				<bean:message key="app.rsInLakhs"/>
			</th>
			<th>
				<bean:message key="app.sanctionedAmount"/><br>
				<bean:message key="app.rsInLakhs" />
			</th>
			<th><bean:message key="app.remarks"/></th>
			<th><bean:message key="app.action"/></th>
		</tr>
	</thead>
	<tbody class="label">
	<c:forEach items="${estimatesForAEE}" var="item" varStatus="status">
		<c:set var="index" value="${status.index}" />
		<tr class='<c:out value="row${index%2}" />'>
			<td align="center" width="40"><input type="checkbox"
				name="sel" id="aee" value='<c:out value="${item.workId}"/>'>
			</td>
			<td align="center" width="90"><c:out value="${item.workId}" /></td>
			<td width="80"><c:out value="${item.sourceCode}" /></td>
			<td align="center" width="60"><c:out value="${item.financialYear}" /></td>
			<td align="center" width="80"><c:out value="${item.totalComponents}" /> 
				<input type="button" value="..." name="<c:out value='${item.workId}'/>"
				class="btext" onclick="javascript: fnShowWorkComponents(this)">
			</td>
			<td align="right" width="120">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2"
						value="${item.estimateAmount}" />&nbsp;
			</td>
			<td align="right" width="130">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2"
					value="${item.sanctionedAmount}" />&nbsp;
			</td>
			<td width="105"><c:out value="${item.remarks}" /></td>
			<td align="center" width="45">
				<input type="button" class="btext" value="Edit" 
					   onclick="fnEditEstimate(this.form,'<c:out value='${item.workId}'/>','new')"
					  <c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled="disabled"
					  </c:if> 
				>
			</td>
		</tr>
	</c:forEach>
	</tbody>
	<tfoot>
		<tr bgcolor="#8A9FCD">
			<td colspan="10">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<th align="left">&nbsp;
						<a href="javascript: checkAll('sel','aee')" id="white"><bean:message key="app.checkAll"/></a>
						<a href="javascript: clearAll('sel','aee')" id="white"><bean:message key="app.clearAll"/></a>
					</th>
					<th align="right" class="label">
						<b>No. of Estimates:&nbsp;<c:out value="${index+1}" />&nbsp;</b>
					</th>
				</tr>
				</table>
				</td>
		</tr>
	</tfoot>
	</table>
	<c:if test="${RWS_USER.designationName == 'AEE'}">
	<c:set var="showSanPanel" value="true" />
	<table width="100%">
		<tr>
			<td align="center">
				<html:submit property="mode" styleClass="btext" value="Sanction" 
							 onclick="return fnSanction(this.form,'sel','aee')"/> 
				<html:reset property="mode" styleClass="btext" value="Reset" />
			</td>
		</tr>
	</table>
	</c:if>
	</label>
	</fieldset>
</td>
</tr>

</c:if>

<c:if test="${not empty estimatesForDEE}">
<c:set var="pending" value="true" />
<tr>
<td>
	<fieldset><legend>Estimates pending for Technical Sanctions in the perview of DEE</legend>
	<label>
	<table width="750" cellpadding="0" cellspacing="0" border="1"
			bordercolor="#000000" style="border-collapse:collapse">
	<thead class="gridLabel">
		<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th><bean:message key="app.workId" /></th>
			<th><bean:message key="app.source" /></th>
			<th><bean:message key="app.financialYear" /></th>
			<th><bean:message key="app.totalComponents" /></th>
			<th>
				<bean:message key="app.estimateAmount"/><br>
				<bean:message key="app.rsInLakhs"/>
			</th>
			<th>
				<bean:message key="app.sanctionedAmount"/><br>
				<bean:message key="app.rsInLakhs" />
			</th>
			<th><bean:message key="app.remarks"/></th>
			<th><bean:message key="app.action"/></th>
		</tr>
	</thead>
	<tbody class="label">
	<c:forEach items="${estimatesForDEE}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
		<tr class='<c:out value="row${index%2}" />'>
			<td align="center" width="40"><input type="checkbox"
				name="sel" id="dee" value='<c:out value="${item.workId}"/>'>
			</td>
			<td align="center" width="90"><c:out value="${item.workId}" /></td>
			<td width="80"><c:out value="${item.sourceCode}" /></td>
			<td align="center" width="60"><c:out value="${item.financialYear}" /></td>
			<td align="center" width="80"><c:out value="${item.totalComponents}" /> 
				<input type="button" value="..." name="<c:out value='${item.workId}'/>"
					   class="btext" onclick="javascript: fnShowWorkComponents(this)">
			</td>
			<td align="right" width="120">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2"
						value="${item.estimateAmount}" />&nbsp;
			</td>
			<td align="right" width="130">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2"
						value="${item.sanctionedAmount}" />&nbsp;
			</td>
			<td width="105"><c:out value="${item.remarks}" /></td>
			<td align="center" width="45">
				<input type="button" class="btext" value="Edit" 
					   onclick="fnEditEstimate(this.form, '<c:out value='${item.workId}'/>','new')"
   					<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled="disabled"
					</c:if>
				>
			</td>
		</tr>
	</c:forEach>
	</tbody>
	<tfoot>
		<tr bgcolor="#8A9FCD">
			<td colspan="10">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<th align="left">&nbsp;
						 <a href="javascript: checkAll('sel','dee')" id="white"><bean:message key="app.checkAll"/></a>
						 <a href="javascript: clearAll('sel','dee')" id="white"><bean:message key="app.clearAll"/></a>
					 </th>
					<th align="right" class="label">
						<b>No. of Estimates:&nbsp;<c:out value="${index+1}" />&nbsp;</b>
					</th>
				</tr>
				</table>
			</td>
		</tr>
	</tfoot>
	</table>
	<c:if test="${RWS_USER.designationName == 'DEE'}">
	<c:set var="showSanPanel" value="true" />
	<table width="100%">
	<tr>
		<td align="center">
			<c:if test="${RWS_USER.headOfOffice == 'true'}">
				<html:submit property="mode" styleClass="btext" value="Sanction" 
							 onclick="return fnSanction(this.form,'sel','dee')"/> 
				<html:reset property="mode" styleClass="btext" value="Reset" />
			</c:if>
			<c:if test="${RWS_USER.headOfOffice == 'false'}">
				<html:submit property="mode" styleClass="btext" value="Sanction" disabled="true"
							 onclick="return fnSanction(this.form,'sel','dee')"/> 
				<html:reset property="mode" styleClass="btext" value="Reset" disabled="true"/>
			</c:if>
			
		</td>
	</tr>
	</table>
	</c:if>
	</label>
	</fieldset>
</td>
</tr>
</c:if>

<c:if test="${not empty estimatesForEE}">
<c:set var="pending" value="true" />
<tr>
<td>
	<fieldset><legend>Estimates pending for Technical Sanctions in the perview of EE</legend>
	<label>
	<table width="750" cellpadding="0" cellspacing="0" border="1"
			bordercolor="#000000" style="border-collapse:collapse">
	<thead class="gridLabel">
		<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th><bean:message key="app.workId" /></th>
			<th><bean:message key="app.source" /></th>
			<th><bean:message key="app.financialYear" /></th>
			<th><bean:message key="app.totalComponents" /></th>
			<th>
				<bean:message key="app.estimateAmount"/><br>
				<bean:message key="app.rsInLakhs"/>
			</th>
			<th>
				<bean:message key="app.sanctionedAmount"/><br>
				<bean:message key="app.rsInLakhs" />
			</th>
			<th><bean:message key="app.remarks"/></th>
			<th><bean:message key="app.action"/></th>
		</tr>
	</thead>
	<tbody class="label">
	<c:forEach items="${estimatesForEE}" var="item"	varStatus="status">
	<c:set var="index" value="${status.index}" />
		<tr class='<c:out value="row${index%2}" />'>
			<td align="center" width="40">
				<input type="checkbox" name="sel" id="ee" value='<c:out value="${item.workId}"/>'>
			</td>
			<td align="center" width="90"><c:out value="${item.workId}" /></td>
			<td width="80"><c:out value="${item.sourceCode}" /></td>
			<td align="center" width="60"><c:out value="${item.financialYear}" /></td>
			<td align="center" width="80"><c:out value="${item.totalComponents}" /> 
				<input type="button" value="..." name="<c:out value='${item.workId}'/>"
							class="btext" onclick="javascript: fnShowWorkComponents(this)">
			</td>
			<td align="right" width="120">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2"
							value="${item.estimateAmount}" />&nbsp;
			</td>
			<td align="right" width="130">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2"
							value="${item.sanctionedAmount}" />&nbsp;
			</td>
			<td width="105"><c:out value="${item.remarks}" /></td>
			<td align="center" width="45">
				<input type="button" class="btext" value="Edit" 
					   onclick="fnEditEstimate(this.form,'<c:out value='${item.workId}'/>','new')"
   					<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled="disabled"
					</c:if>
				>
			</td>
		</tr>
	</c:forEach>
	</tbody>
	<tfoot>
		<tr bgcolor="#8A9FCD">
			<td colspan="10">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<th align="left">&nbsp;
						 <a href="javascript: checkAll('sel','ee')" id="white"><bean:message key="app.checkAll"/></a>
						 <a href="javascript: clearAll('sel','ee')" id="white"><bean:message key="app.clearAll"/></a>
					 </th>
					<th align="right" class="label">
						<b>No. of Estimates:&nbsp;<c:out value="${index+1}" />&nbsp;</b>
					</th>
				</tr>
				</table>
			</td>
		</tr>
	</tfoot>
	</table>
	<table>
		<tr>
			<td><input type="button" class="btext" name="cmbShowHideSubmit"
					value="Submit" style="width:75px"
					onclick="javascript:fnShowHideSubmit('sel','ee')"
					<c:if test="${RWS_USER.officeName == 'Division Office'}">
				   disabled = "disabled"
				   </c:if>
					<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled = "disabled"
					</c:if>
				>
				   
			</td>
		</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>
</c:if>

<c:if test="${not empty estimatesForSE}">
<c:set var="pending" value="true" />
	<tr>
		<td>
		<fieldset><legend>Estimates pending for Technical Sanctions in the perview of SE</legend>
		<label>
		<table width="750" cellpadding="0" cellspacing="0" border="1"
			bordercolor="#000000" style="border-collapse:collapse">
			<thead class="gridLabel">
			<tr bgcolor="#8A9FCD">
				<th><bean:message key="app.select" /></th>
				<th><bean:message key="app.workId" /></th>
				<th><bean:message key="app.source" /></th>
				<th><bean:message key="app.financialYear" /></th>
				<th><bean:message key="app.totalComponents" /></th>
				<th>
					<bean:message key="app.estimateAmount"/><br>
					<bean:message key="app.rsInLakhs"/>
				</th>
				<th>
					<bean:message key="app.sanctionedAmount"/><br>
					<bean:message key="app.rsInLakhs" />
				</th>
				<th><bean:message key="app.remarks"/></th>
				<th><bean:message key="app.action"/></th>
			</tr>
			</thead>
			<tbody class="label">
				<c:forEach items="${estimatesForSE}" var="item"
					varStatus="status">
					<c:set var="index" value="${status.index}" />
					<tr class='<c:out value="row${index%2}" />'>
						<td align="center" width="40"><input type="checkbox"
							name="sel" id="se" value='<c:out value="${item.workId}"/>'>
						</td>
						<td align="center" width="90"><c:out value="${item.workId}" /></td>
						<td width="80"><c:out value="${item.sourceCode}" /></td>
						<td align="center" width="60"><c:out
							value="${item.financialYear}" /></td>
						<td align="center" width="80"><c:out
							value="${item.totalComponents}" /> <input type="button"
							value="..." name="<c:out value='${item.workId}'/>"
							class="btext"
							onclick="javascript: fnShowWorkComponents(this)"></td>
						<td align="right" width="120"><fmt:formatNumber
							maxFractionDigits="2" minFractionDigits="2"
							value="${item.estimateAmount}" />&nbsp;</td>
						<td align="right" width="130"><fmt:formatNumber
							maxFractionDigits="2" minFractionDigits="2"
							value="${item.sanctionedAmount}" />&nbsp;</td>
						<td width="105"><c:out value="${item.remarks}" /></td>
						<td align="center" width="45">
							<input type="button" class="btext" value="Edit" 
					   		onclick="fnEditEstimate(this.form,'<c:out value='${item.workId}'/>','new')"
					   		<c:if test="${RWS_USER.headOfOffice == 'false'}">
							disabled="disabled"
							</c:if>
					   >
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr bgcolor="#8A9FCD">
					<td colspan="10">
					<table width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<th align="left">&nbsp; <a
								href="javascript: checkAll('sel','se')" id="white">Check
							All</a> <a href="javascript: clearAll('sel','se')"
								id="white"><bean:message key="app.clearAll"/></a></th>
							<th align="right" class="label"><b>No. of Estimates:&nbsp;<c:out
								value="${index+1}" />&nbsp;</b></th>
						</tr>
					</table>
					</td>
				</tr>
			</tfoot>
		</table>
		<table>
			<tr>
				<td><input type="button" class="btext" name="cmbShowHideSubmit"
					value="Submit" style="width:75px" onclick="javascript:fnShowHideSubmit('sel','se')"
					<c:if test="${RWS_USER.officeName == 'Circle Office'}">
				   disabled = "disabled"
				   </c:if>
				   	<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled = "disabled"
					</c:if>
				   >
					</td>
				</tr>
			</table>
			</label></fieldset>
			</td>
		</tr>
	</c:if>

	<c:if test="${not empty estimatesForCE}">
	<c:set var="pending" value="true" />
	<tr>
		<td>
		<fieldset><legend>Estimates pending for Technical Sanctions in the perview of CE</legend>
		<label>
		<table width="750" cellpadding="0" cellspacing="0" border="1"
			bordercolor="#000000" style="border-collapse:collapse">
			<thead class="gridLabel">
				<tr bgcolor="#8A9FCD">
					<th><bean:message key="app.select" /></th>
					<th><bean:message key="app.workId" /></th>
					<th><bean:message key="app.source" /></th>
					<th><bean:message key="app.financialYear" /></th>
					<th><bean:message key="app.totalComponents" /></th>
					<th>
						<bean:message key="app.estimateAmount"/><br>
						<bean:message key="app.rsInLakhs"/>
					</th>
					<th>
						<bean:message key="app.sanctionedAmount"/><br>
						<bean:message key="app.rsInLakhs" />
					</th>
					<th><bean:message key="app.remarks"/></th>
					<th><bean:message key="app.action"/></th>
				</tr>
			</thead>
	<tbody class="label">
	<c:forEach items="${estimatesForCE}" var="item"	varStatus="status">
	<c:set var="index" value="${status.index}" />
		<tr class='<c:out value="row${index%2}" />'>
			<td align="center" width="40"><input type="checkbox"
						name="sel" id="ce" value='<c:out value="${item.workId}"/>'>
			</td>
			<td align="center" width="90"><c:out value="${item.workId}" /></td>
			<td width="80"><c:out value="${item.sourceCode}" /></td>
			<td align="center" width="60"><c:out value="${item.financialYear}" /></td>
			<td align="center" width="80"><c:out value="${item.totalComponents}" /> <input type="button"
							value="..." name="<c:out value='${item.workId}'/>"
							class="btext" onclick="javascript: fnShowWorkComponents(this)">
			</td>
			<td align="right" width="120">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2"
							value="${item.estimateAmount}" />&nbsp;
			</td>
			<td align="right" width="130">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2"
							value="${item.sanctionedAmount}" />&nbsp;
			</td>
			<td width="105"><c:out value="${item.remarks}" /></td>
			<td align="center" width="45">
				<input type="button" class="btext" value="Edit" 
					   onclick="fnEditEstimate(this.form,'<c:out value='${item.workId}'/>','new')"
   					<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled="disabled"
					</c:if>
				>
			</td>
		</tr>
	</c:forEach>
	</tbody>
	<tfoot>
				<tr bgcolor="#8A9FCD">
					<td colspan="10">
					<table width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<th align="left">&nbsp; <a
								href="javascript: checkAll('sel','ce')" id="white">Check
							All</a> <a href="javascript: clearAll('sel','ce')"
								id="white"><bean:message key="app.clearAll"/></a></th>
							<th align="right" class="label"><b>No. of Estimates:&nbsp;<c:out
								value="${index+1}" />&nbsp;</b></th>
						</tr>
					</table>
					</td>
				</tr>
			</tfoot>
		</table>
		<table>
			<tr>
				<td><input type="button" class="btext" name="cmbShowHideSubmit"
					value="Submit" style="width:75px"
					onclick="javascript:fnShowHideSubmit('sel','ce')"
					<c:if test="${RWS_USER.officeName == 'Head Office'}">
				    disabled = "disabled"
				    </c:if>
				    <c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled = "disabled"
					</c:if>
				    >
				</td>
			</tr>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
	</c:if>

<c:if test="${not empty submittedForEE}">
<c:set var="pending" value="true" />
<tr>
	<td>
	<fieldset><legend>Estimates pending for Technical Sanctions in the perview of EE</legend>
	<label>
	<table width="750" cellpadding="0" cellspacing="0" border="1"
		bordercolor="#000000" style="border-collapse:collapse">
	<thead class="gridLabel">
		<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th><bean:message key="app.workId" /></th>
			<th><bean:message key="app.source" /></th>
			<th><bean:message key="app.financialYear" /></th>
			<th><bean:message key="app.totalComponents" /></th>
			<th>
				<bean:message key="app.estimateAmount"/><br>
				<bean:message key="app.rsInLakhs"/>
			</th>
			<th>
				<bean:message key="app.sanctionedAmount"/><br>
				<bean:message key="app.rsInLakhs" />
			</th>
			<th><bean:message key="app.remarks"/></th>
			<th><bean:message key="app.action"/></th>
		</tr>
	</thead>
	<tbody class="label">
		<c:forEach items="${submittedForEE}" var="item" varStatus="status">
		<c:set var="index" value="${status.index}" />
		<c:set var="officeCode" value="" />
		<c:if test="${officeCode != item.officeCode}">
			<c:set var="officeCode" value="${item.officeCode}" />
			<tr bgcolor="lightyellow">
				<td align="left" colspan="9"><font size="-1" face="verdana">
				Estimates submitted from <c:out value="${item.officeName}" />
				</font>
				</td>
			</tr>
		</c:if>
		<tr class='<c:out value="row${index%2}" />'>
		<td align="center" width="40">
			<input type="checkbox" name="sel" id="sub_ee" value='<c:out value="${item.workId}"/>'>
		</td>
		<td align="center" width="90" style="display:block;cursor:hand"
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false" />'
			onmouseout="hideddrivetip()"> 
				<c:out value="${item.workId}" />
		</td>
		<td width="80"><c:out value="${item.sourceCode}" /></td>
		<td align="center" width="60"><c:out value="${item.financialYear}" /></td>
		<td align="center" width="80"><c:out value="${item.totalComponents}" />
			<input type="button" value="..." name="<c:out value='${item.workId}'/>"
					class="btext" onclick="javascript: fnShowWorkComponents(this)">
		</td>
		<td align="right" width="120">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" value="${item.estimateAmount}" />&nbsp;
		</td>
		<td align="right" width="130">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" value="${item.sanctionedAmount}" />&nbsp;
		</td>
		<td width="105"><c:out value="${item.remarks}" /></td>
		<td align="center" width="45">
				<input type="button" class="btext" value="Edit" 
					   onclick="fnEditEstimate(this.form,'<c:out value='${item.workId}'/>','new')"
  					<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled="disabled"
					</c:if> 
				>
		</td>
		</tr>
		</c:forEach>
	</tbody>
	<tfoot>
	<tr bgcolor="#8A9FCD">
	<td colspan="10">
		<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<th align="left">&nbsp;
				 <a href="javascript: checkAll('sel','sub_ee')" id="white"><bean:message key="app.checkAll"/></a>
				 <a href="javascript: clearAll('sel','sub_ee')" id="white"><bean:message key="app.clearAll"/></a>
			 </th>
			<th align="right" class="label"><b>No. of Estimates:&nbsp;<c:out value="${index+1}" />&nbsp;</b>
			</th>
		</tr>
		</table>
	</td>
	</tr>
	</tfoot>
</table>
<table width="100%">
	<c:if test="${RWS_USER.officeName != 'Division Office'}">
		<tr>
			<td align="left">
				<input type="button" class="btext"	name="cmbShowHideSubmit" value="Submit" 
					style="width:75px" onclick="javascript:fnShowHideSubmit('sel','sub_ee')"
					<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled = "disabled"
					</c:if>
				>
			</td>
		</tr>
	</c:if>
	<c:if test="${RWS_USER.designationName == 'EE'}">
	<c:set var="showSanPanel" value="true" />
		<tr>
			<td align="center">
				<c:if test="${RWS_USER.headOfOffice == 'true'}">
					<html:submit property="mode" styleClass="btext" value="Sanction" 
								 onclick="return fnSanction(this.form,'sel','sub_ee')"/> 
				 	<html:reset property="mode" styleClass="btext" value="Reset" />
			 	</c:if>
			 	<c:if test="${RWS_USER.headOfOffice == 'false'}">
					<html:submit property="mode" styleClass="btext" value="Sanction" disabled="true"
								 onclick="return fnSanction(this.form,'sel','sub_ee')"/> 
				 	<html:reset property="mode" styleClass="btext" value="Reset" disabled="true" />
			 	</c:if>
			 </td>
		</tr>
	</c:if>
	</table>
	</label>
	</fieldset>
	</td>
	</tr>
</c:if>

<c:if test="${not empty submittedForSE}">
<c:set var="pending" value="true" />
<tr>
	<td>
	<fieldset><legend>Estimates pending for Technical Sanctions in the perview of SE</legend>
	<label>
	<table width="750" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" 
		  style="border-collapse:collapse">
	<thead class="gridLabel">
		<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th><bean:message key="app.workId" /></th>
			<th><bean:message key="app.source" /></th>
			<th><bean:message key="app.financialYear" /></th>
			<th><bean:message key="app.totalComponents" /></th>
			<th>
				<bean:message key="app.estimateAmount"/><br>
				<bean:message key="app.rsInLakhs"/>
			</th>
			<th>
				<bean:message key="app.sanctionedAmount"/><br>
				<bean:message key="app.rsInLakhs" />
			</th>
			<th><bean:message key="app.remarks"/></th>
			<th><bean:message key="app.action"/></th>
		</tr>
	</thead>
	<tbody class="label">
		<c:forEach items="${submittedForSE}" var="item"
		varStatus="status">
		<c:set var="index" value="${status.index}" />
		<c:set var="officeCode" value="" />
		<c:if test="${officeCode != item.officeCode}">
			<c:set var="officeCode" value="${item.officeCode}" />
			<tr bgcolor="lightyellow">
				<td align="left" colspan="9"><font size="-1" face="verdana">
				Estimates submitted from <c:out value="${item.officeName}" />
				</font></td>
			</tr>
		</c:if>
		<tr class='<c:out value="row${index%2}" />'>
			<td align="center" width="40">
				<input type="checkbox" name="sel" id="sub_se" value='<c:out value="${item.workId}"/>'>
			</td>
			<td align="center" width="90" style="display:block;cursor:hand" 
				onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false" />'
				onmouseout="hideddrivetip()">
				 <c:out value="${item.workId}" />
			</td>
			<td width="80"><c:out value="${item.sourceCode}" /></td>
			<td align="center" width="60"><c:out value="${item.financialYear}" /></td>
			<td align="center" width="80"><c:out value="${item.totalComponents}" /> 
				<input type="button" value="..." name="<c:out value='${item.workId}'/>"
				class="btext" onclick="javascript: fnShowWorkComponents(this)">
			</td>
			<td align="right" width="120">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" value="${item.estimateAmount}" />&nbsp;
			</td>
			<td align="right" width="130">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" value="${item.sanctionedAmount}" />&nbsp;
			</td>
			<td width="105"><c:out value="${item.remarks}" /></td>
			<td align="center" width="45">
				<input type="button" class="btext" value="Edit" 
					   onclick="fnEditEstimate(this.form,'<c:out value='${item.workId}'/>','new')"
   					<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled="disabled"
					</c:if>
				>
			</td>
		</tr>
	</c:forEach>
</tbody>
<tfoot>
	<tr bgcolor="#8A9FCD">
	<td colspan="10">
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<th align="left">&nbsp;<a href="javascript: checkAll('sel','sub_se')" id="white"><bean:message key="app.checkAll"/></a>
			 	<a href="javascript: clearAll('sel','sub_se')" id="white"><bean:message key="app.clearAll"/></a>
		 </th>
		<th align="right" class="label"><b>No. of Estimates:&nbsp;<c:out value="${index+1}" />&nbsp;</b></th>
		</tr>
	</table>
	</td>
	</tr>
</tfoot>
</table>
<table width="100%">
	<c:if test="${RWS_USER.officeName != 'Circle Office'}">
		<tr>
			<td align="left">
				<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" style="width:75px"
				onclick="javascript:fnShowHideSubmit('sel','sub_se')"
					<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled="disabled"
					</c:if>
				>
			</td>
		</tr>
	</c:if>
	<c:if test="${RWS_USER.designationName == 'SE'}">
	<c:set var="showSanPanel" value="true" />
		<tr>
			<td align="center">
				<c:if test="${RWS_USER.headOfOffice == 'true'}">	
					<html:submit property="mode" styleClass="btext" value="Sanction" 
								 onclick="return fnSanction(this.form,'sel','sub_se')"/> 
					<html:reset property="mode" styleClass="btext" value="Reset" />
				</c:if>
				<c:if test="${RWS_USER.headOfOffice == 'false'}">	
					<html:submit property="mode" styleClass="btext" value="Sanction" disabled="true"
								 onclick="return fnSanction(this.form,'sel','sub_se')"/> 
					<html:reset property="mode" styleClass="btext" value="Reset" disabled="true" />
				</c:if>
			</td>
		</tr>
	</c:if>
	</table>
	</label>
	</fieldset>
	</td>
	</tr>
</c:if>

<c:if test="${not empty submittedForCE}">
<c:set var="pending" value="true" />
<tr>
<td>
<fieldset><legend>Estimates pending for Technical Sanctions in the perview of CE</legend>
<label>
<table width="750" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" 
	style="border-collapse:collapse">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
		<th><bean:message key="app.select" /></th>
		<th><bean:message key="app.workId" /></th>
		<th><bean:message key="app.source" /></th>
		<th><bean:message key="app.financialYear" /></th>
		<th><bean:message key="app.totalComponents" /></th>
		<th>
			<bean:message key="app.estimateAmount"/><br>
			<bean:message key="app.rsInLakhs"/>
		</th>
		<th>
			<bean:message key="app.sanctionedAmount"/><br>
			<bean:message key="app.rsInLakhs" />
		</th>
		<th><bean:message key="app.remarks"/></th>
		<th><bean:message key="app.action"/></th>
</tr>
</thead>
<tbody class="label">
	<c:forEach items="${submittedForCE}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:set var="officeCode" value="" />
	<c:if test="${officeCode != item.officeCode}">
		<c:set var="officeCode" value="${item.officeCode}" />
		<tr bgcolor="lightyellow">
			<td align="left" colspan="9">
			<font size="-1" face="verdana">Estimates submitted from <c:out value="${item.officeName}" /></font>
			</td>
		</tr>
		</c:if>
		<tr class='<c:out value="row${index%2}" />'>
			<td align="center" width="40"><input type="checkbox" name="sel" id="sub_ce"
				value='<c:out value="${item.workId}"/>'>
			</td>
			<td align="center" width="90" style="display:block;cursor:hand"
				onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false" />'
				onmouseout="hideddrivetip()"> <c:out value="${item.workId}" />
			</td>
			<td width="80"><c:out value="${item.sourceCode}" /></td>
			<td align="center" width="60"><c:out value="${item.financialYear}" /></td>
			<td align="center" width="80"><c:out value="${item.totalComponents}" />
				<input type="button" value="..." name="<c:out value='${item.workId}'/>" class="btext"
					onclick="javascript: fnShowWorkComponents(this)">
			</td>
			<td align="right" width="120">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" value="${item.estimateAmount}" />&nbsp;
			</td>
			<td align="right" width="130">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" value="${item.sanctionedAmount}" />&nbsp;
			</td>
			<td width="105"><c:out value="${item.remarks}" /></td>
			<td align="center" width="45">
				<input type="button" class="btext" value="Edit" 
					   onclick="fnEditEstimate(this.form,'<c:out value='${item.workId}'/>','new')"
					   <c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled="disabled"
					   </c:if>
				>
			</td>
		</tr>
	</c:forEach>
</tbody>
<tfoot>
	<tr bgcolor="#8A9FCD">
	<td colspan="10">
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<th align="left">&nbsp; 
			<a href="javascript: checkAll('sel','sub_ce')" id="white"><bean:message key="app.checkAll"/></a>
			 <a href="javascript: clearAll('sel','sub_ce')" id="white"><bean:message key="app.clearAll"/></a>
		</th>
		<th align="right" class="label"><b>No. of Estimates:&nbsp;<c:out value="${index+1}" />&nbsp;</b></th>
	</tr>
	</table>
	</td>
	</tr>
</tfoot>
</table>
<table width="100%">
	<c:if test="${RWS_USER.officeName != 'Head Office'}">
		<tr>
			<td align="left">
				<input type="button" class="btext"	name="cmbShowHideSubmit" value="Submit" style="width:75px"
					onclick="javascript:fnShowHideSubmit('sel','sub_ce')"
					<c:if test="${RWS_USER.headOfOffice == 'false'}">
						disabled="disabled"
					</c:if>
				>
			</td>
		</tr>
	</c:if>
	<c:if test="${RWS_USER.designationName == 'ENC'}">
	<c:set var="showSanPanel" value="true" />
		<tr>
			<td align="center">
				<c:if test="${RWS_USER.headOfOffice == 'true'}">
					<html:submit property="mode" styleClass="btext" value="Sanction"
								 onclick="return fnSanction(this.form,'sel','sub_ce')"/>
				 	<html:reset property="mode" styleClass="btext" value="Reset" />
				 </c:if>
				 <c:if test="${RWS_USER.headOfOffice == 'false'}">
					<html:submit property="mode" styleClass="btext" value="Sanction" disabled="true"
								 onclick="return fnSanction(this.form,'sel','sub_ce')"/>
				 	<html:reset property="mode" styleClass="btext" value="Reset" disabled="true"/>
				 </c:if>	
			</td>
		</tr>
	</c:if>
	</table>
</label>
</fieldset>
</td>
</tr>
</c:if>

<c:if test="${pending == false}">
<tr>
<td>
	<table>
	<tbody class="formTBody">
	<tr>
		<td><font color="blue">There are no estimates in this office</font></td>
	</tr>
	</tbody>
	</table>
</td>
</tr>
</c:if>

<c:if test="${showSanPanel == 'true'}">
<script>
<!--
	document.getElementById("techSanPanel").style.display = "block";
//-->
</script>
</c:if>
<tr bgcolor="#DEE3E0" id="submitPanel" style="display:none">
	<td>
	<fieldset><legend><bean:message key="legend.submit" /></legend>
	<label>
	<table align="left">
		<tbody class="formTBody">
			<logic:notEmpty name="NewEstTechForm" property="submitTo">
				<tr>
					<td><bean:message key="app.submitTo" /></td>
					<td>:</td>
					<td colspan="4"><span style="font-weight:normal;"> <bean:write
						name="NewEstTechForm" property="submitOffice" /> <html:hidden
						property="submitTo" /> </span></td>
				</tr>
			</logic:notEmpty>
			<tr>
				<td><bean:message key="app.letterNo" /><span class="mandatory">*</span></td>
				<td>:</td>
				<td><html:text property="letterNo" maxlength="15"
					styleClass="thin-text-box" onkeypress="return textOnly(event)" />
				</td>
			</tr>
			<tr>
				<td><bean:message key="app.date" /><span class="mandatory">*</span></td>
				<td>:</td>
				<td><html:text property="submitDate" maxlength="10"
					styleClass="thin-text-box" size="14" /> <a
					href="javascript: showCalendar(document.NewEstTechForm.submitDate);">
				<img src="<rws:context page='/images/calendar.gif'/>"
					border="0" align="absmiddle"> </a></td>
			</tr>
			<tr>
				<td><bean:message key="app.subject" /><span class="mandatory">*</span></td>
				<td>:</td>
				<td colspan="4"><html:text property="submitSubject" size="95"
					maxlength="100" styleClass="thin-text-box"
					onkeypress="return textOnly(event)" /></td>
			</tr>
			<tr>
				<td><bean:message key="app.ref" /></td>
				<td>:</td>
				<td colspan="4"><html:text property="submitRef" size="70"
					maxlength="50" styleClass="thin-text-box"
					onkeypress="return textOnly(event)" /></td>
			</tr>
			<tr>
				<td valign="top"><bean:message key="app.content" /><span
					class="mandatory">*</span></td>
				<td valign="top">:</td>
				<td colspan="3"><html:textarea property="submitContent"
					rows="5" cols="71" styleClass="thin-text-box"
					onkeypress="return textOnly(event)" /></td>
			</tr>
			<tr>
				<td colspan="3" align="center"><html:button property="mode"
					styleClass="btext" onclick="return validateSubmit(this.form)">
					<bean:message key="button.send" />
				</html:button>
				</td>
			</tr>
	</table>
	</label></fieldset>
	</td>
</tr>

		</table>
		</td>
	</tr>
</tbody>
</table>
<html:hidden property="init" />
<html:hidden property="userId" name="RWS_USER" />
<html:hidden property="officeCode" name="RWS_USER" />
</html:form>

<%@ include file="/commons/rws_tooltip.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />
