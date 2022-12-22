<%@ include file="/commons/rws_header1.jsp" %>

<script language="JavaScript">
<!--
var show = true;
function fnShowHideForward(id)
{
	if(show)
	{
		document.getElementById(id).style.display="block";
		document.getElementById("cmbShowHideForward").value = "Hide Forward Panel";
		show = false;
	}
	else
	{
		document.getElementById(id).style.display="none";
		document.getElementById("cmbShowHideForward").value = "Show Forward Panel";
		show = true;
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
	frm = that.form;
	frm.action = "switch.do?prefix=/estimates&page=/OMEstimateData.do";
	frm.submit();
}
function getData(that)
{
	frm = that.form;
	frm.action = "switch.do?prefix=/estimates&page=/OMEstimateData.do";
	frm.submit();
}

function getComponents(that)
{
	if(!isEmpty(that))
	{
		frm = that.form;
		frm.action = "switch.do?prefix=/estimates&page=/OMEstimateData.do";
		frm.submit();
	}
}

function showWorkDetails(that)
{
	form = that.form;
	var workId = form.workId.value;
	if(workId.length == 20)
	{
		var url = "switch.do?prefix=/estimates&page=/ShowWorkDetails.do&type=om&workId="+workId;
		var properties = 'width=745,height=320,toolbar=no,status=no,menubar=no,location=no,directories=no,'
					   + 'scrollbars=yes,copyhistory=no,resizable=yes';
		var newWindow = window.open(url,"",properties);
	}
	else
	{
		alert("Please select a Work");
	}
	
}



function fnSave(frm)
{
	if(validateOMEstimateForm(frm))
	{
		var noOfComponents = frm.totalComponents.value;

		noOfComponents = parseInt(noOfComponents);

		var msg = "";
		for(var i=0; i<noOfComponents; i++)
		{	
			var assetComponent = document.getElementById("COMPONENT["+i+"].assetComponent");
			var amount = document.getElementById("COMPONENT["+i+"].amount");
			if(assetComponent.value == "")
				msg += "Work Component " + (i+1) + " is required\n";
			if(isEmpty(amount))	
				msg += "Amount " + (i+1) + " is required\n";
			else
			if(!isPositiveDecimal(amount))	
				msg += "Amount " + (i+1) + " is invalid\n";
		}

		if(msg != "")
		{
			alert(msg);
			return false;
		}
		return true;
	}
	return false;
}
function fnPickTaskSubTask(index)
{
	var checkField = document.getElementById("COMPONENT["+index+"].taskSubTask");
	if(checkField.checked)
	{
		var ate = document.getElementById("assetType");
		var wce = document.getElementById("COMPONENT["+index+"].assetComponent");
		var sce = document.getElementById("COMPONENT["+index+"].assetSubComponent");
		
		var atc = ate.value;
		var atn = ate[ate.selectedIndex].text;
		var wcc = wce.value;
		var wcn = wce[wce.selectedIndex].text;
		var scc = sce.value;
		var scn = sce[sce.selectedIndex].text;
		
		var url = "switch.do?prefix=/estimates&page=/PickTaskSubTask.do&mode=data"
				+ "&atc="+atc+"&atn="+atn+"&wcc="+wcc+"&wcn="+wcn
				+ "&scc="+scc+"&scn="+scn+"&ndx="+index;
		var properties = "width=666,height=200,toolbar=no,status=no,menubar=no,location=no,directories=no,"
					   + "scrollbars=yes,copyhistory=no,resizable=no";

		var dimensionWindow	= window.open(url, "", properties);
		dimensionWindow.moveTo(10,10);
	}
}
function fnCalculateAmount(index)
{
	var quanElem = document.getElementById("COMPONENT["+ index +"].quantity");
	var unitRateElem = document.getElementById("COMPONENT["+ index +"].unitRate"); 
	var amountElem = document.getElementById("COMPONENT["+ index +"].amount"); 
	var quantity = quanElem.value;
	var unitRate = unitRateElem.value;
	var amount = amountElem.value;	
	
	amount = quantity * unitRate;
	if(typeof amount == 'number')
		amountElem.value = amount.toFixed(2);  
	
}
//-->
</script>
<html:javascript formName="OMEstimateForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="OMEstimateAction" method="post" enctype="multipart/form-data">
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>

<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="O&M Estimates - Preparation" />
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

<tbody class="formTbody">
<tr>
<td>
<table border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.rwsOffices" /></legend>
	<label>
		<table>
		<tbody class="formTBody">
		<tr>
			<td class="column1"><bean:message  key="app.headOffice" /></td>
			<td class="column2">
				<logic:present name="headOffices">
					<html:select property="headOfficeCode" onchange="javascript: fnGetOffices(this)"
								 styleClass="combo">
					    <html:option value="0">SELECT...</html:option>
						<html:options collection="headOffices" name="labelValueBean"
									  property="value" labelProperty="label"/>
					</html:select>
				</logic:present>
				<logic:notPresent name="headOffices">
					<html:text property="headOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
					<html:hidden property="headOfficeCode" name="RWS_USER" />
				</logic:notPresent>
			</td>
			<td class="column3"><bean:message key="app.circle" /></td>
			<td class="column4">
				<logic:present name="circles">
					<html:select property="circleOfficeCode" onchange="javascript: fnGetOffices(this)"
								 styleClass="combo">
						<html:option value="00">SELECT...</html:option>
						<html:options collection="circles" name="labelValueBean"
									  property="value" labelProperty="label"/>
					</html:select>
				</logic:present>
				<logic:notPresent name="circles">
					<html:text property="circleOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
					<html:hidden property="circleOfficeCode" name="RWS_USER" />
				</logic:notPresent>
			</td>
		</tr>
		<tr>
			<td class="column1"><bean:message key="app.division" /></td>
			<td class="column2">
				<logic:present name="divisions">
					<html:select property="divisionOfficeCode" onchange="javascript: fnGetOffices(this)"
								 styleClass="combo">
						<html:option value="0">SELECT...</html:option>
						<html:options collection="divisions" name="labelValueBean"
									  property="value" labelProperty="label"/>
					</html:select>
				</logic:present>
				<logic:notPresent name="divisions">
					<html:text property="divisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
					<html:hidden property="divisionOfficeCode" name="RWS_USER" />
				</logic:notPresent>
			</td>
			<td class="column3"><bean:message key="app.subdivision" /></td>
			<td class="column4">
				<logic:present name="subdivisions">
					<html:select property="subdivisionOfficeCode" styleClass="combo">
					    <html:option value="0">SELECT...</html:option>
						<html:options collection="subdivisions" name="labelValueBean" 
									  property="value" labelProperty="label"/>
					</html:select>
				</logic:present>
				<logic:notPresent name="subdivisions">
					<html:text property="subdivisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
					<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
				</logic:notPresent>
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
	<legend>Estimate Details</legend>
	<label>
		<table>
		<tbody class="formTBody">
		<tr>
			<td class="column1">Asset Type<span class="mandatory">*</span></td>
			<td class="column2">
				<html:select property="assetType"  styleClass="combo">
					<html:option value="">SELECT...</html:option>
					<html:options collection="assetTypes" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			</td>
			<html:hidden property="assetType" />
			<script language="JavaScript">
			<!--
				document.getElementById("assetType").disabled = true;
			//-->
			</script>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td class="column1">Work <span class="mandatory">*</span></td>
			<td colspan="3">
				<html:select property="workId" onchange="javascript: getData(this)"
							 style="width:500px">
					<html:option value="">SELECT...</html:option>
					<html:options collection="workIds" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select><input type="button" name="workDetails" class="btext" value="..." 
					 onclick="javascript: showWorkDetails(this)">
			</td>
		</tr>
		
		<tr>
			<td class="column1">Estimate Amount<span class="mandatory">*</span>
			<br><span style="font:menu">(Rs. in lakhs)</span>
			</td>
			<td class="column2">
				<html:text property="estimateAmount" readonly="true" styleClass="thin-text-box" />
			</td>
			<td class="column3">Sanctioned Amount<span class="mandatory">*</span>
			<br><span style="font:menu">(Rs. in lakhs)</span>
			</td>
			<td class="column4">
				<html:text property="sanctionedAmount" readonly="true" styleClass="thin-text-box" />
			</td>
		</tr>
		<tr>
			<td class="column1">Source Type<span class="mandatory">*</span></td>
			<td class="column2">
				<html:select property="sourceType" onchange="javascript: getData(this)" 
							 styleClass="combo">
					<html:option value="">SELECT...</html:option>
					<html:options collection="sourceTypes" name="labelValueBean" property="value"
								  labelProperty="label" />
				</html:select>
			</td>
			<td class="column3">Sub Source Type<span class="mandatory">*</span></td>
			<td class="column4">
				<html:select property="subsourceType" onchange="javascript: getData(this)" 
							 styleClass="combo">
					<html:option value="">SELECT...</html:option>
					<html:options collection="subsourceTypes" name="labelValueBean" property="value"
								  labelProperty="label" />
				</html:select>
			</td>
		</tr>
		<tr>
			<td class="column1">Source<span class="mandatory">*</span></td>
			<td class="column2">
				<html:select property="sourceCode" styleClass="combo">
					<html:option value="">SELECT...</html:option>
					<html:options collection="sources" name="labelValueBean" property="value"
								  labelProperty="label" />
				</html:select>
				<input type="button" class="btext" value="..." title="Show Source Details"
				   onclick="javascript: fnShowSourceDetails('sourceCode')">
			</td>
			<td class="column3">Financial Year<span class="mandatory">*</span></td>
			<td class="column4">
				<html:select property="financialYear" styleClass="combo">
					<html:option value="">SELECT...</html:option>
					<html:options collection="financialYears" name="labelValueBean" property="value"
								  labelProperty="label" />
				</html:select>
			</td>
		</tr>
		<tr>
			<td class="column1">Manpower Charges</td>
			<td class="column2">
				<html:text property="manpowerCharges" styleClass="thin-text-box" 
						   onkeypress="return decimalsOnly(event)"/>
			</td>
			<td class="column3">Power Charges</td>
			<td class="column4">
				<html:text property="powerCharges" styleClass="thin-text-box" 
						   onkeypress="return decimalsOnly(event)"/>
			</td>
		</tr>
		<tr>
			<td class="column1">Consumables</td>
			<td class="column2">
				<html:text property="consumables" styleClass="thin-text-box" 
						   onkeypress="return decimalsOnly(event)" />
			</td>
			<td class="column3">Repairs &amp; Renewals</td>
			<td class="column4">
				<html:text property="repairs" styleClass="thin-text-box"
						   onkeypress="return decimalsOnly(event)" />
			</td>
		</tr>
		<tr>
			<td class="column1">Other Charges</td>
			<td class="column2">
				<html:text property="others" styleClass="thin-text-box"
						   onkeypress="return decimalsOnly(event)" />
			</td>
			<td class="column3">Remarks</td>
			<td class="column4">
				<html:textarea property="remarks" styleClass="thin-text-box" 
							   onkeypress="upperOnly()"/>
			</td>
		</tr>
		<tr>
			<td class="column1">No. of Components<span class="mandatory">*</span></td>
			<td class="column2">
				<html:text property="totalComponents" styleClass="thin-text-box"  
					  onkeypress="return numeralsOnly(event)" onblur="javascript: getComponents(this)"/>
			</td>
		</tr>
		</tbody>
		</table>
	</label>
	</fieldset>
</td>
</tr>
<c:if test="${OMEstimateForm.totalComponents > 0}">
<tr>
<td>
	<fieldset>
	<legend>Work Component/Sub Component Details</legend>
	<label>
		<table border="1" bordercolor="#000000" cellspacing="0" cellpadding="0" 
			   style="border-collapse:collapse">
		<thead class="gridHeader">
		<tr bgcolor="#8A9FCD">
			<th width="150">Work Component</th>	
			<th>Amount (Rs. in lakhs)</th>
		</tr>
		</thead>
		<tbody class="gridContent">
		<nested:iterate id="COMPONENT" property="components" indexId="ndx">
		<tr bgcolor="#ffffff">
			<td>
				<nested:select name="COMPONENT" property="assetComponent" indexed="true"
							 styleClass="combo">
					<html:option value="">SELECT...</html:option>
					<nested:options collection="assetComponents" name="labelValueBean"
								  property="value" labelProperty="label" />
				</nested:select>
			</td>
			<td>
				<nested:text name="COMPONENT" property="amount" indexed="true" 
					 		 styleClass="gridText" style="text-align: right"
					 		 onkeypress="return decimalsOnly(event)" />
			</td>
		</tr>
		</nested:iterate>
		</tbody>
		</table>
	</label>
	</fieldset>
</td>
</tr>
</c:if>
<tr>
<td>
	<fieldset>
	<legend>Uploads</legend>
	<label>
		<table>
		<tbody class="formTBody">
		<tr>
			<td class="column1">Layout<span class="mandatory">*</span></td>
			<td class="column2">
				<html:file property="layout" styleClass="thin-text-box" />
			</td>
		</tr>
		<tr>
			<td class="column1">Detailed Estimate<span class="mandatory">*</span></td>
			<td class="column2" colspan="3">
				<html:file property="detailedEstimate" styleClass="thin-text-box" />
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
	<table align="center">
		<html:submit property="mode" styleClass="btext" onclick="return fnSave(this.form)">
			<bean:message key="button.save" />
		</html:submit>
		<html:reset property="mode" styleClass="btext">
			<bean:message key="button.clear" />
		</html:reset>
		<html:submit property="mode" styleClass="btext">
			<bean:message key="button.view" />
		</html:submit>
	</table>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<html:hidden property="init" />
<html:hidden property="userId" name="RWS_USER"/>
<html:hidden property="officeCode" name="RWS_USER"/>
</html:form>

<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />