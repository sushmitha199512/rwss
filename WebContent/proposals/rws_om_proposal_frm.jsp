<%@ page import="nic.watersoft.commons.ProgrammeSubProgrammeBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="/commons/rws_header1.jsp" %>

<script language="JavaScript">
<!--
function fnPickAssetHabs(assetCode)
{
	var url = "switch.do?prefix=/proposals&page=/PickAssetHabitation.do"
			+ "&assetCode="+assetCode; 
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	window.open(url,"",properties);		
}

function fnShowFunctionalHabs(assetCode)
{
	var url = "switch.do?prefix=/proposals&page=/ShowFunctionalHabs.do"
			+ "&assetCode="+assetCode; 
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	window.open(url,"",properties);		
}


function fnGetOffices(that)
{
	var elemName = that.name;
	var frm = that.form;
	var mode = "";
	
	if(elemName == "headOfficeCode")
		mode = "headOffice";
	else	
	if(elemName == "circleOfficeCode")
		mode = "circle";	
	else	
	if(elemName == "divisionOfficeCode")
		mode = "division";	
	else	
	if(elemName == "subdivisionOfficeCode")
		mode = "subdivision";	
	
	frm.action = "switch.do?prefix=/proposals&page=/OMProposalData.do&mode="+mode;
	frm.submit();
}

function getData(that)
{
	var url="switch.do?prefix=/proposals&page=/OMProposalData.do";
	form =  that.form;
	form.action = url;
	form.submit();
}
function getSubprogrammes(that)
{
	var frm = that.form;
 	var url = "switch.do?prefix=/proposals&page=/OMProposalData.do?programmeCode=" + that.value;
 	frm.action = url;
 	frm.submit();
}

function fnToggleSubProgrammes(that)
{
	var frm = that.form;
	var programmeCode = that.value;
	if(programmeCode == "00")
	{
		if(that.checked)
			frm.others.disabled = false;
		else
			frm.others.disabled = true;
	}
	else
	{
		var field = "subprogrammeCode_"+programmeCode;
		var subprogrammeElem = frm.elements(field);
			
		if(subprogrammeElem)
		{
			var len = subprogrammeElem.length;
			if(typeof len != "number")
			{
				subprogrammeElem = [subprogrammeElem]; 
			}
			if(that.checked)
			{	for(var i=0; i<len; i++)
				{	subprogrammeElem[i].disabled = false;
				}
			}
			else
			{	for(var i=0; i<len; i++)
				{	subprogrammeElem[i].disabled = true;
				}
			}
		}
	}
}

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

function editOM(omProposalId)
{
	var url="switch.do?prefix=/proposals&page=/EditOMProposal.do&mode=Edit&omProposalId="+omProposalId;
	OMProposalForm.action = url;
	OMProposalForm.submit();
}

function fnShowOffices(that)
{
	var officeCode = document.getElementById("actionTo").value;
	var url = "switch.do?prefix=/proposals&page=/ShowForwardOffices.do&officeCode="+officeCode;
	var properties = "width=300,height=250,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
}

function fnSave()
{
	if(validateOMProposalForm(OMProposalForm))
	{
		var others = document.getElementById("others");
		var otherValue = others.value;
		var frm = others.form;
		var flag = true;
		if(!others.disabled)
		{
			var regexp = /.+/;
			if(!otherValue.match(regexp))
			{
				alert("If others, specify is required");
				flag = false;
				frm.others.focus();
			}
			else
			{
				var programmeNames = frm.elements("programmeName");
				if(typeof programmeNames.length != "number")
					programmeNames = [programmeNames];
				for(var j=0; j<programmeNames.length; j++)
				{
					if(programmeNames[j].value == otherValue.toUpperCase())
						flag = false;
				}
				if(!flag)
					alert("Programme entered is already in the list.");
			}
		}
					
		if(flag)
		{
			if(isSelected('assetCode', 'asset','Please select atleast one asset to save.'))
				return true;
		}
	}
	return false;
}
function fnPreviousDetails(frm)
{
if(isSelected('assetCode', 'asset','Please select atleast one asset.'))
{
		alert("previousDetails");
 		var url = "switch.do?prefix=/proposals&page=/OMProposalAction.do&mode=PreviousDetails";
	    var properties = "width=784,height=412,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	    //var newWindow = window.open(url, "", properties);
    	//newWindow.moveTo(95,145);
    	//this.OMProposalForm.submit;
frm.action = url;
frm.submit();		
}

}
function fnDelete(frm, elem, id)
{
	if(isSelected(elem, id, 'Please select atleast one proposal to delete.'))
	{
		frm.action = "switch.do?prefix=/proposals&page=/OMProposalAction.do&mode=Delete";
		frm.submit();
	}			
	
}
function validateDefer(frm)
{
	if(validateDeferForm(frm))
	{
		var url = "switch.do?prefix=/proposals&page=/OMProposalAction.do&mode=Others";
		frm.action = url;
		frm.submit();
	}	
}
function validateSubmit(frm)
{
	if(validateSubmitForm(frm))
	{
		var url = "switch.do?prefix=/proposals&page=/OMProposalAction.do&mode=Submit";
		frm.action = url;
		frm.submit();
	}
}
function validateForward(frm)
{
	if(validateForwardForm(frm))
	{
		var url = "switch.do?prefix=/proposals&page=/OMProposalAction.do&mode=Forward";
		frm.action = url;
		frm.submit();
	}
}
function fnConsiderForSanction(frm)
{
	if(isSelected('sel', 'subs', 'Please select atleast one proposal to consider for sanction.'))
	{
		var url = "switch.do?prefix=/proposals&page=/OMProposalAction.do&mode=Consider for Sanction";
		frm.action = url;
		frm.submit();
	}
}
//-->
</script>

<html:javascript formName="OMProposalForm" />
<%@ include file="/commons/rws_header2.jsp"%>

<html:form action="/OMProposalAction">
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="O&M Proposals Form" />
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

<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">

<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.rwsOffices" /></legend>
	<label>
	<table>
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

<logic:present name="assets">
<c:set var="pending" value="true" />
<tr>
<td>
	<fieldset>
	<legend>
		<bean:message key="legend.proposalDetails" />
	</legend>
	<label>
		<table>
		<tbody class="formTBody">
		<tr>
			<td colspan="4" width="100%">
			<div style="height: 100px; overflow-y:auto">
			<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
			style="border-collapse: collapse">
			
			<thead class="gridHeader">
			<tr>
				<th><bean:message key="app.select" /></th>
				<th><bean:message key="app.programme" /></th>
				<th><bean:message key="app.subprogramme" /></th>
			</tr>
			<tbody class="label">
			<% 
				ArrayList programmeSubProgrammes = (ArrayList)request.getAttribute("programmeSubProgrammes");
				ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
				String tempProgrammeCode = "00";
				String programmeCode = "";
				String programmeName = "";
				String subprogrammeCode = "";
				String subprogrammeName = "";
				boolean flag = true;
				for(int i=0; i<programmeSubProgrammes.size(); i++)
				{
				
				  programmeSubProgrammeBean = (ProgrammeSubProgrammeBean)programmeSubProgrammes.get(i);
				  programmeCode = programmeSubProgrammeBean.getProgrammeCode();
				  programmeName = programmeSubProgrammeBean.getProgrammeName();
				  subprogrammeCode = programmeSubProgrammeBean.getSubprogrammeCode();
				  subprogrammeName = programmeSubProgrammeBean.getSubprogrammeName();

				   if(!tempProgrammeCode.equals(programmeCode))
				   {
				   	  tempProgrammeCode = programmeCode;

			%>
				<tr class="row<%= i%2%>">
				<td align="center">
				<html:multibox property="programmeCodes" onclick="javascript: fnToggleSubProgrammes(this)">
					<%= programmeCode %>
				</html:multibox>
								
				</td>
				<td>&nbsp;<%= programmeName %>
				<input type="hidden" name="programmeName" value="<%= programmeName%>">
				</td>
				<td>
				<% 
					flag = false;
					} 
				%>	
				    <% if(subprogrammeName != null){ %>
				      <input type="radio" disabled="true"
				      name="subprogrammeCode_<%= programmeCode%>" value="<%= subprogrammeCode %>">
				      	<%= subprogrammeName%>
						<%
						  String rspc = request.getParameter("subprogrammeCode_"+programmeCode);
						  if(rspc != null)
 						  {
						%>
							<script>
							<!--
							var frm = document.forms[0];
							
							var subprogrammes = frm.elements('<%= "subprogrammeCode_"+programmeCode%>');
							if(subprogrammes)
							{
								if(typeof subprogrammes.length != 'number')
									subprogrammes = [subprogrammes];

								var subprogrammeLen = subprogrammes.length;
								for(var i=0; i<subprogrammeLen; i++)
								{
									subprogrammes[i].disabled = false;	
									if(subprogrammes[i].value == '<%= rspc%>')
										subprogrammes[i].checked = true;
								}
							}
							//-->
							</script>
						<%
						  }
						%>
				    <%} %>  
				<% 
					if(flag)
					{
				%>
					</td></tr>
				<%  } %>	
				
			<% 	 } %>
			</tbody>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td class="column1">If Others, specify</td>
			<td colspan="3" class="column2">
				<c:if test="${empty OMProposalForm.others}">
				<html:text property="others" disabled="true" maxlength="30"
					onkeypress="upperOnly()" styleClass="thin-text-box"/>
				</c:if>
				<c:if test="${not empty OMProposalForm.others}">
				<html:text property="others" maxlength="30"
					onkeypress="upperOnly()" styleClass="thin-text-box"/>
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="column1">
				<bean:message key="app.estimateCost"/><span class="mandatory">*</span>
			</td>
			<td class="column2">
				<html:text property="estimateCost" styleClass="thin-text-box" 
					onkeypress="return decimalsOnly(event)"/>
			</td>
			<td class="column3">
				<bean:message key="app.financialYear"/><span class="mandatory">*</span>
			</td>
			<td class="column4">
				<logic:present name="financialYears">
					<html:select property="financialYear" styleClass="combo">
						<html:option value="">
							<bean:message key="app.pleaseSelect" />
						</html:option>		 
						<html:options collection="financialYears" name="labelValueBean"
							property="value" labelProperty="label"/>
					</html:select>
				</logic:present>
			</td>
		</tr>
		<tr>
			<td class="column1"><bean:message key="app.remarks" /></td>
			<td class="column2">
				<html:textarea property="remarks" styleClass="thin-text-box" 
							   onkeypress="return textOnly(event)"/>
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
	<legend><bean:message key="legend.assetDetails" /></legend>
	<label>
	<table bgcolor="#DEE3E0" border="1" bordercolor="black" cellpadding="0" 
	cellspacing="0" style="border-collapse:collapse;" width="750" >
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
		<th><bean:message key="app.select" /></th>
		<th><bean:message key="app.assetCode" /></th>
		<th><bean:message key="app.assetName" /></th>
		<th><bean:message key="app.coveredHabs" /></th>
		<th><bean:message key="app.functionalHabs" /></th>
		<th><bean:message key="app.location" /></th>
		<th><bean:message key="app.commissionDate" /></th>
		<th><bean:message key="app.assetStatus" /></th>
		<th><bean:message key="app.assetCost" /></th>
	</tr>
	</thead>
	<tbody class="label">
		
		<c:forEach items="${assets}" var="item" varStatus="status">
		<c:set var="index" value="${status.index}"/>
		<tr class="<c:out value='row${index%2}'/>">
			<td align="center">
				<input type="checkbox" name="assetCode" id="asset" value="<c:out value='${item.assetCode}'/>">
			</td>
			<td align="center"><c:out value="${item.assetCode}" /></td>
			<td align="left"><c:out value="${item.assetName}" /></td>
			<td align="center">
			<c:out value="${item.noOfHabs}" />&nbsp;<input type="button" 
				name="<c:out value='SH_${item.assetCode}'/>" value="..."
				class="btext" onclick="javascript: fnPickAssetHabs('<c:out value='${item.assetCode}'/>')">
			</td>
			<td align="center">
			<c:out value="${item.noOfFunctionalHabs}" />&nbsp;<input type="button" 
				name="<c:out value='SH_${item.assetCode}'/>" value="..."
				class="btext" onclick="javascript: fnShowFunctionalHabs('<c:out value='${item.assetCode}'/>')">
			</td>							
			<td align="left"><c:out value="${item.location}" /></td>
			<td align="center"><c:out value="${item.creationDate}" /></td>
			<td align="left"><c:out value="${item.assetStatus}" /></td>
			<td align="right">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.assetCost}" />&nbsp;
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
				<a href="javascript: checkAll('assetCode','asset')" id="white">Check All</a>
				<a href="javascript: clearAll('assetCode','asset')" id="white">Clear All</a>
			</th>
			<th class="label" align="right">
				<b>Total No. of Assets:&nbsp;<c:out value="${index+1}"/></b>
			</th>
		</tr>
		</table>
	</td>
	</tr>
	</tfoot>
	</table>
	<table width="100%">
	<tr>
		<td align="center">
		<c:if test="${RWS_USER.headOfOffice == 'true'}">
			<html:submit property="mode" styleClass="btext" onclick="return fnSave()">
				<bean:message key="button.save" />
			</html:submit>
			<html:button property="mode" styleClass="btext" onclick="return fnPreviousDetails(this.form)">
				Previous Details
			</html:button>
			<html:reset styleClass="btext">
				<bean:message key="button.clear" />
			</html:reset>		
		</c:if>
		<c:if test="${RWS_USER.headOfOffice == 'false'}">
			<html:submit property="mode" styleClass="btext" disabled="true" onclick="return fnSave()">
				<bean:message key="button.save" />
			</html:submit>
			<html:submit property="mode" styleClass="btext" disabled="true" onclick="return fnPreviousDetails(this.form)">
				Previous Details
			</html:submit>
			<html:reset styleClass="btext" disabled="true">
				<bean:message key="button.clear" />
			</html:reset>		
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
	<legend><bean:message key="legend.consideredProposals" /> 
	</legend>
	<label>
	<table bgcolor="#DEE3E0" border="1" bordercolor="black" cellpadding="0" 
	cellspacing="0" style="border-collapse:collapse;" width="750" >
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th><bean:message key="app.proposalId" /></th>
			<th><bean:message key="app.assetName" /></th>
			<th><bean:message key="app.selectedHabs"/></th>
			<th><bean:message key="app.programme" />/<br>
				<bean:message key="app.subprogramme" />
			</th>
			<th><bean:message key="app.estimateCost" /><br>(Rs. in lakhs)</th>
			<th><bean:message key="app.financialYear" /></th>
			<th><bean:message key="app.action" /></th>
	</tr>
	</thead>
	<tbody class="label">
		<c:forEach items="${consideredProposals}" var="item" varStatus="status">
		<c:set var="index" value="${status.index}" />
		<tr class="<c:out value='row${index%2}'/>">
			<td align="center">
				<input type="checkbox" name="sel" id="cons" value="<c:out value='${item.proposalId}'/>">
			</td>
			<td align="center" width="125px"><c:out value="${item.proposalId}" /></td>
			<td align="left" width="150px"><c:out value="${item.assetName}" /></td>
			<td align="center">
				<c:out value="${item.noOfFunctionalHabs}" />&nbsp;<input type="button" value="..." class="btext"
					title="Show Selected Habitations" 
					onclick="javascript: fnShowFunctionalHabs('<c:out value='${item.assetCode}'/>')">
			</td>
			<c:set var="programmes" value="${item.programmes}" />
			<td align="left">
				<c:forEach items="${programmes}" var="programmeBean"> 
					<c:out value="${programmeBean.programmeName}" />
					<c:if test="${not empty programmeBean.subprogrammeName}">
					/&nbsp;<c:out value="${programmeBean.subprogrammeName}"/>
					</c:if>
					<br>
				</c:forEach>
			</td>
			<td align="right">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.estimateCost}" />&nbsp;
			</td>
			<td align="center"><c:out value="${item.financialYear}" /></td>
			<td align="center">
				<input type="button" name="edit" value="<bean:message key='button.edit' />"
					   onclick="javascript: editOM('<c:out value='${item.proposalId}'/>')"	
					   class="btext"
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
	<td colspan="10">
		<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th align="left">&nbsp;
				<a href="javascript: checkAll('sel','cons')" id="white">Check All</a>
				<a href="javascript: clearAll('sel','cons')" id="white">Clear All</a>
			</th>
			<th class="label" align="right">
				<b>Total No. of Considered Proposal:&nbsp;<c:out value="${index+1}" /></b>
			</th>
		</tr>
		</table>
	</td>
	</tr>
	</tfoot>
</table>
	<table>
	<td>
		<logic:empty name="OMProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideForward('sel','cons')">
		</logic:empty>
		<logic:notEmpty name="OMProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" onclick="javascript:fnShowHideForward('sel','cons')"
				   <c:if test="${RWS_USER.headOfOffice == 'false'}">
				   	disabled = "disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<logic:empty name="OMProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideSubmit('sel','cons')">
		</logic:empty>
		<logic:notEmpty name="OMProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" onclick="javascript:fnShowHideSubmit('sel','cons')"
				   <c:if test="${RWS_USER.headOfOffice == 'false'}">
				   	disabled = "disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<input type="button" class="btext" name="cmbShowHideDeffer" value="Others" 
			   style="width:75px" onclick="javascript:fnShowHideDeffer('sel','cons')"
				   <c:if test="${RWS_USER.headOfOffice == 'false'}">
				   	disabled = "disabled"
				   </c:if>
		>
		<input type="button" class="btext" name="cmbShowHideDeffer" value="Delete" 
			   style="width:75px" onclick="javascript:fnDelete(this.form, 'sel','cons')" 
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
</logic:present>

<logic:present name="submittedProposals">
<c:set var="pending" value="true" />
<tr>
<td>
	<fieldset>
	<legend>	
		<bean:message key="legend.submittedProposals" /> 
	</legend>
	<label>
	<table bgcolor="#DEE3E0" border="1" bordercolor="black" cellpadding="0" 
	cellspacing="0" style="border-collapse:collapse;" width="750" >
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th><bean:message key="app.proposalId" /></th>
			<th><bean:message key="app.assetName" /></th>
			<th><bean:message key="app.selectedHabs"/></th>
			<th><bean:message key="app.programme" />
				<bean:message key="app.subprogramme" /></th>
			<th><bean:message key="app.estimateCost" /><br>(Rs. in lakhs)</th>
			<th><bean:message key="app.financialYear" /></th>
			<th><bean:message key="app.action" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="officeCode" value="" />
	<c:forEach items="${submittedProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
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
		<tr class="<c:out value='row${index%2}'/>" id="<c:out value='${item.officeCode}'/>">
			<td align="center">
				<input type="checkbox" name="sel" id="subs" value="<c:out value='${item.proposalId}'/>">
			</td>
			<td width="125px" style="display:block;cursor:hand" 
				onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
				onmouseout="hideddrivetip()"><c:out value="${item.proposalId}"/>
			</td>
			<td align="left" width="150px"><c:out value="${item.assetName}" /></td>
			<td align="center">
				<c:out value="${item.noOfFunctionalHabs}" />&nbsp;<input type="button" value="..." class="btext"
					title="Show Selected Habitations" 
					onclick="javascript: fnShowFunctionalHabs('<c:out value='${item.assetCode}'/>')">
			</td>
			<c:set var="programmes" value="${item.programmes}" />
			<td align="left">
				<c:forEach items="${programmes}" var="programmeBean"> 
					<c:out value="${programmeBean.programmeName}" />
					<c:if test="${not empty programmeBean.subprogrammeName}">
					/&nbsp;<c:out value="${programmeBean.subprogrammeName}"/>
					</c:if>
					<br>
				</c:forEach>
			</td>			
			<td align="right">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.estimateCost}" />&nbsp;
			</td>
			<td align="center"><c:out value="${item.financialYear}" /></td>
			<td align="center">
				<input type="button" name="edit" value="<bean:message key='button.edit' />"
					   onclick="javascript: editOM('<c:out value='${item.proposalId}'/>')"	
					   class="btext"
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
	<td colspan="10">
		<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th align="left">&nbsp;
				<a href="javascript: checkAll('sel','subs')" id="white">Check All</a>
				<a href="javascript: clearAll('sel','subs')" id="white">Clear All</a>
			</th>
			<th class="label" align="right">
				<b>Total No. of Submitted Proposals:&nbsp;<c:out value="${index+1}"/></b>
			</th>
		</tr>
		</table>
	</td>
	</tr>
	</tfoot>
</table>
	<table width="100%">
	<tr>
		<td>
		<logic:empty name="OMProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideForward('sel','subs')">
		</logic:empty>
		<logic:notEmpty name="OMProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" onclick="javascript:fnShowHideForward('sel','subs')"
				   <c:if test="${RWS_USER.headOfOffice == 'false'}">
				   	disabled = "disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<logic:empty name="OMProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideSubmit('sel','subs')">
		</logic:empty>
		<logic:notEmpty name="OMProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" onclick="javascript:fnShowHideSubmit('sel','subs')"
				   <c:if test="${RWS_USER.headOfOffice == 'false'}">
				   	disabled = "disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<input type="button" class="btext" name="cmbShowHideDeffer" value="Others" 
			   style="width:75px" onclick="javascript:fnShowHideDeffer('sel','subs')"
			   <c:if test="${RWS_USER.headOfOffice == 'false'}">
				   	disabled = "disabled"
			   </c:if>
		>
	</td>
	<c:set var="officeType" value="${sessionScope.RWS_USER.officeName}" />
	<c:if test="${officeType == 'Head Office'}">
	<td align="right">
		<c:if test="${RWS_USER.headOfOffice == 'true'}">
			<html:button property="mode" styleClass="btext" style="width:150px" 
			   value="Consider for Sanction" onclick="javascript: fnConsiderForSanction(this.form)"/>
	   </c:if>
	   <c:if test="${RWS_USER.headOfOffice == 'false'}">
			<html:button property="mode" styleClass="btext" style="width:150px" disabled="true"
			   value="Consider for Sanction" onclick="javascript: fnConsiderForSanction(this.form)"/>
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

<logic:present name="forwardedProposals">
<c:set var="pending" value="true" />
<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.forwardedProposals" /> 
	</legend>
	<label>
	<table bgcolor="#DEE3E0" border="1" bordercolor="black" cellpadding="0" 
	cellspacing="0" style="border-collapse:collapse;" width="750" >
	<thead class="gridLabel">
	<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.select" /></th>
			<th><bean:message key="app.proposalId" /></th>
			<th><bean:message key="app.assetName" /></th>
			<th><bean:message key="app.selectedHabs"/></th>
			<th><bean:message key="app.programme" />/
				<br><bean:message key="app.subprogramme" />
			</th>
			<th><bean:message key="app.estimateCost" /><br>(Rs. in lakhs)</th>
			<th><bean:message key="app.financialYear" /></th>
			<th><bean:message key="app.action" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="officeCode" value="" />
	<c:forEach items="${forwardedProposals}" var="item" varStatus="status">
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
	<tr class="<c:out value='row${index%2}'/>" id="<c:out value='${item.officeCode}'/>">
			<td align="center">
				<input type="checkbox" name="sel" id="fwd" value="<c:out value='${item.proposalId}'/>">
			</td>
			<td width="125px" style="display:block;cursor:hand" 
				onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
				onmouseout="hideddrivetip()"><c:out value="${item.proposalId}"/>
			</td>
			<td align="left" width="150px"><c:out value="${item.assetName}" /></td>
			<td align="center">
				<c:out value="${item.noOfFunctionalHabs}" />&nbsp;<input type="button" value="..." class="btext"
					title="Show Selected Habitations" 
					onclick="javascript: fnShowFunctionalHabs('<c:out value='${item.assetCode}'/>')">
			</td>
			<c:set var="programmes" value="${item.programmes}" />
			<td align="left">
				<c:forEach items="${programmes}" var="programmeBean"> 
					<c:out value="${programmeBean.programmeName}" />
					<c:if test="${not empty programmeBean.subprogrammeName}">
					/&nbsp;<c:out value="${programmeBean.subprogrammeName}"/>
					</c:if>
					<br>
				</c:forEach>
			</td>
			<td align="right">
				<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.estimateCost}" />&nbsp;
			</td>
			<td align="center"><c:out value="${item.financialYear}" /></td>
			<td align="center">
				<input type="button" name="edit" value="<bean:message key='button.edit' />"
					   onclick="javascript: editOM('<c:out value='${item.proposalId}'/>')"	
					   class="btext"
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
	<td colspan="10">
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
		<td>
		<logic:empty name="OMProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideForward('sel','fwd')">
		</logic:empty>
		<logic:notEmpty name="OMProposalForm" property="forwardTo">
			<input type="button" class="btext" name="cmbShowHideForward" value="Forward" 
				   style="width:75px" onclick="javascript:fnShowHideForward('sel','fwd')"
				   <c:if test="${RWS_USER.headOfOffice == 'false'}">
				   	disabled = "disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<logic:empty name="OMProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" disabled="disabled"
				   onclick="javascript:fnShowHideSubmit('sel','fwd')">
		</logic:empty>
		<logic:notEmpty name="OMProposalForm" property="submitTo">
			<input type="button" class="btext" name="cmbShowHideSubmit" value="Submit" 
				   style="width:75px" onclick="javascript:fnShowHideSubmit('sel','fwd')"
				   <c:if test="${RWS_USER.headOfOffice == 'false'}">
				   	disabled = "disabled"
				   </c:if>
			>
		</logic:notEmpty>
		<input type="button" class="btext" name="cmbShowHideDeffer" value="Others" 
				   style="width:75px" onclick="javascript:fnShowHideDeffer('sel','fwd')"
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
</logic:present>
</td>
</tr>

<tr bgcolor="#DEE3E0" id="submitPanel" style="display:none">
<td>
	<fieldset>
		<legend><bean:message key="legend.submit" /></legend>
		<label>
		<table align="left">
		<tbody class="formTBody">
		<logic:notEmpty name="OMProposalForm" property="submitTo">
		<tr>
			<td><bean:message key="app.submitTo" /></td>
			<td>:</td>
			<td colspan="4">
				<span style="font-weight:normal;">
					<bean:write name="OMProposalForm" property="submitOffice" />
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
				<a href="javascript: showCalendar(document.OMProposalForm.submitDate);">
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
		<logic:notEmpty name="OMProposalForm" property="forwardTo">
		<tr>
			<td><bean:message key="app.forwardTo" /><span class="mandatory">*</span></td>
			<td>:</td>
			<td colspan="4">
				<span style="font-weight:normal;">
					<html:text property="forwardOffice" styleClass="thin-text-box" readonly="true" style="width:400px"/>
					<html:hidden property="forwardTo" />
					<html:hidden property="actionTo" />
					<input type="button" style="width:150px" 
						   value='Select <bean:write name="OMProposalForm" property="forwardOffice"/>' onclick="javascript:fnShowOffices(this)" class="btext">
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
				<a href="javascript: showCalendar(document.OMProposalForm.forwardDate);">
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
				<html:select property="actionType" styleClass="combo" style="width:250px">
					<html:option value="">SELECT...</html:option>
					<html:option value="D">DEFER</html:option>
					<html:option value="T">TRANSMIT TO OTHER DEPARTMENT</html:option>
				</html:select>
			</td>
		</tr>
		<tr>
			<td valign="top">
			<bean:message key="app.remarks" /><span class="mandatory">*</span>
			</td>
			<td valign="top">:</td>
			<td>
				<html:textarea property="otherRemarks" rows="5" cols="71" styleClass="thin-text-box" 
							   onkeypress="return textOnly(event)" />
			</td>
		</tr>
		<tr>
			<td align="center" colspan="3">
			<html:button property="mode" styleClass="btext"
				  onclick="return validateDefer(this.form)">
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
</table>
</tbody>
</table>

<html:hidden name="RWS_USER" property="officeCode"/>
<html:hidden name="RWS_USER" property="userId"/>
<html:hidden property="init" />
</html:form>

<%@ include file="/commons/rws_tooltip.jsp" %>
<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />