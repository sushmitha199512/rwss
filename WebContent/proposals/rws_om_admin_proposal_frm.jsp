<%@ include file="/commons/rws_header1.jsp" %>

<script language="JavaScript">
<!--
function fnShowHideForward(elem,id)
{
	var msg = "Please select atleast one proposal to forward.";
	var forwardPanel = document.getElementById("forwardPanel");

	if(forwardPanel.style.display == "none" && isSelected(elem, id, msg))
	{	
		if(forwardPanel.style.display == "none")
			forwardPanel.style.display = "block";
		else
		if(forwardPanel.style.display == "block")
			forwardPanel.style.display = "none";
	}
	else
	{
		if(forwardPanel.style.display == "block")
		{	forwardPanel.style.display = "none";
		}
	}
}

function fnGetOffices(that)
{
	var field = that.name;
	var frm = that.form;
	
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/OMAdminProposalData.do"
			+ "&mode=headoffice";
	else
	if(field == 'circleOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/OMAdminProposalData.do"
			+ "&mode=circle";
	else
	if(field == 'divisionOfficeCode')	
		url = "switch.do?prefix=/proposals&page=/OMAdminProposalData.do"
			+ "&mode=division";		
	else
	if(field == 'subdivisionOfficeCode')	
		url = "switch.do?prefix=/proposals&page=/OMAdminProposalData.do"
			+ "&mode=subdivision";		

	frm.action = url;
	frm.submit();
}


function fnShowOffices(that)
{
	var officeCode = document.getElementById("actionTo").value;
	var url = "switch.do?prefix=/proposals&page=/ShowForwardOffices.do&officeCode="+officeCode;
	var properties = "width=300,height=250,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
}

function fnEditProposal(that)
{
	var frm = that.form;
	
	var omProposalId = that.name;
	var url="switch.do?prefix=/proposals&page=/EditOMAdminProposal.do&mode=Edit&omProposalId="+omProposalId;
	frm.action = url;
	frm.submit();
}

function fnShowHabs(proposalId)
{
	var j = proposalId.name.substring(3,15);
	var newWindow = window.open("switch.do?prefix=/proposals&page=/showHabs.jsp?proposalId="+j, 
	"","width=648,height=332");
	newWindow.moveTo(10,10);
}

function fnShowSanctionDetails(that)
{
	var frm = that.form;
	var proposalId = that.name;
	
	var url = "switch.do?prefix=/proposals&page=/ShowSanctionDetails.do"
			+ "&type=om&proposalId="+proposalId;
	
	var properties = "width=393,height=239,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"", properties)		
}

function validateForward(frm)
{
	if(validateForwardForm(frm))
	{
		var url = "switch.do?prefix=/proposals&page=/OMAdminProposal.do&mode=Forward";
		frm.action = url;
		frm.submit();
	}
}

function fnCalculate(that)
{
	var proposalId = that.name.substring(0,20);
	
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
	
	frm = that.form;
	var id = that.name;
	var proposalId = that.value;
	var programmes = frm.elements("PC"+proposalId);
	var programmeLength = 0;
	if(programmes)
	{
		if(typeof programmes.length != 'number')
			programmes = [programmes];
			
		programmeLength = programmes.length;	
	}
	var programmeCode = "";
	
	var estimateCost = document.getElementById("EC"+proposalId).value;
	var sanctionedAmount = document.getElementById(proposalId+"_SA").value;
	sanctiondedAmount = parseFloat(sanctionedAmount);
	if(isNaN(sanctionedAmount))
		sanctionedAmount = "0.00";
	
	if(that.checked)
	{
		var message =  "You cannot select this Proposal\n"; 
		var isAllowed = true;	
		var programmeValue = "";
		for(var i=0; i<programmeLength; i++)
		{
			programmeCode = programmes[i];
			programmeValue = programmeCode.value;
			if(programmeValue == "" || programmeValue == "00")
			{	isAllowed = false;
			}
		}
		if(!isAllowed)
			message += "Programme is not specified\n";
			
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
			alert(message);
			return false;
		}
		
		if(isPositiveDecimal(frm.estimateCost))
		{
			var eAmount = frm.estimateCost.value;
			if(eAmount.length < 1)
				eAmount = 0;
			eAmount = parseFloat(eAmount) + parseFloat(estimateCost); 
			frm.estimateCost.value = eAmount.toFixed(2);
		}
		
		if(isPositiveDecimal(frm.sanctionedAmount))
		{
			var sAmount = frm.sanctionedAmount.value;
			if(sAmount.length < 1)
				sAmount = 0;
			sAmount = parseFloat(sAmount) + parseFloat(sanctionedAmount); 
			frm.sanctionedAmount.value = sAmount.toFixed(2);
		}
			
		return true;
	}
	
	else
	{
		if(isPositiveDecimal(frm.estimateCost))
		{
			var eAmount = frm.estimateCost.value;
			if(eAmount.length < 1)
				eAmount = 0;
			eAmount = parseFloat(eAmount) - parseFloat(estimateCost); 
			frm.estimateCost.value = eAmount.toFixed(2);
			//frm.estimateCost.value = "";
		}
		
		if(isPositiveDecimal(frm.sanctionedAmount))
		{
			var sAmount = frm.sanctionedAmount.value;
			if(sAmount.length < 1)
				sAmount = 0;
			sAmount = parseFloat(sAmount) - parseFloat(sanctionedAmount); 
			frm.sanctionedAmount.value = sAmount.toFixed(2);
			//frm.sanctionedAmount.value = "";
		}
		return true;
	}

}
function checkAllSanc(elem, id)
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
			if( checkCollection[i].id == id && !checkCollection[i].checked)
			{
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

function fnSave(that)
{
	if(validateOMAdminProposalForm(that.form))
	{
		if(isSelected('sel', 'sub', 'Please select atleast one proposal to sanction.'))
			return true;
	}
	return false;
}
//-->
</script>
<html:javascript formName="OMAdminProposalForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/OMAdminProposal" method="POST" enctype="multipart/form-data">
<table align="center" cellpadding="0" cellspacing="0">

<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="O&M Proposals - Administrative Sanction Form" />
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

<c:set var="pending" value="false" />

<tbody>
<tr>
<td>
<table width="100%" bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" 
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
							 styleClass="combo">
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
						 styleClass="combo">
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
						 onchange="javascript: fnGetOffices(this)">
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
<logic:present name="pendingProposals">
<c:set var="pending" value="true" />	
<tr>
<td>
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
			<html:text property="adminDate" styleClass="thin-text-box" maxlength="10" style="width:110px"/>
				<a href="javascript: showCalendar(document.OMAdminProposalForm.adminDate);">
					<img src="<rws:context page='/images/calendar.gif'/>" border="0" 
						 align="absmiddle">
				</a>
			</td>
		</tr>
		<tr>
			<td width="180">GO No.<span class="mandatory">*</span></td>
			<td width="160">
				<html:text property="goNo" styleClass="thin-text-box" onkeypress="upperOnly()"/>
			</td>
			<td width="160">GO</td>
			<td width="150">
				<html:file property="govtOrder" styleClass="thin-text-box" />
			</td>
		</tr>
		<tr>
			<td width="180">Sanctioning Authority</td>
			<td width="160">
				<html:text property="sanctioningAuthority" styleClass="thin-text-box" maxlength="20"  
						   onkeypress="upperOnly()"/>
			</td>
			<td width="160">Sanctioned At</td>
			<td width="150">
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
	<table bgcolor="#DEE3E0" border="1" bordercolor="black" align="center" width="750" 
		   cellpadding="0" cellspacing="0" style="border-collapse:collapse">
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
		<th><bean:message key="app.select" /></th>
		<th><bean:message key="app.proposalId" /></th>
		<th><bean:message key="app.assetName" /></th>
		<th><bean:message key="app.proposalDate" /></th>
		<th><bean:message key="app.programme" />
			/<bean:message key="app.subprogramme" />
		</th>
		<th><bean:message key="app.financialYear" /></th>
		<th><bean:message key="app.estimateCost" /></th>
		<th><bean:message key="app.sanctionedAmount"/></th>
		<th><bean:message key="app.action" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="officeCode" value="" />
	<c:forEach items="${requestScope.pendingProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:if test="${officeCode != item.officeCode}" >	
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
		<td align="center">
			<input type="checkbox" name="sel" id="sub" value="<c:out value='${item.proposalId}'/>"
				   onclick="return checkMe(this)">
		</td>
		<td width="125px" style="display:block;cursor:hand" 
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()">
				<c:out value="${item.proposalId}" />
		</td>
		<td width="150px"><c:out value="${item.assetName}"/></td>
		<td align="center" width="65">
			<c:out value="${item.proposalDate}"/>
		</td>
		<td align="left">
			<c:set var="programmes" value="${item.programmes}" />
			<c:forEach items="${programmes}" var="programmeBean"> 
				<input type="hidden" name="<c:out value='PC${item.proposalId}'/>" 
				   value="<c:out value='${programmeBean.programmeCode}'/>">
				<c:out value="${programmeBean.programmeName}" />
				<c:if test="${not empty programmeBean.subprogrammeName}">
				/&nbsp;<c:out value="${programmeBean.subprogrammeName}"/>
				</c:if>
				<br>
			</c:forEach>
			<c:if test="${empty programmes}">
				<input type="hidden" name="<c:out value='PC${item.proposalId}'/>"
					   value="00">
			</c:if>
		</td>
		
		<td align="center"><c:out value="${item.financialYear}" /></td>
		<td align="right">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	  value="${item.estimateCost}" />&nbsp;
			<input type="hidden" name="<c:out value='EC${item.proposalId}'/>" 
			       value="<c:out value='${item.estimateCost}'/>">
		</td>
		<td width="72">
			<input type="text" name="<c:out value='${item.proposalId}_SA'/>"
				   value="<c:out value='${item.sanctionedAmount}'/>" 
				   class="thin-text-box" style="width:75px; text-align: right"
				   onkeypress="return decimalsOnly(event)"
				   onblur="fnCalculate(this)">	
			<input type="hidden" name="<c:out value='SA${item.proposalId}'/>" 
				   value="<c:out value='${item.sanctionedAmount}'/>">	
		</td>
		<td align="center">
		<input type="button" class="btext" name='<c:out value="${item.proposalId}"/>'
				onclick="javascript: fnEditProposal(this)" value="Edit"
				<c:if test="${RWS_USER.headOfOffice == 'false'}">
				disabled = "disabled"
				</c:if>
			>
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
				<a href="javascript: checkAllSanc('sel','sub')" id="white">Check All</a>
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
		<td width="160"><html:text property="estimateCost" readonly="true" styleClass="thin-text-box"/></td>
		<td width="160">Sanctioned Amount(Consolidated)</td>
		<td width="150"><html:text property="sanctionedAmount" readonly="true" styleClass="thin-text-box"/></td>
	</tr>
	</tbody>
	</table>
	</label>
	</fieldset>
</td>
</tr>

<tr>
<td colspan="4" align="center">
		<c:if test="${RWS_USER.headOfOffice == 'true'}">
		<html:submit property="mode" styleClass="btext" 
			onclick="return fnSave(this)">
			<bean:message key="app.save" />
		</html:submit>
		<html:reset value="Reset" styleClass="btext"/>
		</c:if>
		<c:if test="${RWS_USER.headOfOffice == 'false'}">
		<html:submit property="mode" styleClass="btext" disabled="true"
			onclick="return fnSave(this)">
			<bean:message key="app.save" />
		</html:submit>
		<html:reset value="Reset" styleClass="btext" disabled="true"/>
		</c:if>
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
	<table bgcolor="#DEE3E0" border="1" bordercolor="black" align="center" width="750" cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th>Work Id</th>
			<th><bean:message key="app.assetName" /></th>
			<th nowrap>Admn. Sanc.<br>Proc. No.</th>
			<th><bean:message key="app.adminDate" /></th>
			<th nowrap>GO No.</th>
			<th><bean:message key="app.programme" />
				/<bean:message key="app.subprogramme" />
			</th>
			<th><bean:message key="app.sanctionedAmount" /></th>
			<th><bean:message key="app.otherDetails" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:forEach items="${requestScope.sanctionedProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<tr class='<c:out value="row${index%2}"/>'>
		<td align="center" width="40">
			<input type="checkbox" name="sel" id="sanc" value='<c:out value="${item.proposalId}"/>'>
		</td>
		<td align="center" width="125"><c:out value="${item.workId}" /></td>
		<td width="145"><c:out value="${item.assetName}" /></td>
		<td width="100"><c:out value="${item.adminNo}" /></td>
		<td align="center" width="60"><c:out value="${item.adminDate}" /></td>
		<td width="60"><c:out value="${item.goNo}" /></td>
		<td>
			<c:set var="programmes" value="${item.programmes}" />
			<c:forEach items="${programmes}" var="programmeBean"> 
				<c:out value="${programmeBean.programmeName}" />
				<c:if test="${not empty programmeBean.subprogrammeName}">
				/&nbsp;<c:out value="${programmeBean.subprogrammeName}"/>
				</c:if>
				<br>
			</c:forEach>
		</td>	
		<td align="right" width="73">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	  value="${item.sanctionedAmount}" />
		</td>
		<td align="center" width="47">
			<input type="button" class="btext" value="..." 
				   name='<c:out value="${item.proposalId}" />'
				   onclick="javascript:fnShowSanctionDetails(this)">
		</td>
	</tr>
	</c:forEach>
	</tbody>
	<tfoot>
	<tr bgcolor="#8A9FCD">
	<td colspan="10">
		<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th align="left">&nbsp;
				<a href="javascript: checkAll('sel','sanc')" id="white">Check All</a>
				<a href="javascript: clearAll('sel','sanc')" id="white">Clear All</a>
			</th>
			<th class="label" align="right">
				<b>No. of Sanctioned Proposals:&nbsp;<c:out value="${index+1}"/>&nbsp;</b>
			</th>
		</tr>
		</table>
	</td>
	</tr>
	</tfoot>
	</table>
	<table width="100%">
	<tr>
	<logic:notEmpty name="OMAdminProposalForm" property="forwardTo">
		<td align="left">
			<input type="button" class="btext" name="cmbShowHideForward" style="width:75px" 
			value="Forward" onclick="javascript:fnShowHideForward('sel','sanc')"
			<c:if test="${RWS_USER.headOfOffice == 'false'}">
				disabled = "disabled"
			</c:if>
			>
		</td>
	</logic:notEmpty>
	<logic:empty name="OMAdminProposalForm" property="forwardTo">
		<td align="left">
			<input type="button" class="btext" name="cmbShowHideForward" style="width:75px" 
			value="Forward" onclick="javascript:fnShowHideForward('sel','sanc')"
			disabled="disabled">
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
	<legend><bean:message  key="legend.forwardedProposals" /></legend>
	<label>
	<table bgcolor="" border="1" bordercolor="black" align="center" width="700" 
		   cellpadding="0" cellspacing="0" style="border-collapse:collapse">
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th>Work Id</th>
			<th><bean:message key="app.assetName" /></th>
			<th nowrap>Admn. Sanc.<br>Proc. No.</th>
			<th><bean:message key="app.adminDate" /></th>
			<th nowrap>GO No.</th>
			<th><bean:message key="app.programme" />
				/<bean:message key="app.subprogramme" />
			</th>
			<th><bean:message key="app.sanctionedAmount" /></th>
			<th><bean:message key="app.otherDetails" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="officeCode" value="" />
	<c:forEach items="${requestScope.forwardedProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
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
	<tr class='<c:out value="row${index%2}"/>'>
		<td align="center" width="40">
			<input type="checkbox" name="sel" id="fwd" value='<c:out value="${item.proposalId}"/>'>
		</td>
		<td width="145" style="display:block;cursor:hand" onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()"><c:out value="${item.assetName}" /></td>	
		<td align="center" width="125"><c:out value="${item.workId}" /></td>
		<td width="100"><c:out value="${item.adminNo}" /></td>
		<td align="center" width="60"><c:out value="${item.adminDate}" /></td>
		<td width="60"><c:out value="${item.goNo}" /></td>
		<td>
			<c:set var="programmes" value="${item.programmes}" />
			<c:forEach items="${programmes}" var="programmeBean"> 
				<c:out value="${programmeBean.programmeName}" />
				<c:if test="${not empty programmeBean.subprogrammeName}">
				/&nbsp;<c:out value="${programmeBean.subprogrammeName}"/>
				</c:if>
				<br>
			</c:forEach>
		</td>	
		<td align="right" width="73">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	  value="${item.sanctionedAmount}" />&nbsp;
		</td>
		<td align="center" width="47">
			<input type="button" class="btext" value="..." 
				   name='<c:out value="${item.proposalId}" />'
				   onclick="javascript:fnShowSanctionDetails(this)">
		</td>
	</tr>
	</c:forEach>
	</tbody>
	<tfoot>
	<tr bgcolor="#8A9FCD">
	<td colspan="10">
		<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th align="left">&nbsp;
				<a href="javascript: checkAll('sel','fwd')" id="white">Check All</a>
				<a href="javascript: clearAll('sel','fwd')" id="white">Clear All</a>
			</th>
			<th class="label" align="right">
				<b>No. of Forwarded Proposals:&nbsp;<c:out value="${index+1}"/>&nbsp;</b>
			</th>
		</tr>
		</table>
	</td>
	</tr>
	</tfoot>
	</table>
	<table width="100%">
	<tr>
	<logic:notEmpty name="OMAdminProposalForm" property="forwardTo">
		<td align="left">
			<input type="button" class="btext" name="cmbShowHideForward" style="width:75px" 
		   		   value="Forward" onclick="javascript:fnShowHideForward('sel','fwd')"
				<c:if test="${RWS_USER.headOfOffice == 'false'}">
				disabled = "disabled"
				</c:if>
			>
		</td>
	</logic:notEmpty>
	<logic:empty name="OMAdminProposalForm" property="forwardTo">
		<td align="left">
			<input type="button" class="btext" name="cmbShowHideForward" style="width:75px" 
			value="Forward" onclick="javascript:fnShowHideForward('sel','fwd')"
					disabled="disabled">
		</td>
	</logic:empty>	
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
		<legend><bean:message key="legend.forward" /></legend>
		<label>
		<table align="left">
		<tbody class="formTBody">
		<tr>
			<td><bean:message key="app.forwardTo" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td colspan="4">
				<span style="font-weight:normal;">
					<html:text property="forwardOffice" styleClass="thin-text-box" readonly="true" style="width:400px"/>
					<html:hidden property="forwardTo" />
					<html:hidden property="actionTo" />
					<input type="button" style="width:150px" 
						   value='Select <bean:write name="OMAdminProposalForm" property="forwardOffice"/>' onclick="javascript:fnShowOffices(this)" class="btext">
				</span>
			</td>
		</tr>
		<tr>
			<td><bean:message key="app.memoNo" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td>
				<html:text property="memoNo" maxlength="15" styleClass="thin-text-box" 
						   onkeypress="return textOnly(event)" />
			</td>
		</tr>
		<tr>
			<td><bean:message key="app.date" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td>
				<html:text property="forwardDate" maxlength="10" styleClass="thin-text-box" 
						   size="14" />
				<a href="javascript: showCalendar(document.OMAdminProposalForm.forwardDate);">
					<img src="<rws:context page='/images/calendar.gif'/>" 
							 border="0" align="absmiddle">
				</a>		   
			</td>
		</tr>
		<tr>
			<td><bean:message key="app.subject" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td colspan="4">
				<html:text property="forwardSubject" size="95" maxlength="100" styleClass="thin-text-box"
						   onkeypress="return textOnly(event)" />
			</td>
		</tr>
		<tr>
			<td><bean:message key="app.ref" /></td>
			<td>:</td>
			<td colspan="4">
				<html:text property="forwardRef" size="70" maxlength="50" styleClass="thin-text-box" 
						   onkeypress="return textOnly(event)" />
			</td>
		</tr>
		<tr>
			<td valign="top">
				<bean:message key="app.content" /><span class="mandatory">*</span>
			</td>
			<td valign="top">:</td>
			<td colspan="3">
				<html:textarea property="forwardContent" rows="5" cols="71" styleClass="thin-text-box" 
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
</table>
<html:hidden name="RWS_USER" property="officeCode" />
<html:hidden name="RWS_USER" property="userId" />
</html:form>

<%@ include file="/commons/rws_tooltip.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />