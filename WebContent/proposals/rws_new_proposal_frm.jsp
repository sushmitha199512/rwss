<%@ include file="/commons/rws_header1.jsp"%>
<script language="JavaScript">
<!--

function fnShowHideForward(elem, id)
{	
	var msg = "Please select atleast one proposal to forward.";
	var submitPanel = document.getElementById("submitPanel");
	var forwardPanel = document.getElementById("forwardPanel");
	var defferPanel = document.getElementById("defferPanel"); 
	if(forwardPanel.style.display == "none" && isSelected(elem, id, msg))
	{	
		if(forwardPanel.style.display == "none")
		{	
			forwardPanel.style.display = "block";
			submitPanel.style.display = "none";
			defferPanel.style.display = "none";
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

function fnShowHideSubmit(elem, id)
{	
	var msg = "Please select atleast one proposal to submit.";
	var submitPanel = document.getElementById("submitPanel");
	var forwardPanel = document.getElementById("forwardPanel");
	var defferPanel = document.getElementById("defferPanel"); 
			
	if(submitPanel.style.display == "none" && isSelected(elem, id, msg))
	{
		if(submitPanel.style.display == "none")
		{	
			submitPanel.style.display = "block";
			forwardPanel.style.display = "none";
			defferPanel.style.display = "none";
		}
		else
		if(submitPanel.style.display == "block")
		{	
			submitPanel.style.display = "none";
		}	
	}
	else
	{
		if(submitPanel.style.display == "block")
		{	submitPanel.style.display = "none";
		}
	}
}

function fnShowHideDeffer(elem, id)
{	
	var msg = "Please select atleast one proposal to defer/transmit.";
	var submitPanel = document.getElementById("submitPanel");
	var forwardPanel = document.getElementById("forwardPanel");
	var defferPanel = document.getElementById("defferPanel"); 
	
	if(defferPanel.style.display == "none" && isSelected(elem, id, msg))
	{
		if(defferPanel.style.display == "none")
		{	
			defferPanel.style.display = "block";
			submitPanel.style.display = "none";
			forwardPanel.style.display = "none";
		}
		else
		if(defferPanel.style.display == "block")
		{	
			defferPanel.style.display = "none";
		}
	}
	else
	{
		if(defferPanel.style.display == "block")
		{	defferPanel.style.display = "none";
		}
	}
}

function fnGetOffices(that)
{
	form = that.form;
	form.action = "switch.do?prefix=/proposals&page=/NewProposalData.do";
	form.submit();
}

function fnShowHabs(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/ShowSelectedHabs.do?proposalId="+proposalId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}

function fnShowOtherDetails(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/ShowOtherDetails.do?proposalId="+proposalId
	var properties = "width=420,height=330,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
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
	var proposalId = that.name;
	var url = "switch.do?prefix=/proposals&page=/NewProposalEditData.do&type=ord&proposalId="+proposalId;
	var frm = that.form;
	frm.action = url;
	frm.submit();
}
function fnEditConsiderProposal(that)
{
	var proposalId = that.name;
	var url = "switch.do?prefix=/proposals&page=/EditRepProposal.do&mode=Edit&type=cons&proposalId="+proposalId;
	var frm = that.form;
	frm.action = url;
	frm.submit();
}
function checkMe(that)
{	
	
	form = that.form;
	var id = that.name;
	var proposalId = that.value;
	//alert(proposalId);
	var estimateCost = document.getElementById("EC"+proposalId).value;
	
	if(that.checked)
	{
		//alert("In checked");
		
		var message =  "You cannot select this Proposal\n"; 
		var isAllowed = true;	
		
		if(estimateCost == "" || estimateCost == "0")
		{	isAllowed = false;
			message += "Estimate Cost is not specified\n";
		}
				
		message += "\nClick the Edit button and enter the data!";
		if(!isAllowed)
		{
			alert(message);
			return false;
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
			//alert("checkCollection.id:   " + checkCollection[i].id);
			if( checkCollection[i].id == id)
			{
				if(!checkCollection[i].checked)
				checkCollection[i].click();
			}
		}
	}
}

function fnShowExsting(frm)
{
        var officeCode = frm.officeCode.value;
  		var url = "switch.do?prefix=/proposals&page=/NewProposalAction.do&mode=Existing&officeCode="+officeCode;
	    var properties = "width=784,height=412,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	    var newWindow = window.open(url, "", properties);
    	newWindow.moveTo(95,145);
   
}

function fnShowSources(frm)
{
        var officeCode = frm.officeCode.value;
  		var url = "switch.do?prefix=/proposals&page=/NewProposalAction.do&mode=sources&officeCode="+officeCode;
	    var properties = "width=424,height=212,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	    var newWindow = window.open(url, "", properties);
    	newWindow.moveTo(200,165);
   
}

function validateDeffer(frm)
{
	var field = frm.actionType.value;
	if(field == "" || field.length == 0)
	{
		alert("Action is Required");
	}
	else
	{
		var url = "switch.do?prefix=/proposals&page=/NewProposalAction.do&mode=Others";
		frm.action = url;
		frm.submit();
	}	
}
function validateSubmit(frm)
{
	//validateSubmitForm(frm);
	
	if(validateSubmitForm(frm))
	{
		var url = "switch.do?prefix=/proposals&page=/NewProposalAction.do&mode=Submit";
		frm.action = url;
		frm.submit();
	}

}
function validateForward(frm)
{
	if(validateForwardForm(frm))
	{
		var url = "switch.do?prefix=/proposals&page=/NewProposalAction.do&mode=Forward";
		frm.action = url;
		frm.submit();
	}
}
function fnConsiderForSanction(frm)
{
	if(isSelected('sel', 'sub', 'Please select atleast one proposal to consider for sanction.'))
	{
		var url = "switch.do?prefix=/proposals&page=/NewProposalAction.do&mode=Consider for Sanction";
		frm.action = url;
		frm.submit();	
	}
}

//-->
</script>

<%@ include file="/commons/rws_header2.jsp"%>
<html:form action="/NewProposalAction">
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Manage New Proposals" />
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
<c:set var="pending" value="false"/>
<tbody>
<tr>
<td>
<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
<tr>
<td>
<fieldset>
<legend><bean:message key="legend.rwsOffices" /></legend>
<label>
	<table width="100%">
	<tbody class="formTBody">
	<tr>
		<td class="column1"><bean:message key="app.headoffice" /></td>
		<td class="column2">
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
		<td class="column3"><bean:message key="app.circle" /></td>
		<td class="column4">
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
		<td class="column1"><bean:message key="app.division" /></td>
		<td class="column2">
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
		<td class="column3"><bean:message key="app.subdivision" /></td>
		<td class="column4">
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

<logic:present name="representativeProposals">
<c:set var="pending" value="true" />
<tr>
<td>
<fieldset>
<legend><bean:message key="legend.representativeProposals" /></legend>
<label>
<table bgcolor="#DEE3E0" border="1" bordercolor="black" width="750" cellpadding="0" 
	   cellspacing="0" style="border-collapse:collapse;" >
<thead class="gridHeader">
<tr bgcolor="#8A9FCD">
		<th><bean:message key="app.select" /></th>
		<th><bean:message key="app.workname" /></th>
		<th><bean:message key="app.proposalid" /></th>
		<th><bean:message key="app.proposaldate" /></th>
		<th><bean:message key="app.selectedhabs" /></th>
		<th><bean:message key="app.scheme" /></th>
		<th><bean:message key="app.programme" /></th>
		<th><bean:message key="app.subprogramme" /></th>
		<th><bean:message key="app.estimatecost" />(Rs. in lakhs)</th>
		<th><bean:message key="app.otherdetails" /></th>
		<th><bean:message key="app.action" /></th>
 
</tr>
</thead>
<tbody class="label">
	<c:forEach items="${requestScope.representativeProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<tr class='<c:out value="row${index%2}" />'>
		<td align="center" width="40">
			<input type="checkbox" name="sel" id="rep" 
				   value='<c:out value="${item.proposalId}"/>'
				   onclick="return checkMe(this)">
		</td>
		<td align="left" width="145"><c:out value="${item.proposalName}"/></td>
		<td align="center" width="85">
			<c:out value="${item.proposalId}"/>
		</td>
		<td align="center" width="65">
			<c:out value="${item.proposalDate}"/>
		</td>
		<td align="center" width="65">
			<c:out value="${item.noOfHabs}"/>&nbsp;
			<input type="button" value="..." title="Show Selected Habs" class="btext" 
				name='<c:out value="${item.proposalId}"/>' onclick="javascript:fnShowHabs(this)">
		</td>
		<td align="left" width="60">
			&nbsp;<c:out value="${item.assetName}" />
		</td>
		<td align="left" width="70">
			&nbsp;<c:out value="${item.programmeName}" />
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
		<td align="center" width="50">
			<input type="button" class="btext" value="..." 
				   name='<c:out value="${item.proposalId}"/>'
				   onclick="javascript:fnShowOtherDetails(this)">
		</td>
		<td align="center" width="40">
			<input type="button" class="btext" value="Edit" name='<c:out value="${item.proposalId}"/>' 
				   onclick="javascript:fnEditConsiderProposal(this)"
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
<td colspan="11">
	<table cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<th align="left">&nbsp;
			<a href="javascript: checkAll('sel','rep')" id="white">Check All</a>
			<a href="javascript: clearAll('sel','rep')" id="white">Clear All</a>
		</th>
		<th class="label" align="right">
			<b>Total No. of Representations:&nbsp;<c:out value="${index+1}"/></b>
		</th>
	</tr>
	</table>
</td>
</tr>
</tfoot>
</table>
<table>
<tr>
	<td>
		<c:if test="${RWS_USER.headOfOffice}" >
		<html:submit property="mode" styleClass="btext" 
			onclick="return isSelected('sel','rep', 'Please select atleast one proposal to consider.')">
			<bean:message key="button.consider" />
		</html:submit>
		</c:if>
		<c:if test="${not RWS_USER.headOfOffice}" >
		<html:submit property="mode" styleClass="btext" disabled="true"
			onclick="return isSelected('sel','rep', 'Please select atleast one proposal to consider.')">
			<bean:message key="button.consider" />
		</html:submit>
		</c:if>
	</td>
</tr>
</table>
</fieldset>
</td>
</tr>
</logic:present>

<logic:present name="consideredProposals">
<c:set var="pending" value="true" />
<tr>
<td>
<fieldset>
<legend><bean:message key="legend.consideredProposals" /></legend>
<label>

<table bgcolor="#DEE3E0" border="1" bordercolor="black" align="center" width="750" 
	   cellpadding="0" cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr>
	<th><bean:message key="app.select" /></th>
	<th><bean:message key="app.workname" /></th>
	<th><bean:message key="app.proposalid" /></th>
	<th><bean:message key="app.proposaldate" /></th>
	<th><bean:message key="app.selectedhabs" /></th>
	<th><bean:message key="app.scheme" /></th>
	<th><bean:message key="app.programme" /></th>
	<th><bean:message key="app.subprogramme" /></th>
	<th><bean:message key="app.estimatecost" />(Rs.)</th>
	<th><bean:message key="app.otherdetails" /></th>
	<th><bean:message key="app.action" /></th>
</tr>
</thead>
<tbody class="label">
<c:forEach items="${requestScope.consideredProposals}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
	<tr class='<c:out value="row${index%2}"/>'>
	<td align="center" width="40">
		<input type="checkbox" name="sel" id="con" value='<c:out value="${item.proposalId}"/>'>
	</td>
	<td align="left" width="145">
		<c:out value="${item.proposalName}" />
	</td>
	<td align="center" width="85">
		<c:out value="${item.proposalId}" />
	</td>
	<td align="center" width="65">
		<c:out value="${item.proposalDate}" />
	</td>
	<td align="center" width="65"><c:out value="${item.noOfHabs}" />
			<input type="button" value="..." title="Show Selected Habs" class="btext" 
			name='<c:out value="${item.proposalId}"/>' onclick="javascript:fnShowHabs(this)">
	</td>
	<td width="60">&nbsp;<c:out value="${item.assetName}" /></td>
	<td width="70">&nbsp;<c:out value="${item.programmeName}" /></td>
	<td width="70">&nbsp;<c:out value="${item.subprogrammeName}" /></td>
	<td align="right" width="60">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  value="${item.estimateCost}" />&nbsp;
	</td>
	<td align="center" width="50">
	<input type="button" class="btext" value="..." 
	name='<c:out value="${item.proposalId}"/>' onclick="javascript:fnShowOtherDetails(this)">
	</td>
	<td align="center" width="40">
	<input type="button" class="btext" value="Edit" 
	name='<c:out value="${item.proposalId}"/>' onclick="javascript:fnEditProposal(this)">
	</td>
</tr>
</c:forEach>
</tbody>
<tfoot>
<tr bgcolor="#8A9FCD">
<td colspan="11">
	<table cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<th align="left">&nbsp;
			<a href="javascript: checkAll('sel','con')" id="white">Check All</a>
			<a href="javascript: clearAll('sel','con')" id="white">Clear All</a>
		</th>
		<th class="label" align="right">
			<b>Total No. of Considered Proposals:&nbsp;<c:out value="${index+1}"/></b>
		</th>
	</tr>
	</table>
</td>
</tr>
</tfoot>
</table>


<table>
<tr>
	<td>
		<logic:empty name="ProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideForward('sel','con')">
		</logic:empty>
		<logic:notEmpty name="ProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" onclick="javascript:fnShowHideForward('sel','con')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<logic:empty name="ProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideSubmit('sel','con')">
		</logic:empty>
		<logic:notEmpty name="ProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" onclick="javascript:fnShowHideSubmit('sel','con')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<input type="button" class="btext" name="cmbShowHideDeffer" value="Others" 
			   style="width:75px" onclick="javascript:fnShowHideDeffer('sel','con')"
			   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
			   </c:if>
		>		   
	 
	</td>
</tr>
</table>

</fieldset>
</td>
</tr>
</logic:present>

<!--     CODE ADDED BY SANTOSH     -->
<logic:present name="submittedProposalsForCircleOfficeSanction">
<c:set var="pending" value="true" />
<tr bgcolor="#DEE3E0">
<td>
<fieldset>
<legend>Submitted Proposals For CircleOffice Sanction</legend>
<label>
<table bgcolor="#DEE3E0" border="1" bordercolor="#000000" align="center" width="750" cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.select" /></th>
	<th><bean:message key="app.workname" /></th>
	<th><bean:message key="app.proposalid" /></th>
	<th><bean:message key="app.proposaldate" /></th>
	<th><bean:message key="app.selectedhabs" /></th>
	<th><bean:message key="app.scheme" /></th>
	<th><bean:message key="app.programme" /></th>
	<th><bean:message key="app.subprogramme" /></th>
	<th><bean:message key="app.estimatecost" />(Rs.)</th>
	<th><bean:message key="app.otherdetails" /></th>
	<th><bean:message key="app.action" /></th>
</tr>
</thead>
<tbody class="label">
	<c:set var="officeCode" value="" />
	<c:forEach items="${requestScope.submittedProposalsForCircleOfficeSanction}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:set var="proposalId" value="${item.proposalId}" />
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
			<input type="checkbox" name="sel" id="sub" value='<c:out value="${item.proposalId}"/>'>
		</td>
		<td width="145" style="display:block;cursor:hand" 
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()">
			<c:out value="${item.proposalName}" />
		</td>
		<td align="center" width="85">
			<c:out value="${item.proposalId}" />
		</td>
		<td align="center" width="65"><c:out value="${item.proposalDate}" /></td>
		<td align="center" width="65">
			<c:out value="${item.noOfHabs}" />&nbsp;<input type="button" value="..." title="Show Selected Habs" class="btext" 
			name='<c:out value="${item.proposalId}" />' onclick="javascript:fnShowHabs(this)">
		</td>
		<td align="left" width="60">&nbsp;<c:out value="${item.assetName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.programmeName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.subprogrammeName}" /></td>
		<td align="right" width="60">
			<fmt:formatNumber value="${item.estimateCost}" maxFractionDigits="2" minFractionDigits="2" 
							  minIntegerDigits="1"/>&nbsp;
		</td>
		<td align="center" width="50">
			<input type="button" class="btext" value="..." name='<c:out value="${item.proposalId}" />'
				   onclick="javascript:fnShowOtherDetails(this)">
		</td>
		<td align="center" width="40">
			<input type="button" class="btext" value="Edit" name='<c:out value="${proposalId}" />' 
				   onclick="fnEditProposal(this)"
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
		<td colspan="11">
			<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th align="left">&nbsp;
					<a href="javascript: checkAll('sel','sub')" id="white">Check All</a>
					<a href="javascript: clearAll('sel','sub')" id="white">Clear All</a>
				</th>
				<th class="label" align="right">
					<b>No. of Submitted Proposals:&nbsp;<c:out value="${index+1}"/></b>
				</th>
			</tr>
			</table>
		</td>
	</tr>
	</tfoot>
</table>
<table width="100%">
<tr>
	<td align="left">
		<logic:empty name="ProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideForward('sel','sub')">
		</logic:empty>
		<logic:notEmpty name="ProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" onclick="javascript:fnShowHideForward('sel','sub')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<logic:empty name="ProposalForm" property="submitTo">
		<%//System.out.println("empty"); %>
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideSubmit('sel','sub')">
		</logic:empty>
		<logic:notEmpty name="ProposalForm" property="submitTo">
		<%//System.out.println("not empty"); %>
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" onclick="javascript:fnShowHideSubmit('sel','sub')"
				   	 <%if(RWS_USER.getDivisionOfficeCode().equals("0") && RWS_USER.getSubdivisionOfficeCode().equals("00"))
				  	{
				  	 //System.out.println("disabled"+RWS_USER.getCircleOfficeCode());
				  	 %>
				  	 disabled="disabled"
				  	 <%} %>
			>
		</logic:notEmpty>
		<input type="button" class="btext" name="cmbShowHideDeffer" value="Others" 
				   style="width:75px" onclick="javascript:fnShowHideDeffer('sel','sub')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
		>  
		<input type="button" class="btext" name="Existing" value="Existing Details" 
				   style="width:115px" onclick="javascript:fnShowExsting(this.form)"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
		>		   
	</td>
	<c:set var="officeType" value="${sessionScope.RWS_USER.officeName}" />
	<c:if test="${officeType == 'Circle Office'}">
	<td align="right">
		<c:if test="${RWS_USER.headOfOffice}">
			<html:button property="mode" styleClass="btext" style="width:150px" 
			   value="Consider for Sanction" onclick="javascript: fnConsiderForSanction(this.form)"/>
		</c:if>
		<c:if test="${not RWS_USER.headOfOffice}">
			<html:button property="mode" styleClass="btext" style="width:150px" disabled="true"
			   value="Consider for Sanction" onclick="javascript: fnConsiderForSanction(this.form)"/>
		</c:if>
	</td>
	</c:if>
</tr>
</table>
</fieldset>
</td>
</tr>
</logic:present>

<!--  END OF CODE ADDED BY SANTOSH -->


<logic:present name="submittedProposals">
<c:set var="pending" value="true" />
<tr bgcolor="#DEE3E0">
<td>
<fieldset>
<legend><bean:message key="legend.submittedProposals" /></legend>
<label>
<table bgcolor="#DEE3E0" border="1" bordercolor="#000000" align="center" width="750" cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.select" /></th>
	<th><bean:message key="app.workname" /></th>
	<th><bean:message key="app.proposalid" /></th>
	<th><bean:message key="app.proposaldate" /></th>
	<th><bean:message key="app.selectedhabs" /></th>
	<th><bean:message key="app.scheme" /></th>
	<th><bean:message key="app.programme" /></th>
	<th><bean:message key="app.subprogramme" /></th>
	<th><bean:message key="app.estimatecost" />(Rs.)</th>
	<th><bean:message key="app.otherdetails" /></th>
	<th><bean:message key="app.action" /></th>
</tr>
</thead>
<tbody class="label">
	<c:set var="officeCode" value="" />
	<c:forEach items="${requestScope.submittedProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:set var="proposalId" value="${item.proposalId}" />
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
			<input type="checkbox" name="sel" id="sub" value='<c:out value="${item.proposalId}"/>'>
		</td>
		<td width="145" style="display:block;cursor:hand" 
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()">
			<c:out value="${item.proposalName}" />
		</td>
		<td align="center" width="85">
			<c:out value="${item.proposalId}" />
		</td>
		<td align="center" width="65"><c:out value="${item.proposalDate}" /></td>
		<td align="center" width="65">
			<c:out value="${item.noOfHabs}" />&nbsp;<input type="button" value="..." title="Show Selected Habs" class="btext" 
			name='<c:out value="${item.proposalId}" />' onclick="javascript:fnShowHabs(this)">
		</td>
		<td align="left" width="60">&nbsp;<c:out value="${item.assetName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.programmeName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.subprogrammeName}" /></td>
		<td align="right" width="60">
			<fmt:formatNumber value="${item.estimateCost}" maxFractionDigits="2" minFractionDigits="2" 
							  minIntegerDigits="1"/>&nbsp;
		</td>
		<td align="center" width="50">
			<input type="button" class="btext" value="..." name='<c:out value="${item.proposalId}" />'
				   onclick="javascript:fnShowOtherDetails(this)">
		</td>
		<td align="center" width="40">
			<input type="button" class="btext" value="Edit" name='<c:out value="${proposalId}" />' 
				   onclick="fnEditProposal(this)"
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
		<td colspan="11">
			<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th align="left">&nbsp;
					<a href="javascript: checkAll('sel','sub')" id="white">Check All</a>
					<a href="javascript: clearAll('sel','sub')" id="white">Clear All</a>
				</th>
				<th class="label" align="right">
					<b>No. of Submitted Proposals:&nbsp;<c:out value="${index+1}"/></b>
				</th>
			</tr>
			</table>
		</td>
	</tr>
	</tfoot>
</table>
<table width="100%">
<tr>
	<td align="left">
		<logic:empty name="ProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideForward('sel','sub')">
		</logic:empty>
		<logic:notEmpty name="ProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" onclick="javascript:fnShowHideForward('sel','sub')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<logic:empty name="ProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideSubmit('sel','sub')">
		</logic:empty>
		<logic:notEmpty name="ProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" onclick="javascript:fnShowHideSubmit('sel','sub')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<input type="button" class="btext" name="cmbShowHideDeffer" value="Others" 
				   style="width:75px" onclick="javascript:fnShowHideDeffer('sel','sub')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
		>  
		<input type="button" class="btext" name="Existing" value="Existing Details" 
				   style="width:115px" onclick="javascript:fnShowExsting(this.form)"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
		>		   
	</td>
	<c:set var="officeType" value="${sessionScope.RWS_USER.officeName}" />
	<c:if test="${officeType == 'Head Office'}">
	<td align="right">
		<c:if test="${RWS_USER.headOfOffice}">
			<html:button property="mode" styleClass="btext" style="width:150px" 
			   value="Consider for Sanction" onclick="javascript: fnConsiderForSanction(this.form)"/>
		</c:if>
		<c:if test="${not RWS_USER.headOfOffice}">
			<html:button property="mode" styleClass="btext" style="width:150px" disabled="true"
			   value="Consider for Sanction" onclick="javascript: fnConsiderForSanction(this.form)"/>
		</c:if>
	</td>
	</c:if>
</tr>
</table>
</fieldset>
</td>
</tr>
</logic:present>


<logic:present name="forwardedProposals">
<c:set var="pending" value="true" />
<tr bgcolor="#DEE3E0">
<td>
<fieldset>
<legend><bean:message key="legend.forwardedProposals" /></legend>
<label>
<table bgcolor="#DEE3E0" border="1" bordercolor="black" align="center" width="750" cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.select" /></th>
	<th><bean:message key="app.workname" /></th>
	<th><bean:message key="app.proposalid" /></th>
	<th><bean:message key="app.proposaldate" /></th>
	<th><bean:message key="app.selectedhabs" /></th>
	<th><bean:message key="app.scheme" /></th>
	<th><bean:message key="app.programme" /></th>
	<th><bean:message key="app.subprogramme" /></th>
	<th><bean:message key="app.estimatecost" />(Rs.)</th>
	<th><bean:message key="app.otherdetails" /></th>
	<th><bean:message key="app.action" /></th>
</tr>
</thead>
<tbody class="label">
	<c:set var="officeCode" value="" />
	<c:forEach items="${requestScope.forwardedProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:set var="proposalId" value="${item.proposalId}" />
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
	<tr class='<c:out value="row${index%2}"/>'>
		<td align="center" width="40">
			<input type="checkbox" name="sel" id="fwd" value='<c:out value="${proposalId}"/>'>
		</td>
		<td width="145" style="display:block;cursor:hand" 
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()">
			<c:out value="${item.proposalName}" />
		</td>
		<td align="center" width="85"><c:out value="${item.proposalId}" /></td>
		<td align="center" width="65"><c:out value="${item.proposalDate}" /></td>
		<td align="center" width="65">
			<c:out value="${item.noOfHabs}" />&nbsp;<input type="button" value="..." title="Show Selected Habs" class="btext" 
			name='<c:out value="${item.proposalId}" />' onclick="javascript:fnShowHabs(this)">
		</td>
		<td align="left" width="60">&nbsp;<c:out value="${item.assetName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.programmeName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.subprogrammeName}" /></td>
		<td align="right" width="60">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.estimateCost}" />&nbsp;
		</td>
		<td align="center" width="50">
			<input type="button" class="btext" value="..." name='<c:out value="${proposalId}" />'
				   onclick="javascript:fnShowOtherDetails(this)">
		</td>
		<td align="center" width="40">
			<input type="button" class="btext" value="Edit" name='<c:out value="${proposalId}" />' 
				   onclick="javascript:fnEditProposal(this)"
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
		<td colspan="11">
			<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th align="left">&nbsp;
					<a href="javascript: checkAll('sel','fwd')" id="white">Check All</a>
					<a href="javascript: clearAll('sel','fwd')" id="white">Clear All</a>
				</th>
				<th class="label" align="right">
					<b>Total No. of Forwarded Proposals:&nbsp;<c:out value="${index+1}"/></b>
				</th>
		</tr>
		</table>
	</td>
</tr>
</tfoot>
</table>
<table>
<tr>
	<td align="left">
		<logic:empty name="ProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideForward('sel','fwd')">
		</logic:empty>
		<logic:notEmpty name="ProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" onclick="javascript:fnShowHideForward('sel','fwd')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<logic:empty name="ProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideSubmit('sel','fwd')">
		</logic:empty>
		<logic:notEmpty name="ProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" onclick="javascript:fnShowHideSubmit('sel','fwd')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<input type="button" class="btext" name="cmbShowHideDeffer" value="Others" 
				   style="width:75px" onclick="javascript:fnShowHideDeffer('sel','fwd')"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
		>		   
		<input type="button" class="btext" name="Existing" value="Existing Details" 
				   style="width:115px" onclick="javascript:fnShowExsting(this.form)"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
		>
		<input type="button" class="btext" name="sources" value="Source Details" 
				   style="width:115px" onclick="javascript:fnShowSources(this.form)"
				   <c:if test="${not RWS_USER.headOfOffice}">
				   		disabled="disabled"
				   </c:if>
		>		   		   
	</td>
</tr>
</table>
</fieldset>
</td>
</tr>
</logic:present>


<tr bgcolor="#DEE3E0" id="submitPanel" style="display:none">
<td>
	<fieldset>
		<legend><bean:message key="legend.submit" /></legend>
		<label>
		<table align="left">
		<tbody class="formTBody">
		<logic:notEmpty name="ProposalForm" property="submitTo">
		<tr>
			<td><bean:message key="app.submitTo" /></td>
			<td>:</td>
			<td colspan="4">
				<span style="font-weight:normal;">
					<bean:write name="ProposalForm" property="submitOffice" />
					<html:hidden property="submitTo" />
				</span>
			</td>
		</tr>
		</logic:notEmpty>
		<tr>
			<td><bean:message key="app.letterNo" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td>
				<html:text property="letterNo" maxlength="15" styleClass="thin-text-box" 
						   onkeypress="return textOnly(event)" />
			</td>
		</tr>
		<tr>
			<td><bean:message key="app.date" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td>
				<html:text property="submitDate" maxlength="10" styleClass="thin-text-box" 
						   size="14" />
				<a href="javascript: showCalendar(document.ProposalForm.submitDate);">
						<img src="<rws:context page='/images/calendar.gif'/>" 
							 border="0" align="absmiddle">
				</a>		   
			</td>
		</tr>
		<tr>
			<td><bean:message key="app.subject" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td colspan="4">
				<html:text property="submitSubject" size="95" maxlength="100" styleClass="thin-text-box"
						   onkeypress="return textOnly(event)" />
			</td>
		</tr>
		<tr>
			<td><bean:message key="app.ref" /></td>
			<td>:</td>
			<td colspan="4">
				<html:text property="submitRef" size="70" maxlength="50" styleClass="thin-text-box" 
						   onkeypress="return textOnly(event)" />
			</td>
		</tr>
		<tr>
			<td valign="top">
				<bean:message key="app.content" /><span class="mandatory">*</span>
			</td>
			<td valign="top">:</td>
			<td colspan="3">
				<html:textarea property="submitContent" rows="5" cols="71" styleClass="thin-text-box" 
							   onkeypress="return textOnly(event)" />
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<html:button property="mode" styleClass="btext"
							 onclick="return validateSubmit(this.form)">
					<bean:message key="button.send" />
				</html:button>
			</td>
		</tr>
		</table>
		</label>
	</fieldset>
</td>
</tr>
<tr bgcolor="#DEE3E0" id="forwardPanel" style="display:none">
<td>
	<fieldset>
		<legend><bean:message key="legend.forward" /></legend>
		<label>
		<table align="left">
		<tbody class="formTBody">
		<logic:notEmpty name="ProposalForm" property="forwardTo">
		<tr>
			<td><bean:message key="app.forwardTo" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td colspan="4">
				<span style="font-weight:normal;">
					<html:text property="forwardOffice" styleClass="thin-text-box" readonly="true" style="width:400px"/>
					<html:hidden property="forwardTo" />
					<html:hidden property="actionTo" />
					<input type="button" style="width:150px" 
						   value='Select <bean:write name="ProposalForm" property="forwardOffice"/>' onclick="javascript:fnShowOffices(this)" class="btext">
				</span>
			</td>
		</tr>
		</logic:notEmpty>
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
				<a href="javascript: showCalendar(document.ProposalForm.forwardDate);">
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
<tr bgcolor="#DEE3E0" id="defferPanel" style="display:none">
<td>
	<fieldset>
		<legend><bean:message key="legend.others" /></legend>
		<label>
		<table align="left">
		<tbody class="formTBody">
		<tr>
			<td><bean:message key="app.action" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td>
				<html:select property="actionType" styleClass="combo">
					<html:option value="">SELECT...</html:option>
					<html:option value="D">DEFER</html:option>
					<html:option value="T">TRANSMIT TO OTHER DEPARTMENT</html:option>
				</html:select>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<bean:message key="app.remarks" /></td>
			<td valign="top">:</td>
			<td>
				<html:textarea property="remarks" rows="5" cols="71" styleClass="thin-text-box" 
							   onkeypress="return textOnly(event)" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="3">
			<html:button property="mode" styleClass="btext"
				  onclick="return validateDeffer(this.form)">
				<bean:message key="button.save" />
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
</tbody>
</table>

</td>
</tr>
</table>
<html:hidden property="officeCode" name="RWS_USER"/>
<html:hidden property="userId" name="RWS_USER"/>
<html:hidden property="init" />
</html:form>
<%@ include file="/commons/rws_tooltip.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />