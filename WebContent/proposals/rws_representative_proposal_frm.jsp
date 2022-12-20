<%@ include file="/commons/rws_header1.jsp" %>


<script language="JavaScript">

function setEndoresement(that)
{
	var frm = that.form;
	var fieldValue = that.value;
	if(fieldValue == "OTHERS")
		frm.others.disabled = false;	
	else
	{	
		frm.others.value = "";
		frm.others.disabled = true;	
	}
	
}

function fnSubmit()
{
	var url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do";
	var frm = document.forms["RepresentativeProposalForm"];
	frm.action = url;
	frm.submit();
	//return false;
}

function fnAddWork()
{
	var url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do&mode=Add";
	var frm = document.forms["RepresentativeProposalForm"];
	frm.action = url;
	frm.submit();
}

function fnRemove(that)
{
	var frm = that.form;
	var removeIds = frm.elements("remove");
	
	if(removeIds)
	{
		var len = removeIds.length;
		var count = 0;
		if(typeof len != "number")
			removeIds = [removeIds];
		for(var i=0; i<len; i++)
		{
			if(removeIds[i].checked)
		 		count++;
		}
		if(count == 0)
			alert("Please select atleast one work to remove!");
		else
		if(count == len)
			alert("You cannot remove all works!\nPlease de-select one work.");
		else		
		{
			var url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do"
				+ "&mode=Remove";
			frm.action = url;
			frm.submit();		  
		}
	}
}
function fnGetOffices(that)
{
	var field = that.name;
	alert(field);
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do"
			+ "&mode=circles";
	else
	if(field == 'circleOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do"
			+ "&mode=divisions";
	else
	if(field == 'divisionOfficeCode')	
		url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do"
			+ "&mode=subdivisions";		
	frm.action = url;
	frm.submit();

}
function fnGetConstituencies(elem)
{
	var url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do&mode=constituencies";
	var frm = document.forms["RepresentativeProposalForm"];
	frm.repName.value = "";
	frm.repAddress.value = "";
	frm.action = url;
	frm.submit();
}
function fnRepDetails()
{
	var url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do&mode=repname";
	var frm = document.forms["RepresentativeProposalForm"];
	frm.repName.value = "";
	frm.repAddress.value = "";
	frm.action = url;
	frm.submit();
}
function fnGetSubprogrammes(elem)
{
	var index = elem.name.substr(5,1);
//	alert(elem.name + "   "+index);
	
	var url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do&mode=subprogrammes"
			+ "&index="+index;
	var frm = document.forms["RepresentativeProposalForm"];
	frm.action = url;
	frm.submit();
}
var newWindow;
function fnPickHabitations(index)
{
	var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("circleOfficeCode").value;
	var doc = document.getElementById("divisionOfficeCode").value;
	var soc = document.getElementById("subdivisionOfficeCode").value;

	if(coc == '')
		alert("Please select circle, division and subdivision.");
	else
	if(doc == '')
		alert("Please select division and subdivision.");
	else
	if(soc == '')
		alert("Please select subdivision.");		
	else
	{			
		var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		var url = "switch.do?prefix=/proposals&page=/PickHabitation.do&mode=pickhab&operationFrom=representativeProposalForm"
				+ "&hoc="+hoc+"&coc="+coc+"&doc="+doc+"&soc="+soc+"&proposalId="+proposalId
				+ "&index="+index;
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
	}
}
function fnShowAugmentationWork(index)
{
	var checkField = document.getElementById("WORK["+index+"].augmentation");
	if(checkField.checked)
	{
		var proposalId = proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var url = "switch.do?prefix=/proposals&page=/PickAugmentationWork.do";
		var properties = "width=450,height=135,toolbar=no,status=no,menubar=no,location=no,directories=no,"
					   + "scrollbars=yes,copyhistory=no,resizable=yes";
		newWindow = window.open(url, "", properties);
	}
}
function validateWorks()
{
	var workCount = document.getElementById("workCount").value;
	var workName;
	var noOfHabs;
	var estimateCostElem;
	var message ="";
	for(var i=0; i<workCount; i++)
	{
		workName = document.getElementById("WORK["+i+"].proposalName").value;
		noOfHabs = document.getElementById("WORK["+i+"].noOfHabs").value;
		estimateCostElem = document.getElementById("WORK["+i+"].estimateCost");
		
		if(workName.length == 0 || workName == '')
			message+="Work Name " + (i+1) + " is required\n"; 
		if(noOfHabs.length == 0 || noOfHabs == '' || noOfHabs == 0)
			message+="Habitation(s) for work " + (i+1) + " is required\n";  
		if(!isPositiveDecimal(estimateCostElem))
			message+="Estimate Cost for work " + (i+1) + " is invalid\n";  
	}
	if(message.length >0)
	{
		alert(message);
		return false;
	}
	return true;
}
function fnSave()
{
	if(validateRepresentativeProposalForm(RepresentativeProposalForm))
	{
		if(validateWorks())
		{
			return true;
		}
	}
	
	return false;
}

</script>
<html:javascript formName="RepresentativeProposalForm" htmlComment="true" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="RepresentativeProposalAction">

<table cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>

<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Representative Proposal Form" />
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
	<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" 
		   style="border-collapse:collapse">
	<tr>
	<td>
		<fieldset>
		<legend><bean:message key="legend.rwsOffices"/></legend>
		<label>
		<table>
		<tbody class="formTBody">
		<tr>
		<td class="column1"><bean:message key="app.headoffice" />
			<span class="mandatory">*</span>
		</td>
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
		<td class="column3">
			<bean:message key="app.circle" />
			<span class="mandatory">*</span>
		</td>
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
		<td class="column1"><bean:message key="app.division" />
			<span class="mandatory">*</span>
		</td>
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
		<td class="column3"><bean:message key="app.subdivision" />
		<span class="mandatory">*</span>
		</td>
		<td class="column4">
		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subdivisionOfficeCode" styleClass="combo">
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
		<fieldset>
		<legend><bean:message key="legend.representativeDetails"/></legend>
		<label>
			<table>
			<tbody class="formTBody">
			<tr>
				<td class="column1">
					<bean:message key="app.code" /><span class="mandatory">*</span>
				</td>
				<td class="column2">
					<logic:present name="representatives">
						<html:select property="repCode" styleClass="combo"
									 onchange="javascript: fnGetConstituencies(this)">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="representatives" name="labelValueBean"
										  property="value" labelProperty="label" />
						</html:select>
					</logic:present>
				</td>
				<logic:notEmpty name="constituencies">
				<td class="column3"><bean:message key="app.constituency" /></td>
				<td class="column4">
						<html:select property="constituencyCode" styleClass="combo"
									 onchange="javascript: fnRepDetails()">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="constituencies" name="labelValueBean"
										  property="value" labelProperty="label" />
						</html:select>
				</td>
				</logic:notEmpty>
			</tr>
			<tr>
				<td class="column1">
					<bean:message key="app.name"/><span class="mandatory">*</span>
				</td>
				<td class="column2">
					<html:text property="repName" maxlength="30" styleClass="thin-text-box" 
							   onkeypress="upperOnly()" />
				</td>
				<td class="column3"><bean:message key="app.address"/></td>
				<td class="column4">
					<html:textarea property="repAddress" styleClass="thin-text-box" 
								   onkeypress="upperOnly()" />
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
		<legend><bean:message key="legend.representationDetails" /></legend>
		<label>
			<table>
			<tbody class="formTBody">
			<tr>
				<td class="column1">
					<bean:message key="app.repDate" /><span class="mandatory">*</span>
				</td>
				<td class="column2">
					<html:text property="repDate" maxlength="10" size="14" styleClass="thin-text-box" 
							   onkeypress="upperOnly()" />
					<a href="javascript: showCalendar(document.RepresentativeProposalForm.repDate);">
						<img src="<rws:context page='/images/calendar.gif'/>" 
							 border="0" align="absmiddle">
					</a>
				</td>
				 <td class="column3"><bean:message key="app.description" /></td>
				<%--<td class="column4">
					<html:textarea property="description" styleClass="thin-text-box"
								   onkeypress="upperOnly()" />
				</td> --%>
			</tr>
			<tr>
				<td class="column1"><bean:message key="app.endorsedBy" /></td>
				<td class="column2">
					<html:select property="endorsedBy" styleClass="combo"
						  onchange="javascript: fnSubmit(this)">
						<html:option value="">SELECT...</html:option>
						<html:option value="CM">CM</html:option>
						<html:option value="PM">PM</html:option>
						<html:option value="MINISTER">MINISTER</html:option>
						<html:option value="OTHERS">OTHERS</html:option>
					</html:select>
				</td>
				<logic:equal name="RepresentativeProposalForm" property="endorsedBy" value="MINISTER">
				<td class="column3"><bean:message key="app.ministerFor" /></td>
				<td class="column4">
					<html:select property="ministerFor" styleClass="combo"
						  onchange="javascript: setEndoresement(this)">
						<html:option value="">SELECT...</html:option>
						<html:option value="PR">PR</html:option>
						<html:option value="RWS">RWS</html:option>
						<html:option value="OTHERS">OTHERS</html:option>
					</html:select>
				</td>
				</logic:equal>
			</tr>
			<tr>
				<td class="column1">If Others, specify</td>
				<td class="column2">
					<html:text property="others" maxlength="30" styleClass="thin-text-box" 
							   onkeypress="upperOnly()" disabled="true"/>
				</td>
				<td class="column3">
					<logic:equal name="RepresentativeProposalForm" property="repCode" value="13">
						<bean:message key="app.cmaNo" />
					</logic:equal>
					<logic:notEqual name="RepresentativeProposalForm" property="repCode" value="13">
						<logic:equal name="RepresentativeProposalForm" property="endorsedBy" value="CM">
							<bean:message key="app.cmpNo" />						
						</logic:equal>
						<logic:notEqual name="RepresentativeProposalForm" property="endorsedBy" value="CM">
							<bean:message key="app.endorsementNo" />
						</logic:notEqual>
					</logic:notEqual>
					
				</td>
				<td class="column4">
					<html:text property="endorsementNo" maxlength="10" styleClass="thin-text-box" 
							   onkeypress="upperOnly()" />
				</td>
			</tr>
			<tr>	
				<td class="column1"><bean:message key="app.endorsementDate" /></td>
				<td class="column2">
					<html:text property="endorsementDate" maxlength="10" size="14" 
							   styleClass="thin-text-box" onkeypress="upperOnly()" />
					<a href="javascript: showCalendar(document.RepresentativeProposalForm.endorsementDate);">
						<img src="<rws:context page='/images/calendar.gif'/>" 
							 border="0" align="absmiddle">
					</a>
				</td>
				<td class="column3"><bean:message key="app.recommendations" /></td>
				<td class="column4">
					<html:text property="recommendations" maxlength="50" styleClass="thin-text-box"
							   onkeypress="upperOnly()" />
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
		<legend><bean:message key="legend.workDetails" /></legend>
		<label>
			<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr>
				<th><bean:message key="app.select" /></th>
				<th><bean:message key="app.workName" /></th>
				<th><bean:message key="app.selectHabs" /></th>
				<th><bean:message key="app.scheme" /></th>
				<th><bean:message key="app.programme" /></th>
				<th><bean:message key="app.subprogramme" /></th>
				<th><bean:message key="app.priority" /></th>
				<th><bean:message key="app.estimateCostBR" /></th>
				<th><bean:message key="app.proposalId" /></th>
				<th><bean:message key="app.remarks" /></th>
				<th><bean:message key="app.augmentation" /></th>
			</tr>
			</thead>
			<tbody>
			<% int workCount = 0;%>
			<nested:iterate id="WORK" property="proposals" indexId="ndx">
			<% workCount++; %>
			<tr bgcolor="#ffffff">
				<td width="40px" align="center">
					<input type="checkbox" name="remove" value="<%= ndx%>">
				</td>
				<td>
					<nested:text name="WORK" property="proposalName" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()" />
				</td>
				<td>
					<nested:text name="WORK" property="noOfHabs" indexed="true" readonly="true" 
							     styleClass="noborder-text-box" style="width: 12px"/>
					<html:button property="addHab" value="..." styleClass="btext"
								 onclick='<%= "javascript: fnPickHabitations(\" + ndx + \")"%>' />
				</td>
				<td>
					<logic:present name="assetTypes">
						<nested:select name="WORK" property="typeOfAsset" indexed="true"
									   style="width: 80px" styleClass="noborder-text-box">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<nested:options collection="assetTypes" name="labelValueBean" 
										  property="value" labelProperty="label" />
						</nested:select>
					</logic:present>
				</td>
				<td>
					<logic:present name="programmes">
						<nested:select name="WORK" property="programmeCode" indexed="true"
									   style="width: 80px" styleClass="noborder-text-box" 
									   onchange="javascript: fnGetSubprogrammes(this)">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<nested:options collection="programmes" name="labelValueBean" 
										  property="value" labelProperty="label" />
						</nested:select>
					</logic:present>
				</td>
				<td>
					<nested:select name="WORK" property="subprogrammeCode" indexed="true"
								   style="width: 80px" styleClass="noborder-text-box">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:notEmpty name="WORK" property="subprogrammes">
							<nested:optionsCollection property="subprogrammes" />
						</logic:notEmpty>
					</nested:select>
				</td>
				<td>
					<logic:present name="priorities">
						<nested:select name="WORK" property="priorityCode" indexed="true"
									   style="width: 80px" styleClass="noborder-text-box">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<nested:options collection="priorities" name="labelValueBean" 
										  property="value" labelProperty="label" />
						</nested:select>
					</logic:present>
				</td>
				<td>
					<nested:text name="WORK" property="estimateCost" indexed="true" maxlength="9"
							     style="width: 55px;text-align: right" styleClass="noborder-text-box" 
							     onkeypress="return decimalsOnly(event)"/>
				</td>
				<td>
					<nested:text name="WORK" property="proposalId" indexed="true" readonly="true"
							     style="width: 78px;text-align: center" styleClass="noborder-text-box"/>
				</td>
				<td>
					<nested:text name="WORK" property="remarks" indexed="true" 
							     style="width: 60px;" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()"/>
				</td>
				<td align="center">
					<nested:checkbox name="WORK" property="augmentation" value="Y" indexed="true" 
									 onclick='<%= "javascript: fnShowAugmentationWork(\" + ndx + \")"%>'/>
					<nested:hidden name="WORK" property="workId" indexed="true"/>
				</td>
			</tr>
			</nested:iterate>
			<input type="hidden" name="workCount" value="<%= workCount %>">
			</tbody>
			</table>
			<table width="100%">
			<tr>
			<td align="right">
				<html:button property="mode" styleClass="btext" style="width:120px"
					onclick="return fnAddWork()">
					<bean:message key="button.addNewWork" />
				</html:button>
				<% if(workCount <= 1) { %>
				
				<html:button property="mode" styleClass="btext" style="width:120px"
					onclick="return fnRemove(this)" disabled="true">
					<bean:message key="button.removeWorks" />
				</html:button>
				<% } else {%>
				<html:button property="mode" styleClass="btext"
						style="width:120px" onclick="return fnRemove(this)">
					<bean:message key="button.removeWorks" />
				</html:button>
				<% } %>

			</td>
			</tr>
			</table>
		</label>
		</fieldset>
	</td>
	</tr>
	<c:if test="${not empty tempSelectedRepProposalHabs}">
	<tr>
	<td>
		<fieldset>
		<legend><bean:message key="legend.habitationDetails" /></legend>
		<label>
			<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr>
				<th><bean:message key="app.leadHabitation" /></th>
				<th><bean:message key="app.habitationCode" /></th>
				<th><bean:message key="app.habitationName" /></th>
				<th><bean:message key="app.population" /></th>
				<th><bean:message key="app.status" /></th>
			</tr>
			</thead>
			<tbody class="gridText">
			<c:set var="proposalId" value="" />
			<% String tempProposalId =""; %>
			<c:forEach items="${tempSelectedRepProposalHabs}" var="item" varStatus="status">
			<c:set var="index" value="${status.index}" />
			<c:if test="${proposalId != item.proposalId}">
			<c:set var="proposalId" value="${item.proposalId}" />
			<% tempProposalId = ""; %> 
			<tr bgcolor="lightyellow">
				<td colspan="6" align="left">
					<font size="-1" face="verdana">
					Habitations selected for proposal <c:out value="${item.proposalId}" />
					</font>
				</td>
			</tr>	
			</c:if>
			
			<tr class="<c:out value='row${index%2}' />">
				<td align="center">
					<% if(tempProposalId.equals(""))
					   {  tempProposalId = "RW"; 
					%>
						<input type="radio" name="<c:out value='${item.proposalId}'/>"
							   value="<c:out value='${item.habCode}'/>" checked="checked">
					<% } else { %>
						<input type="radio" name="<c:out value='${item.proposalId}'/>"
						   	   value="<c:out value='${item.habCode}'/>" >
					<% }%>
				</td>
				<td align="center"><c:out value="${item.habCode}" /></td>
				<td>&nbsp;<c:out value="${item.habName}" /></td>
				<td align="right"><c:out value="${item.population}" />&nbsp;</td>
				<td>&nbsp;<c:out value="${item.status}" />
				<input type="hidden" name="<c:out value='H_${item.proposalId}'/>" 
					   value="<c:out value='${item.habCode}'/>"></td>
			</tr>
			</c:forEach>
			</tbody>
			</table>
		</label>
		</fieldset>
	</td>
	</tr>
	</c:if>
	<tr>
	<td>
		<table width="100%">
		<tr>
			<td align="center">
				<html:submit property="mode" styleClass="btext" onclick="return fnSave()">
					<bean:message key="button.save" />
				</html:submit>
				<html:reset property="mode" styleClass="btext">
					<bean:message key="button.clear" />
				</html:reset>
				<html:submit property="mode" styleClass="btext">
					<bean:message key="button.view" />
				</html:submit>
			</td>
		</tr>
		</table>
	</td>
	</tr>

	</table>
</td>
</tr>
</tbody>

</table>

<logic:equal name="RepresentativeProposalForm" property="endorsedBy" value="OTHERS">
<script>
	document.getElementById("others").disabled = false;
</script>
</logic:equal>

<logic:equal name="RepresentativeProposalForm" property="endorsedBy" value="MINISTER">
<logic:equal name="RepresentativeProposalForm" property="ministerFor" value="OTHERS">
<script>
	document.getElementById("others").disabled = false;
</script>
</logic:equal>
</logic:equal>

<html:hidden property="init" />
<html:hidden property="userId" name="RWS_USER" />
<html:hidden property="officeCode" name="RWS_USER" />
</html:form>

<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />
<%
	if(request.getAttribute("message") != null)
	{
%>	
		<script>
		<!--
			alert("Processing...\nPlease wait...")
			document.location.reload();
		//-->
		</script>
		
<%	}
%>