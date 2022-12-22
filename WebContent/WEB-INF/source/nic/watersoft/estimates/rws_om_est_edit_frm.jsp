<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="EditOMEstForm" />
<script>
function fnSave(frm)
{
	if(validateEditOMEstForm(frm))
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
		else
		if(fnConfirmUpdate())
		{
				var target = document.getElementById("target").value;
				var url = "switch.do?prefix=/estimates&page=/EditOMEstimate.do&mode=Save&target="+target;
				frm.action = url;
				frm.submit();
		}
		else
		return false;
		
	}
	else
	return false;
}
function fnGetSubSources(elem)
{
	var frm = elem.form;
	frm.action = "switch.do?prefix=/estimates&page=/EditOMEstimate.do&mode=subsources";
	frm.submit();
		
}
function fnGetSources(elem)
{
	var frm = elem.form;
	frm.action = "switch.do?prefix=/estimates&page=/EditOMEstimate.do&mode=sources";
	frm.submit();
}

function fnGetComponents(that)
{
	if(!isEmpty(that))
	{
		frm = that.form;
		frm.action = "switch.do?prefix=/estimates&page=/EditOMEstimate.do&mode=components";
		frm.submit();
	}
}
</script>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="EditOMEstimate">

<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="O&M Estimates - Edit Form" />
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
	<table width="100%" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
	<tbody class="formTBody">
	<tr>
		<td>Work Id</td>
		<td>
			<html:text property="workId" styleClass="thin-text-box" readonly="true" />
		</td>
		<td>Work Name</td>
		<td>
			<html:textarea property="workName" styleClass="thin-text-box" readonly="true" />
		</td>
	</tr>
	<tr>
		<td>Asset Type</td>
		<td>
			<html:text property="assetType" styleClass="thin-text-box" readonly="true" />
		</td>
		<td>Source Type</td>
		<td>
			<html:select property="sourceType" styleClass="combo" onchange="javascript: fnGetSubSources(this)">
				<html:option value="">SELECT...</html:option>
				<html:options collection="sourceTypes" name="labelValueBean" property="value"
							  labelProperty="label" />
			</html:select>
		</td>
	</tr>
	<tr>
		<td>Sub Source Type</td>
		<td>
			<html:select property="subsourceType" styleClass="combo" onchange="javascript: fnGetSources(this)">
				<html:option value="">SELECT...</html:option>
				<html:options collection="subsourceTypes" name="labelValueBean" property="value"
							  labelProperty="label" />
			</html:select>
		</td>
		<td>Source</td>
		<td>
			<html:select property="sourceCode" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<html:options collection="sources" name="labelValueBean" property="value"
							  labelProperty="label" />
			</html:select>
			<input type="button" class="btext" value="..." title="Show Source Details"
				   onclick="javascript: fnShowSourceDetails('sourceCode')">
		</td>
	</tr>
	<tr>
		<td>Estimate Amount</td>
		<td>
			<html:text property="estimateAmount" styleClass="thin-text-box" readonly="true" />
		</td>
		<td>Sanctioned Amount</td>
		<td>
			<html:text property="sanctionedAmount" styleClass="thin-text-box" readonly="true" />
		</td>
	</tr>
	<tr>
		<td>Financial Year<span class="mandatory">*</span></td>
		<td>
			<html:select property="financialYear" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<html:options collection="financialYears" name="labelValueBean" property="value"
							  labelProperty="label" />
			</html:select>
		</td>	
		<td>Manpower Charges</td>
		<td>
			<html:text property="manpowerCharges" styleClass="thin-text-box" onkeypress="return decimalsOnly()"/> 
		</td>
	</tr>
	<tr>
		<td>Power Charges</td>
		<td>
			<html:text property="powerCharges" styleClass="thin-text-box" onkeypress="return decimalsOnly()" />
		</td>	
		<td>Consumables</td>
		<td>
			<html:text property="consumables" styleClass="thin-text-box" onkeypress="return decimalsOnly()"/> 
		</td>
	</tr>
	<tr>
		<td>Repairs &amp; Renewals</td>
		<td>
			<html:text property="repairs" styleClass="thin-text-box" onkeypress="return decimalsOnly()"/>
		</td>	
		<td>Other Charges</td>
		<td>
			<html:text property="others" styleClass="thin-text-box" onkeypress="return decimalsOnly()"/> 
		</td>
	</tr>
	<tr>
		<td>Remarks</td>
		<td>
			<html:textarea property="remarks" styleClass="thin-text-box" onkeypress="upperOnly()"/> 
		</td>
		<td>No. of Components</td>
		<td>
			<html:text property="totalComponents" styleClass="thin-text-box" 
					   onkeypress="return numeralsOnly(event)" onblur="javascript: fnGetComponents(this)"/>
		</td>
	</tr>
	<c:if test="${EditOMEstForm.totalComponents > 0}">
	<tr>
	<td colspan="4">
		<fieldset>
		<legend><span style="font-weight:none">Work Component Details</span></legend>
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
		<td colspan="4" align="center">
			<html:button property="mode" styleClass="btext" value="Save" onclick="javascript: fnSave(this.form)"/>
			<html:reset styleClass="btext" value="Reset"/>
		</td>
	</tr>
	</tbody>	
	</table>
</td>
</tr>
</tbody>
</table>
<input type="hidden" id="target" name="target" value="<c:out value='${param.target}' />">
</html:form>
<%@ include file="/commons/rws_footer.jsp" %>