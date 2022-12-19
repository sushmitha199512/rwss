<%@ include file="/commons/rws_header1.jsp"%>

<script language="JavaScript">
<!--
function fnInit()
{

}

function fnGenerateNewSourceCode()
{
var circleOfficeCode=document.forms[0].circleOfficeCode.value;
var divisionOfficeCode=document.forms[0].divisionOfficeCode.value;
var subdivisionOfficeCode=document.forms[0].subdivisionOfficeCode.value;
var assetType=document.forms[0].assetType.value;
	if(document.forms[0].subSourceType!="")
	{
		url = "switch.do?prefix=/estimates&page=/NewEstimateAction.do?mode=generateNewSourceCode&circleOfficeCode="+circleOfficeCode+"&divisionOfficeCode="+divisionOfficeCode+"&subdivisionOfficeCode="+subdivisionOfficeCode+"&assetType="+assetType;
		window.open(url,"","width=600,height=400,left=100,top=100,scrollbars=1,resizable=1");
	}
	else
	{
		alert("Please Select SubSourceType");
	}
}

function isExistingSourceClicked()
{
document.forms[0].action="switch.do?prefix=/estimates&page=/NewEstimateData.do";
document.forms[0].submit();
}
function fnGetOffices(that)
{
	form = that.form;
	form.action = "switch.do?prefix=/estimates&page=/NewEstimateData.do";
	form.submit();
}

function getData(that)
{
	form = that.form;
	form.action = "switch.do?prefix=/estimates&page=/NewEstimateData.do";
	form.submit();
}

function getSubComponent(that)
{
	var field = that.name;
	var index = field.substr(10,1);
	
	var assetType = document.getElementById("assetType").value;	
	document.getElementById("rws_temp").src = "switch.do?prefix=/estimates&page=/NewEstimateData.jsp?assetType="+assetType+"&componentCode="+that.value+"&index="+index;
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
		//alert(url);
		var dimensionWindow	= window.open(url, "", properties);
		dimensionWindow.moveTo(10,10);
	}
}

function showWorkDetails(that)
{
	form = that.form;
	var workId = form.workId.value;
	if(workId.length == 14)
	{
		var url = "switch.do?prefix=/estimates&page=/ShowWorkDetails.do&type=new&workId="+workId;
		var newWindow = window.open(url,'','width=745, height=320,toolbar=no,status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,resizable=yes');
	}
	else
	{
		alert("Please select a Work");
	}
}

function fnSave(frm)
{
	if(validateNewEstimateForm(frm))
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

//-->
</script>
<body onload="fnInit()">
<html:javascript formName="NewEstimateForm" />
<%@ include file="/commons/rws_header2.jsp"%>

<html:form action="NewEstimateAction" method="post" enctype="multipart/form-data">
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead>
<tr>
	<td>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="New Estimates - Preparation" />
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
	</td>
</tr>
</thead>

<tfoot>
<tr>
	<td>
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
	</td>
</tr>
</tfoot>

<tbody class="formTbody">
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
					<html:option value="00"><bean:message key="app.pleaseSelect" /></html:option>
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
			<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
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
		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="0">
			<html:select property="subdivisionOfficeCode" styleClass="combo"
						 onchange="javascript: fnGetOffices(this)">
			<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
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
	<fieldset><legend>Estimate Details</legend>
	<label>
	<table>
	<tbody class="formTBody">
	<tr>
		<td class="column1">Asset Type<span class="mandatory">*</span></td>
		<td class="column2"><html:select property="assetType"
				onchange="javascript: getData(this)" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<html:options collection="assetTypes" name="labelValueBean"
					property="value" labelProperty="label" />
					</html:select>
		</td>
		<td class="column3"></td>
		<td class="column4"></td>
	 </tr>
	 <tr>	
		<td class="column1">Work<span class="mandatory">*</span></td>
		<td colspan="3">
		<html:select property="workId" style="width:500px" onchange="javascript: getData(this)">
			<html:option value="">SELECT...</html:option>
			<html:options collection="workIds" name="labelValueBean"
						property="value" labelProperty="label" />
		</html:select><input type="button" name="workDetails" class="btext" value="..." onclick="javascript: showWorkDetails(this)">
		</td>
	</tr>
	<tr>
		<td class="column1">Estimate Amount<span class="mandatory">*</span>
		<br><span style="font:menu">(Rs. in lakhs)</span>
		</td>
		<td class="column2"><html:text property="estimateAmount"
			readonly="true" styleClass="thin-text-box" /></td>
		<td class="column3">Sanctioned Amount<span class="mandatory">*</span>
		<br><span style="font:menu">(Rs. in lakhs)</span>
		</td>
		
		<td class="column4"><html:text property="sanctionedAmount"
			readonly="true" styleClass="thin-text-box" /></td>
	</tr>
	
	<% if(request.getAttribute("isExistingSource")==null || request.getAttribute("isExistingSource").equals("")){ %>
	<tr>
		<td>
		<html:radio property="isExistingSource" value="false" onclick="isExistingSourceClicked()"/>&nbsp;&nbsp;New Source
		</td>
		<td>
		<html:radio property="isExistingSource" value="true" onclick="isExistingSourceClicked()"/>&nbsp;&nbsp;Existing Source
		</td>
	</tr>
	<%} else {%>
	<html:hidden property="isExistingSource" />
	<%} %>
	<% if(request.getAttribute("isExistingSource")!=null && request.getAttribute("isExistingSource").equals("true")){ %>
	<div id="showWhenExisting">
	<tr>
		<td class="column1">Source Type<span class="mandatory">*</span></td>
		<td class="column2"><html:select property="sourceType"
			onchange="javascript: getData(this)" styleClass="combo">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sourceTypes" name="labelValueBean"
				property="value" labelProperty="label" />
		</html:select></td>
		<td class="column3">Sub Source Type<span class="mandatory">*</span></td>
		<td class="column4"><html:select property="subsourceType"
			onchange="javascript: getData(this)" styleClass="combo">
			<html:option value="">SELECT...</html:option>
			<html:options collection="subsourceTypes"
				name="labelValueBean" property="value" labelProperty="label" />
		</html:select></td>
	</tr>
	<tr>
		<td class="column1">Source<span class="mandatory">*</span></td>
		<td class="column2">
			<html:select property="sourceCode" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<html:options collection="sources" name="labelValueBean"
					property="value" labelProperty="label" />
			</html:select>
			<input type="button" class="btext" value="..." title="Show Source Details"
				   onclick="javascript: fnShowSourceDetails('sourceCode')">
		</td>
		<td class="column3">Financial Year<span class="mandatory">*</span></td>
		<td class="column4"><html:select property="financialYear"
			styleClass="combo">
			<html:option value="">SELECT...</html:option>
			<html:options collection="financialYears"
				name="labelValueBean" property="value" labelProperty="label" />
		</html:select></td>
	</tr>
	<tr>
		<td class="column1">No. of Components<span class="mandatory">*</span></td>
		<td class="column2"><html:text property="totalComponents"
			styleClass="thin-text-box"
			onkeypress="return numeralsOnly(event)"
			onblur="javascript: getData(this)" /></td>
		<td class="column3">Remarks</td>
		<td class="column4"><html:textarea property="remarks"
			styleClass="thin-text-box" onkeypress="upperOnly()" /></td>
	</tr>
	</div>
	<%} %>
	
	
	
	<% if(request.getAttribute("isExistingSource")!=null && request.getAttribute("isExistingSource").equals("false")){ %>
	<div id="showWhenNotExisting">
	<tr>
		<td class="column1">Source Type<span class="mandatory">*</span></td>
		<td class="column2"><html:select property="sourceType"
			onchange="javascript: getData(this)" styleClass="combo">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sourceTypes" name="labelValueBean"
				property="value" labelProperty="label" />
		</html:select></td>
		<td class="column3">Sub Source Type<span class="mandatory">*</span></td>
		<td class="column4"><html:select property="subsourceType"
			onchange="javascript: getData(this)" styleClass="combo">
			<html:option value="">SELECT...</html:option>
			<html:options collection="subsourceTypes"
				name="labelValueBean" property="value" labelProperty="label" />
		</html:select></td>
	</tr>
	<tr>
		<td class="column1">Source<span class="mandatory">*</span></td>
		<td class="column2">
			<html:text property="sourceCode" />
			<input type="button" class="btext" value="..." title="Show Source Details"
				   onclick="javascript: fnGenerateNewSourceCode()">
		</td>
		<td class="column3">Financial Year<span class="mandatory">*</span></td>
		<td class="column4"><html:select property="financialYear"
			styleClass="combo">
			<html:option value="">SELECT...</html:option>
			<html:options collection="financialYears"
				name="labelValueBean" property="value" labelProperty="label" />
		</html:select></td>
	</tr>
	<tr>
		<td class="column1">No. of Components<span class="mandatory">*</span></td>
		<td class="column2"><html:text property="totalComponents"
			styleClass="thin-text-box"
			onkeypress="return numeralsOnly(event)"
			onblur="javascript: getData(this)" /></td>
		<td class="column3">Remarks</td>
		<td class="column4"><html:textarea property="remarks"
			styleClass="thin-text-box" onkeypress="upperOnly()" /></td>
	</tr>
	</div>
	<%} %>
	
	
	</tbody>
	</table>
	</label>
	</fieldset>
</td>
</tr>
<c:if test="${NewEstimateForm.totalComponents > 0}">
<tr>
<td>
	<fieldset>
	<legend>Work Component/Sub Component Details</legend>
	<label>
	<table border="1" bordercolor="#000000"
		cellspacing="0" cellpadding="0" style="border-collapse:collapse">
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
		<nested:select name="COMPONENT" property="assetComponent"
			indexed="true" styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<nested:options collection="assetComponents" name="labelValueBean" 
				property="value" labelProperty="label" />
		</nested:select>
		</td>
		<td>
			<nested:text name="COMPONENT" property="amount" indexed="true"
				 styleClass="gridText" style="text-align:right"
				 onkeypress="return decimalsOnly(event)"/>
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
		<td class="column1">Detailed Estimate</td>
		<td class="column2" colspan="3">
			<html:file property="detailedEstimate" styleClass="thin-text-box" />
		</td>
	</tr>
	<tr>
		<td class="column1">Design Drawing</td>
		<td class="column2"><html:file property="designDrawing"
			styleClass="thin-text-box" /></td>
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
	<c:if test="${RWS_USER.headOfOffice == 'true'}">
		<html:submit property="mode" styleClass="btext" onclick="return fnSave(this.form)">
			<bean:message key="button.save" />
		</html:submit>
		<html:reset property="mode" styleClass="btext">
			<bean:message key="button.clear" />
		</html:reset>
		<html:submit property="mode" styleClass="btext">
			<bean:message key="button.view" />
		</html:submit>
	</c:if>
	<c:if test="${RWS_USER.headOfOffice == 'false'}">
		<html:submit property="mode" styleClass="btext" disabled="true" 
					 onclick="return fnSave(this.form)">
			<bean:message key="button.save" />
		</html:submit>
		<html:reset property="mode" styleClass="btext" disabled="true">
			<bean:message key="button.clear" />
		</html:reset>
		<html:submit property="mode" styleClass="btext" disabled="true">
			<bean:message key="button.view" />
		</html:submit>
	</c:if>
	</table>
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
<iframe src="" name="rws_temp" frameborder="0" width="200" height="100"
	marginwidth="1" marginheight="1" scrolling="yes" style="display: none"></iframe>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />
</body>
