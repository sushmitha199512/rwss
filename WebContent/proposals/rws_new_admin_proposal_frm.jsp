<%@ include file="/commons/rws_header1.jsp"%>

<script language="JavaScript">
<!--

function fnGetOffices(that)
{
	var field = that.name;
	
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/NewAdminProposalData.do"
			+ "&mode=headoffice";
	else
	if(field == 'circleOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/NewAdminProposalData.do"
			+ "&mode=circle";
	else
	if(field == 'divisionOfficeCode')	
		url = "switch.do?prefix=/proposals&page=/NewAdminProposalData.do"
			+ "&mode=division";		
	else
	if(field == 'subdivisionOfficeCode')	
		url = "switch.do?prefix=/proposals&page=/NewAdminProposalData.do"
			+ "&mode=subdivision";		
	frm.action = url;
	frm.submit();

}

function fnShowHideForward(elem, id)
{	
	var msg = "Please select atleast one proposal to forward.";
	var forwardPanel = document.getElementById("forwardPanel");
	if(forwardPanel.style.display == "none" && isSelected(elem, id, msg))
	{	
		if(forwardPanel.style.display == "none")
		{	
			forwardPanel.style.display = "block";
		}
		else
		if(forwardPanel.style.display == "block")
		{	
			forwardPanel.style.display = "none";
		}
	}
	else
	{
		if(forwardPanel.style.display == "block")
		{	forwardPanel.style.display = "none";
		}
	}
}

function fnShowOffices(that)
{
	var officeCode = document.getElementById("actionTo").value;
	var url = "switch.do?prefix=/proposals&page=/ShowForwardOffices.do&officeCode="+officeCode;
	var properties = "width=270,height=240,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
}

function fnShowDivisionOffices(that)
{
	var officeCode = document.getElementById("actionTo").value;
	var url = "switch.do?prefix=/proposals&page=/ShowForwardToOffices.do&officeCode="+officeCode+"&officeType=division&mode=data";
	var properties = "width=270,height=240,toolbar=no,status=yes,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
}

function fnShowSubDivisionOffices(that)
{
	var officeCode = document.getElementById("actionTo").value;
	var url = "switch.do?prefix=/proposals&page=/ShowForwardToOffices.do&officeCode="+officeCode+"&officeType=subDivision&mode=data";
	var properties = "width=270,height=240,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
}

function fnEditProposal(that)
{
	var proposalId = that.name;
	var url = "switch.do?prefix=/proposals&page=/NewAdminProposalEditData.do&proposalId="+proposalId;
	var frm = that.form;
	frm.action = url;
	frm.submit();
}
function fnShowOtherDetails(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/ShowOtherDetails.do?proposalId="+proposalId
	var properties = "width=420,height=330,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
}
function fnShowSanctionDetails(that)
{
	var frm = that.form;
	var proposalId = that.name;
	
	var url = "switch.do?prefix=/proposals&page=/ShowSanctionDetails.do"
			+ "&type=new&proposalId="+proposalId;
	
	var properties = "width=667,height=355,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"", properties)		
}
function fnShowHabs(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/ShowSelectedHabs.do?proposalId="+proposalId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
	newWindow.moveTo(10,10);
}

function fnCalculate(that)
{
	var proposalId = that.name.substring(0,12);
	var sanctionAmount = that.value;
	var formName = document.getElementById('sel').form.name;
	var frm = document.forms[formName];
	var checkCollection =  frm.elements('sel');
	if(checkCollection)
	{
		if(typeof checkCollection.length != "number")
		{
			checkCollection = [checkCollection];
		}

		var len = checkCollection.length;
		var grossSanctionedAmount = 0.00;

		for(var i=0; i<len; i++)
		{
			grossSanctionedAmount = parseFloat(grossSanctionedAmount) + parseFloat(document.getElementById(checkCollection[i].value + "_SA").value);
			grossSanctionedAmount = grossSanctionedAmount.toFixed(2);
			
			if(checkCollection[i].checked)
			{
				document.getElementById("sanctionedAmount").value = grossSanctionedAmount;
			}
		}
		
	}
}
function isPositiveDecimal(that)
{
	//form = that.form;
	var str = that.value;
	var re = /^\d*\.?\d*$/;
	str = str.toString();
	if(!str.match(re))
	{	
		//alert("Only numbers are allowed here ");
		return false;
	}
	return true;
}

function checkMe(that)
{	
	
	form = that.form;
	var id = that.name;
	var proposalId = that.value;
	var assetCode = document.getElementById("AC"+proposalId).value;
	var programmeCode = document.getElementById("PC"+proposalId).value;
	var estimateCost = document.getElementById("EC"+proposalId).value;
	var sanctionedAmount = document.getElementById(proposalId+"_SA").value;
	sanctiondedAmount = parseFloat(sanctionedAmount);
	if(isNaN(sanctionedAmount))
		sanctionedAmount = "0.00";
		
	if(that.checked)
	{
		var message =  "You cannot select this Proposal\n"; 
		var isAllowed = true;	
		if(assetCode == "" || assetCode == "00")
		{	isAllowed = false;
			message += "Scheme is not specified\n";
		}
		if(programmeCode == "" || programmeCode == "00")
		{	isAllowed = false;
			message += "Programme is not specified\n";
		}
		if(estimateCost == "" || estimateCost == "0")
		{	isAllowed = false;
			message += "Estimate Cost is not specified\n";
		}
		if(sanctionedAmount == "")
		{	isAllowed = false;
			message += "Sanctioned Amount is not specified\n";
			document.getElementById(proposalId+"_SA").focus();
		}
		else
		if(sanctionedAmount <= 0)
		{	isAllowed = false;
			message += "Sanctioned Amount must be greater than 0\n";
			document.getElementById(proposalId+"_SA").focus();
		}

		message += "\nClick the Edit button and enter the data!";
		if(!isAllowed)
		{
			//alert(message);
			return false;
		}
		
		if(isPositiveDecimal(form.estimateCost))
		{
			var eAmount = form.estimateCost.value;
			if(eAmount.length < 1)
				eAmount = 0;
			eAmount = parseFloat(eAmount) + parseFloat(estimateCost); 
			form.estimateCost.value = eAmount.toFixed(2);
		}
		
		if(isPositiveDecimal(form.sanctionedAmount))
		{
			var sAmount = form.sanctionedAmount.value;
			if(sAmount.length < 1)
				sAmount = 0;
			sAmount = parseFloat(sAmount) + parseFloat(sanctionedAmount); 
			form.sanctionedAmount.value = sAmount.toFixed(2);
		}
			
		return true;
	}
	
	else
	{
		if(isPositiveDecimal(form.estimateCost))
		{
			var eAmount = form.estimateCost.value;
			if(eAmount.length < 1)
				eAmount = 0;
			eAmount = parseFloat(eAmount) - parseFloat(estimateCost); 
			form.estimateCost.value = eAmount.toFixed(2);
		//	form.estimateCost.value = "";
		}
		
		if(isPositiveDecimal(form.sanctionedAmount))
		{
			var sAmount = form.sanctionedAmount.value;
			if(sAmount.length < 1)
				sAmount = 0;
			sAmount = parseFloat(sAmount) - parseFloat(sanctionedAmount); 
		 	form.sanctionedAmount.value = sAmount.toFixed(2);
		//	form.sanctionedAmount.value = "";
		}
		return true;
	}

}

function checkAll(elem, id)
{
	var formName = document.getElementById(elem).form.name;
	var frm = document.forms[formName];
	var checkCollection =  frm.elements(elem);
	if(checkCollection)
	{
		if(typeof checkCollection.length != "number")
		{
			checkCollection = [checkCollection];
		}

		var len = checkCollection.length;
	
		for(var i=0; i<len; i++) 
		{
			if( checkCollection[i].id == id)
			{
				if(!checkCollection[i].checked)
					checkCollection[i].click();
			}
		}
	}
}

function clearAllSanc(elem, id)
{
	var formName = document.getElementById(elem).form.name;
	var frm = document.forms[formName];
	var checkCollection =  frm.elements(elem);
	if(checkCollection)
	{
		if(typeof checkCollection.length != "number")
		{
			checkCollection = [checkCollection];
		}

		var len = checkCollection.length;
	
		for(var i=0; i<len; i++) 
		{
			//alert("checkCollection.id:   " + checkCollection[i].id);
			if( checkCollection[i].id == id)
			{
				checkCollection[i].checked = false;
				frm.estimateCost.value = "";
				frm.sanctionedAmount.value = "";
			}
		}
	}
} 

function validateForwardForm(frm)
{
	var message = "";
	var allowed = true;

	if( isEmpty(frm.forwardContent) )
	{
		allowed = false;
		message = "Content is required" + message;
		frm.forwardContent.focus();
	}

	if( isEmpty(frm.forwardSubject) )
	{	
		allowed = false;
		message = "Subject is required\n" + message;
		frm.forwardSubject.focus();
	}
	if( isEmpty(frm.forwardDate) )
	{
		allowed = false;
		message = "Date is required\n" + message;
		frm.forwardDate.focus();
	}
	if(	isEmpty(frm.memoNo) )
	{	
		allowed = false;
		message = "Memo No. is required\n" + message;
		frm.memoNo.focus();
	}
	if(frm.forwardTo.value == frm.officeCode.value)
	{
		allowed = false;
		message = "Forward To is required\n" + message;
	}

	if(!allowed)
	{
		//alert(message);
		return false;
	}
	/*
	if( !isSelected('sel','sanc','Please select atleast one proposal to Forward') )
		return false;
	*/
	return true;
		
}
function validateForward(frm)
{
	
	if(validateForwardForm(frm))
	{
		var url="";
		if(document.forms[0].forwardToDivision||document.forms[0].forwardToDivision)
		url = "switch.do?prefix=/proposals&page=/NewAdminProposalAction.do&mode=Forward&officeType=headOffice";
		else
		url = "switch.do?prefix=/proposals&page=/NewAdminProposalAction.do&mode=Forward";
		frm.action = url;
		
		frm.submit();
	}
}

function fnSave()
{
	if(validateAdminProposalForm(AdminProposalForm))
	{
		if(isSelected('sel', 'sub', 'Please select atleast one proposal to sanction.'))
			return true;
	}
	return false;
}
//-->
</script>

<html:javascript formName="AdminProposalForm" />
<%@ include file="/commons/rws_header2.jsp"%>


<html:form action="/NewAdminProposalAction" method="POST" enctype="multipart/form-data">

<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="New Proposals - Administrative Sanction Form" />
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

<c:set var="pending" value="false"/>

<tbody>
<tr>
<td>
<table bgcolor="#DEE3E0" border="1" width="100%" bordercolor="#8A9FCD" rules="none" 
		style="border-collapse:collapse">
<tr>
<td>
<fieldset>
<legend><bean:message key="legend.rwsOffices" /></legend>
<label>
	<table>
	<tbody class="formTBody">
	<tr>
		<td width="180"><bean:message key="app.headoffice" /></td>
		<td width="160">
			<logic:equal name="RWS_USER" property="headOfficeCode" value="0">
				<html:select property="headOfficeCode" onchange="javascript: fnGetOffices(this)"
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="headOffices" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
					<html:text property="headOfficeName" styleClass="thin-text-box" 
							name="RWS_USER" readonly="true"/>
					<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual>
		</td>
		<td width="160"><bean:message key="app.circle" /></td>
		<td width="150">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode" onchange="javascript: fnGetOffices(this)" 
							 styleClass="combo" disabled="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="thin-text-box" 
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
	</tr>
	<tr>
		<td width="180"><bean:message key="app.division" /></td>
		<td width="160">
		<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:select property="divisionOfficeCode" onchange="javascript: fnGetOffices(this)"
						 styleClass="combo" disabled="true">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:text property="divisionOfficeName" styleClass="thin-text-box" 
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		<td width="160"><bean:message key="app.subdivision" /></td>
		<td width="150">
		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subdivisionOfficeCode" styleClass="combo"
						 onchange="javascript: fnGetOffices(this)" disabled="true">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" styleClass="thin-text-box" 
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
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
<logic:present name="pendingProposals">
<c:set var="pending" value="true" />
<fieldset>
<legend>Administrative Sanction Details</legend>
<label>
	<table>
	<tbody class="formTBody">
	<tr>
		<td width="180">Admn. Sanc. Proc. No.<span class="mandatory">*</span></td>
		<td width="160">
			<html:text property="adminNo" styleClass="thin-text-box" maxlength="20" onkeypress="upperOnly()"/>
		</td>
		<td width="160">Adminstrative Date<span class="mandatory">*</span></td>
		<td width="150">
			<html:text property="adminDate" styleClass="thin-text-box" maxlength="10" 
					   style="width:110px"/>
			<a href="javascript: showCalendar(document.AdminProposalForm.adminDate);">
				<img src="<rws:context page='/images/calendar.gif'/>" border="0" 
					 align="absmiddle">
			</a>
		</td>
	</tr>
	<tr>
		<td>GO No.<span class="mandatory">*</span></td>
		<td>
			<html:text property="goNo" styleClass="thin-text-box" onkeypress="upperOnly()"/>
		</td>
		<td>GO</td>
		<td><html:file property="govtOrder" styleClass="thin-text-box" /></td>
	</tr>
	<tr>
		<td>Sanctioning Authority</td>
		<td>
			<html:text property="sanctioningAuthority" styleClass="thin-text-box" maxlength="20" onkeypress="upperOnly()"/>
		</td>
		<td>Sanctioned At</td>
		<td>
			<html:select property="sanctionedAt" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<html:option value="C">CENTRE</html:option>
				<html:option value="S">STATE</html:option>
			</html:select>
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
<legend><bean:message key="legend.pendingProposals" /></legend>
<label>
	<table bgcolor="" border="1" bordercolor="black" align="center" width="750" 
		   cellpadding="0" cellspacing="0" style="border-collapse:collapse">
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
		<th><bean:message key="app.select" /></th>
		<th><bean:message key="app.workname" /></th>
		<th><bean:message key="app.proposalId" /></th>
		<th><bean:message key="app.proposalDate" /></th>
		<th><bean:message key="app.selectedHabs" /></th>
		<th><bean:message key="app.scheme" /></th>
		<th><bean:message key="app.programme" /></th>
		<th><bean:message key="app.subprogramme" /></th>
		<th><bean:message key="app.estimateCost" /></th>
		<th><bean:message key="app.sanctionedAmount"/>(Rs. in lakhs)</th>
		<th><bean:message key="app.otherDetails" /></th>
		<th><bean:message key="app.action" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="officeCode" value="" />
	<c:forEach items="${requestScope.pendingProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:set var="officeName" value="${item.officeName}" />
	<c:if test="${officeCode != item.officeCode}">
	<c:set var="officeCode" value="${item.officeCode}" />
	<tr bgcolor="lightyellow">
		<td colspan="12">
			<font size="-1" face="verdana">
			Proposals submitted from <c:out value="${item.officeName}" />
			</font>
		</td>
	</tr>
	</c:if>
	<tr class='<c:out value="row${index%2}"/>'>
		<td align="center" width="40">
			<input type="checkbox" name="sel" id="sub" value='<c:out value="${item.proposalId}"/>'
				   onclick="return checkMe(this)">
		</td>
		<td width="145" style="display:block;cursor:hand" 
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()">
			<c:out value="${item.proposalName}" />
		</td>
		
		<td align="center" width="85"><c:out value="${item.proposalId}" /></td>
		<td align="center" width="65"><c:out value="${item.proposalDate}" /></td>
		<td align="center" width="65"><c:out value="${item.noOfHabs}" />&nbsp;
			<input type="button" value="..." title="Show Selected Habs" class="btext" 
				name='<c:out value="${item.proposalId}"/>' onclick="javascript:fnShowHabs(this)">
		</td>
		<td align="left" width="60">
			&nbsp;<c:out value="${item.assetName}" />
			<input type="hidden" name="<c:out value='AC${item.proposalId}'/>" 
				   value="<c:out value='${item.assetCode}'/>">
		</td>

		<td align="left" width="70">
			&nbsp;<c:out value="${item.programmeName}" />
			<input type="hidden" name="<c:out value='PC${item.proposalId}'/>" 
				   value="<c:out value='${item.programmeCode}'/>">
		</td>

		<td align="left" width="70">
			&nbsp;<c:out value="${item.subprogrammeName}" />
		</td>

		<td align="right" width="60">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	  value="${item.estimateCost}" />&nbsp;
			<input type="hidden" name="<c:out value='EC${item.proposalId}'/>" 
			       value="<c:out value='${item.estimateCost}'/>">
		</td>
		<td align="right" width="75">
			<input type="text" name="<c:out value='${item.proposalId}_SA'/>"
				   value="<c:out value='${item.sanctionedAmount}'/>" 
				   class="thin-text-box" style="width:80px; text-align: right"
				   onkeypress="return decimalsOnly(event)"
				   onblur="fnCalculate(this)">

			<input type="hidden" name="<c:out value='SA${item.proposalId}'/>" 
				   value="<c:out value='${item.sanctionedAmount}'/>">
		</td>
		<td align="center" width="50">
			<input type="button" class="btext" value="..." name="<c:out value='${item.proposalId}' />"
				   onclick="javascript:fnShowOtherDetails(this)">
		</td>
		<td align="center" width="40">
			<input type="button" class="btext" value="Edit" name="<c:out value='${item.proposalId}' />" 
				   onclick="javascript:fnEditProposal(this)">
		</td>
	</tr>
	</c:forEach>
	</tbody>
	<tfoot>
	<tr bgcolor="#8A9FCD">
		<td colspan="12">
			<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th align="left">&nbsp;
					<a href="javascript: checkAll('sel','sub')" id="white">Check All</a>
					<a href="javascript: clearAllSanc('sel','sub')" id="white">Clear All</a>
				</th>
				<th class="label" align="right">
					<b>No. of Pending Proposals:&nbsp;<c:out value="${index+1}"/>&nbsp;</b>
				</th>
			</tr>
			</table>
		</td>
	</tr>
	</tfoot>
	</table>
</label>
</fieldset>
</td>
</tr>

<tr>
<td>
<fieldset>
<legend>Amount details</legend>
<label>
	<table>
	<tbody class="formTBody">
	<tr>
		<td width="180">Estimate Cost(Consolidated)</td>
		<td class="column2">
			<html:text property="estimateCost" readonly="true" styleClass="thin-text-box"/>
		</td>
		<td class="column3">Sanctioned Amount(Consolidated)</td>
		<td class="column4">
			<html:text property="sanctionedAmount" readonly="true" styleClass="thin-text-box"/>
		</td>
	</tr>
	</tbody>
	</table>
</label>
</fieldset>
</td>
</tr>

<tr>
<td width="100%">
	<table width="100%">
	<tr>
	<td align="center">
		<c:if test="${RWS_USER.headOfOffice == 'true'}">
			<html:submit property="mode" styleClass="btext" onclick="return fnSave()">
				<bean:message key="button.save" />
			</html:submit>
			<html:reset property="mode" styleClass="btext">
			<bean:message key="button.clear" />
			</html:reset>
		</c:if>	
		<c:if test="${RWS_USER.headOfOffice == 'false'}">
			<html:submit property="mode" styleClass="btext" onclick="return fnSave()" disabled="true">
				<bean:message key="button.save" />
			</html:submit>
			<html:reset property="mode" styleClass="btext" disabled="true">
			<bean:message key="button.clear" />
			</html:reset>
		</c:if>	
	</td>
	</tr>
	</table>
</td>
</tr>
</logic:present>

<logic:present name="sanctionedProposals">
<c:set var="pending" value="true" />
<tr>
<td>
<fieldset>
<legend><bean:message key="legend.sanctionedProposals" /></legend>
<label>
	<table bgcolor="" border="1" bordercolor="black" align="center" width="750" 
		   cellpadding="0" cellspacing="0" style="border-collapse:collapse">
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
		<th><bean:message key="app.select" /></th>
		<th><bean:message key="app.workname" /></th>
		<th>Work Id</th>
		<th>Admn. Sanc.<br>Proc. No.</th>
		<th><bean:message key="app.adminDate" /></th>
		<th>GO No.</th>
		<th><bean:message key="app.scheme" /></th>
		<th><bean:message key="app.programme" /></th>
		<th><bean:message key="app.subprogramme" /></th>
		<th><bean:message key="app.sanctionedAmount" /></th>
		<th><bean:message key="app.otherDetails" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:forEach items="${requestScope.sanctionedProposals}" var="item" varStatus="status">	
	<c:set var="index" value="${status.index}"/>
		<tr class="<c:out value='row${index%2}'/>">
			<td align="center" width="40">
				<input type="checkbox" name="sel" id="sanc" value="<c:out value='${item.proposalId}'/>">
			</td>
			<td width="145"><c:out value="${item.proposalName}" />
			</td>
			<td align="center" width="82"><c:out value="${item.workId}" /></td>
			<td width="100"><c:out value="${item.adminNo}" /></td>
			<td align="center" width="60"><c:out value="${item.adminDate}" /></td>
			<td align="left" width="80">100</td>
			<td width="60">&nbsp;<c:out value="${item.assetName}" /></td>
			<td width="70">&nbsp;<c:out value="${item.programmeName}" /></td>
			<td width="70">&nbsp;<c:out value="${item.subprogrammeName}" /></td>
			<td align="right" width="80">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	  value="${item.sanctionedAmount}" />&nbsp;
			</td>
			<td align="center" width="50">
				<input type="button" class="btext" value="..." 
				name="<c:out value='${item.proposalId}'/>" 
			   	onclick="javascript:fnShowSanctionDetails(this)">
		</td>
		</tr>
		</c:forEach>
	</tbody>
	<tfoot>
	<tr bgcolor="#8A9FCD">
		<td colspan="12">
			<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th align="left">&nbsp;
					<a href="javascript: checkAll('sel','sanc')" id="white">Check All</a>
					<a href="javascript: clearAll('sel','sanc')" id="white">Clear All</a>
				</th>
				<th class="label" align="right">
					<b>No. of Sanctioned Proposals:&nbsp;<c:out value="${index+1}" />&nbsp;</b>
				</th>
			</tr>
			</table>
		</td>
	</tr>
	</tfoot>
	</table>
	<table>
	<tr>
	<logic:notEmpty name="AdminProposalForm" property="forwardTo">
		<td align="left">
			<input type="button" class="btext" name="cmbShowHideForward" style="width:75px" 
				   value="Forward" onclick="javascript:fnShowHideForward('sel','sanc')"
					<c:if test="${RWS_USER.headOfOffice == 'false'}">
					disabled = "disabled"
					</c:if>	
			>
		</td>
	</logic:notEmpty>
	<logic:empty name="AdminProposalForm" property="forwardTo">
		<td align="left">
			<input type="button" class="btext" name="cmbShowHideForward" style="width:75px" 
			value="Forward" disabled="true">
		</td>
	</logic:empty>
	</tr>
	</table>
</label>
</fieldset>
</td>
</tr>
</logic:present>

<logic:present name="forwardedProposals">
<c:set var="pending" value="true" />
<tr>
<td>
<fieldset>
<legend><bean:message key="legend.forwardedProposals" /></legend>
<label>
	<table bgcolor="" border="1" bordercolor="black" align="center" width="750" 
		   cellpadding="0" cellspacing="0" style="border-collapse:collapse">
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
		<th><bean:message key="app.select" /></th>
		<th><bean:message key="app.workname" /></th>
		<th>Work Id</th>
		<th nowrap>Admn. Sanc.<br>Proc. No.</th>
		<th>Admin. Date</th>
		<th>GO No.</th>
		<th><bean:message key="app.scheme" /></th>
		<th><bean:message key="app.programme" /></th>
		<th><bean:message key="app.subprogramme" /></th>
		<th><bean:message key="app.sanctionedAmount" /></th>
		<th><bean:message key="app.otherDetails" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="officeCode" value="" />
	<c:forEach items="${requestScope.forwardedProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:set var="officeName" value="${item.officeName}" />
	<c:if test="${officeCode != item.officeCode}">
	<c:set var="officeCode" value="${item.officeCode}" />
	<tr bgcolor="lightyellow">
		<td colspan="12">
			<font size="-1" face="verdana">
			Proposals forwarded from <c:out value="${item.officeName}" />
			</font>
		</td>
	</tr>
	</c:if>
	<tr class="<c:out value='row${index%2}'/>">
		<td align="center">
			<input type="checkbox" name="sel" id="fwd" 
				   value="<c:out value='${item.proposalId}'/>">
		</td>
		<td style="display:block;cursor:hand" 
				onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
				onmouseout="hideddrivetip()">
				<c:out value="${item.proposalName}" />
		</td>
		<td align="center"><c:out value="${item.workId}"/></td>
		<td align="center"><c:out value="${item.adminNo}"/></td>
		<td align="center"><c:out value="${item.adminDate}"/></td>
		<td align="center"><c:out value="${item.goNo}"/></td>
		<td width="60">&nbsp;<c:out value='${item.assetName}'/></td>
		<td width="70">&nbsp;<c:out value='${item.programmeName}'/></td>
		<td width="70">&nbsp;<c:out value='${item.subprogrammeName}'/></td>
		<td align="right" width="80">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	  value="${item.sanctionedAmount}" />&nbsp;
		</td>
		<td align="center" width="50">
		<input type="button" class="btext" value="..." name="<c:out value='${item.proposalId}'/>" 
			   onclick="javascript:fnShowSanctionDetails(this)">
		</td>
	</tr>
	</c:forEach>
	</tbody>
	<tfoot>
	<tr bgcolor="#8A9FCD">
		<td colspan="12">
			<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th align="left">&nbsp;
					<a href="javascript: checkAll('sel','fwd')" id="white">Check All</a>
					<a href="javascript: clearAll('sel','fwd')" id="white">Clear All</a>
				</th>
				<th class="label" align="right">
					<b>No. of Forwarded Proposals:&nbsp;<c:out value="${index+1}"/></b>
				</th>
			</tr>
			</table>
		</td>
	</tr>
	</tfoot>
	</table>
	<table width="100%">
	<tr>
	<c:set var="officeType" value="${sessionScope.RWS_USER.officeName}" />
	
	<c:if test="${officeType == 'Head Office'}">
	<logic:notEmpty name="AdminProposalForm" property="forwardTo">
	<td align="left">
		<input type="button" class="btext" name="cmbShowHideForward" style="width:75px" 
		value="Forward" onclick="javascript:fnShowHideForward('sel','fwd')"
			<c:if test="${RWS_USER.headOfOffice == 'false'}">
				disabled = "disabled"
			</c:if>
		>
	</td>
	</logic:notEmpty>
	<logic:empty name="AdminProposalForm" property="forwardTo">
	
	<td align="left">
		<input type="button" class="btext" name="cmbShowHideForward" style="width:75px" 
		value="Forward" disabled="disabled">
	</td>
	</logic:empty>
	</c:if>
	
	<c:set var="officeType" value="${sessionScope.RWS_USER.officeName}" />
	<c:if test="${officeType == 'Division Office'}">
	<td align="right">
		<c:if test="${RWS_USER.headOfOffice == 'true'}">
			<html:submit property="mode" styleClass="btext" style="width:200px" >
				  Send to Source Investigation
			</html:submit>
		</c:if>	
		<c:if test="${RWS_USER.headOfOffice == 'false'}">
			<html:submit property="mode" styleClass="btext" style="width:200px" disabled="true">
				  Send to Source Investigation
			</html:submit>
		</c:if>	
	</td>
	</c:if>
	</tr>
	</table>
</label>
</fieldset>
</td>
</tr>
</logic:present>

<tr bgcolor="#DEE3E0" id="forwardPanel" style="display:none">
<td>
<fieldset>
<legend><bean:message key="legend.forwardSubmit" /></legend>
<label>
	<table align="left" border=0>
	<tbody class="formTBody">
	<c:set var="officeType" value="${sessionScope.RWS_USER.officeName}" />
	<c:if test="${officeType != 'Head Office'}">
	<logic:notEmpty name="AdminProposalForm" property="forwardTo">
	<tr>
		<td><bean:message key="app.forwardTo" /><span class="mandatory">*</span></td>
		<td>:</td>
		<td colspan="4">
			<span style="font-weight:normal;">
				<html:text property="forwardOffice" styleClass="thin-text-box" readonly="true" style="width:400px"/>
				<html:hidden property="forwardTo" />
				<html:hidden property="actionTo" />
				<input type="button" value='Select <bean:write name="AdminProposalForm" property="forwardOffice"/>'
					   onclick="javascript:fnShowOffices(this)" class="btext">
			</span>
		</td>
	</tr>
	</logic:notEmpty>
	</c:if>
	<c:set var="officeType" value="${sessionScope.RWS_USER.officeName}" />
	<c:if test="${officeType == 'Head Office'}">
	
	<logic:notEmpty name="AdminProposalForm" property="forwardTo">
	<tr>
		<td><bean:message key="app.forwardTo" /><span class="mandatory">*</span></td>
		<td>:</td>
		<td colspan="4">
			<span style="font-weight:normal;">
				<html:text property="forwardOffice" styleClass="thin-text-box" readonly="true" style="width:400px"/>
				<html:hidden property="forwardTo" />
				<html:hidden property="actionTo" />
				<input type="button" value="Select Circle"
					   onclick="javascript:fnShowOffices(this)" class="btext" style="width:160px">
			</span>
		</td>
	</tr>
	</logic:notEmpty>
	<tr>
		<td><bean:message key="app.forwardTo" /><span class="mandatory">*</span></td>
		<td>:</td>
		<td colspan="4">
			<span style="font-weight:normal;">
				<html:text property="forwardDivisionOffice" styleClass="thin-text-box" readonly="true" style="width:400px"/>
				<html:hidden property="forwardToDivision" />
				<html:hidden property="actionToToDivision" />
				<input type="button" value='Select Division'
					   onclick="javascript:fnShowDivisionOffices(this)" class="btext" style="width:160px">
			</span>
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.forwardTo" /><span class="mandatory">*</span></td>
		<td>:</td>
		<td colspan="4">
			<span style="font-weight:normal;">
				<html:text property="forwardSubDivisionOffice" styleClass="thin-text-box" readonly="true" style="width:400px"/>
				<html:hidden property="forwardToSubDivision" />
				<html:hidden property="actionToSubDivision" />
				<input type="button" value='Select SubDivision'
					   onclick="javascript:fnShowSubDivisionOffices(this)" class="btext" style="width:160px">
			</span>
		</td>
	</tr>
	</label>
	</c:if>
	<tr>
		<td><bean:message key="app.memoNo" /><span class="mandatory">*</span></td>
		<td>:</td>
		<td>
			<html:text property="memoNo" maxlength="15" styleClass="thin-text-box" 
					   onkeypress="return textOnly(event)"/>
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.date" /><span class="mandatory">*</span></td>
		<td>:</td>
		<td>
			<html:text property="forwardDate" maxlength="10" styleClass="thin-text-box" />
			<a href="javascript: showCalendar(document.AdminProposalForm.forwardDate);">
					<img src="<rws:context page='/images/calendar.gif'/>" 
							 border="0" align="absmiddle">
			</a>
		</td>
	</tr>	
	<tr>
		<td><bean:message key="app.subject" /><span class="mandatory">*</span></td>
		<td>:</td>
		<td colspan="4">
			<html:text property="forwardSubject" size="100" maxlength="100" styleClass="thin-text-box" 
					   onkeypress="return textOnly(event)" />
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.ref" /></td>
		<td>:</td>
		<td colspan="4">
			<html:text property="forwardRef" size="70" maxlength="50" styleClass="thin-text-box" 
						onkeypress="return textOnly(event)"/>
		</td>
	</tr>
	<tr>
		<td valign="top"><bean:message key="app.content" /><span class="mandatory">*</span></td>
		<td valign="top">:</td>
		<td colspan="4">
			<html:textarea property="forwardContent" rows="5" cols="75" styleClass="thin-text-box" 
						   onkeypress="return textOnly(event)" />
			
		</td>
	</tr>
	<tr>
		<td colspan="3" align="center">
			<html:button property="mode" styleClass="btext" 
					onclick="return validateForward(this.form)">
				<bean:message key="button.send" />
			</html:button>
		</td>
	</tr>
	</tbody>
	</table>
</label>
</fieldset>
</td>
</tr>
<c:if test="${pending == false}">
<tr>
<td>
	<table>
	<tbody class="formTBody">
	<tr>
		<td><font color="blue">There are no proposals in this office</font></td>
	</tr>
	</tbody>
	</table>
</td>
</tr>
</c:if>

</table>
</td>
</tr>
</tbody>
</table>
<html:hidden property="officeCode"name="RWS_USER" />
<html:hidden property="userId"name="RWS_USER" />
</html:form>
<%@ include file="/commons/rws_tooltip.jsp" %>
<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />