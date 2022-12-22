<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="JavaScript">
<!--
function fnUpdate(frm)
{
	var elem = document.getElementById("WORK[0].proposalId");
	
	var leadHabitations = frm.elements(elem.value);
	var isAllowed = false;
	if(leadHabitations)
	{
		if(typeof leadHabitations.length != 'number')
			leadHabitations = [leadHabitations];
		
		for(var i=0; i<leadHabitations.length; i++)
		{
			if(leadHabitations[i].checked)
				isAllowed = true;
		}
	}
	
	if(isAllowed)
	{
	 	if(fnConfirmUpdate())
		 	return true;
		else
			return false;
	}
	else
	{
		alert("Please select Lead Habitation");
		return false;
	}
}
function fnSubmit()
{
	var frm = document.forms["RepresentativeProposalForm"];
	var proposalId = document.getElementById("WORK[0].proposalId").value;
	var url = "switch.do?prefix=/proposals&page=/EditRepProposal.do&mode=ENDRS&proposalId="+proposalId;
	frm.action = url;
	frm.submit();
}
function fnCancel(that)
{
	var frm = that.form;
	var typeValue = frm.type.value;
	var url = "";
	if(typeValue == "cons")
	{
	 url = "switch.do?prefix=/proposals&page=/NewProposalData.do";		
	}
	else
	{		
	 url = "switch.do?prefix=/proposals&page=/RepresentativeProposalAction.do"
			+ "&mode=View";	 
	}
	frm.action = url;
	frm.submit();
}

function getSubprogrammes(that)
{

	var frm = that.form;
	var programmeCode = that.value;
	var url = "switch.do?prefix=/proposals&page=/EditRepProposal.do&mode=subprogrammes";
	frm.action = url;
	frm.submit();		
}
function getOffices(that)
{
	form = that.form;
	form.action = "switch.do?prefix=/proposals&page=/RepProposalData.do";
	form.submit();
}

function getConstituencies(that)
{
	form = that.form;
	form.action =  "switch.do?prefix=/proposals&page=/EditRepProposal.do&mode=constituencies";
	form.submit();
}
function getRepName(that)
{
	form = that.form;
	form.action = "switch.do?prefix=/proposals&page=/EditRepProposal.do&mode=repname";
	form.submit();
}

function addRemoveHabs()
{	
	var proposalId = document.getElementById("WORK[0].proposalId").value;
	var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("circleOfficeCode").value;
	var doc = document.getElementById("divisionOfficeCode").value;
	var soc = document.getElementById("subdivisionOfficeCode").value;
	var officeCode = hoc+coc+doc+soc;
	var url = "switch.do?prefix=/proposals&page=/AddRemoveHabs.do&mode=addRemoveHabs"
		    + "&proposalId="+proposalId+"&officeCode="+officeCode;
	var properties = "width=548,height=285,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
	newWindow.moveTo(10,10);
}
//-->
</script>
<html:javascript formName="RepresentativeProposalForm" />

 

<html:form action="EditRepProposal" onsubmit="return validateRepresentativeProposalForm(this)">

<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Representative Proposal Form" />
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
<legend><bean:message key="legend.rwsOffices" /></legend>
<label>
	<table>
	<tbody class="formTBody">
	<tr>
		<td class="column1">
			<bean:message key="app.headoffice" />
	</td>
		<td class="column2">
			<logic:present name="headoffices">
				<html:select property="headOfficeCode" onchange="javascript: getOffices(this)"
							 styleClass="combo">
					<html:option value="0"><bean:message key="app.pleaseSelect"/></html:option>
					<html:options collection="headOffices" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</html:select>
				</logic:present>
			<logic:notPresent name="headoffices">
					<html:text property="headOfficeName" styleClass="thin-text-box" 
							name="RWS_USER" readonly="true"/>
					<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notPresent>
		</td>
		<td class="column3">
			<bean:message key="app.circle" /></td>
		<td class="column4">
			<logic:present name="circles">
				<html:select property="circleOfficeCode" onchange="javascript: getOffices(this)" 
							 styleClass="combo">
					<html:option value="00"><bean:message key="app.pleaseSelect"/></html:option>
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			</logic:present>
			<logic:notPresent name="circles">
				<html:text property="circleOfficeName" styleClass="thin-text-box" 
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notPresent>
		</td>
	</tr>
	<tr>
		<td class="column1"><bean:message key="app.division" /></td>
		<td class="column2">
		<logic:present name="divisions">
			<html:select property="divisionOfficeCode" onchange="javascript: getOffices(this)"
						 styleClass="combo">
			<html:option value="0"><bean:message key="app.pleaseSelect"/></html:option>
			<html:options collection="divisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</html:select>
		</logic:present>
		<logic:notPresent name="divisions">
			<html:text property="divisionOfficeName" styleClass="thin-text-box" 
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notPresent>
		</td>
		<td class="column3"><bean:message key="app.subdivision" /></td>
		<td class="column4">
		<logic:present name="subdivisions">
			<html:select property="subdivisionOfficeCode" styleClass="combo">
			<html:option value="00"><bean:message key="app.pleaseSelect"/></html:option>
			<html:options collection="subdivisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</html:select>
		</logic:present>
		<logic:notPresent name="subdivisions">
			<html:text property="subdivisionOfficeName" styleClass="thin-text-box" 
					   name="RWS_USER" readonly="true"/>
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
<legend><bean:message key="legend.representativeDetails" /></legend>
<label>
<table>
<tbody class="formTBody">
<tr>
	<td class="column1">
		<bean:message key="app.code"/><span class="mandatory">*</span>
	</td>
	<td class="column2">
		<logic:present name="representatives">
			<html:select property="repCode" onchange="javascript: getConstituencies(this)"
						 styleClass="combo">
				<html:option value=""><bean:message key="app.pleaseSelect"/></html:option>
				<html:options collection="representatives" name="labelValueBean"
							  property="value" labelProperty="label"/>
			</html:select>
		</logic:present>
	</td>				 
	<logic:present name="constituencies">
	<td class="column3"><bean:message key="app.constituency" /></td>
	<td class="column4">
		<html:select property="constituencyCode" onchange="javascript: getRepName(this)"
					 styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect"/></html:option>
			<html:options collection="constituencies" name="labelValueBean"
						  property="value" labelProperty="label"/> 
		</html:select>
	</td>
	</logic:present>
</tr>
<tr>
	<td class="column1">
		<bean:message key="app.name" /><span class="mandatory">*</span>
	</td>
	<td class="column2">
		<html:text property="repName" maxlength="20" styleClass="thin-text-box" 
		onkeypress="upperOnly(event)" />
	</td>
	<td class="column3"><bean:message key="app.address" /></td>
	<td class="column4">
		<html:textarea property="repAddress" styleClass="thin-text-box" onkeypress="upperOnly(event)" />
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
		<html:text property="repDate" size="14" styleClass="thin-text-box" maxlength="10" />
		<a href="javascript: showCalendar(document.RepresentativeProposalForm.repDate);">
			<img src="<rws:context page='/images/calendar.gif'/>" border="0" align="absmiddle">
		</a>
	</td>
	<td class="column3"><bean:message key="app.description" /></td>
	<td class="column4">
		<html:textarea property="description" styleClass="thin-text-box" onkeypress="upperOnly(event)"/>
	</td>
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
		<html:text property="endorsementNo" maxlength="15" styleClass="thin-text-box" 
				   onkeypress="upperOnly(event)"/>
	</td>
</tr>
<tr>
	<td class="column1"><bean:message key="app.endorsementDate" /></td>
	<td class="column2">
		<html:text property="endorsementDate" size="14" maxlength="10" styleClass="thin-text-box" />
		<a href="javascript: showCalendar(document.RepresentativeProposalForm.endorsementDate);">
			<img src="<rws:context page='/images/calendar.gif'/>" border="0" align="absmiddle">
		</a>
	</td>	
	<td class="column3"><bean:message key="app.recommendations" /></td>
	<td class="column4">
		<html:text property="recommendations" maxlength="30" styleClass="thin-text-box" 
				   onkeypress="upperOnly(event)"/>
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
<table width="100%" border="1" bordercolor="#000000" cellpadding="0" cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
	<tr>
		<th><bean:message key="app.workName" /></th>
		<th><bean:message key="app.selectedHabs" /></th>
		<th><bean:message key="app.scheme" /></th>
		<th><bean:message key="app.programme" /></th>
		<th><bean:message key="app.subprogramme" /></th>
		<th><bean:message key="app.priority" /></th>
		<th><bean:message key="app.estimateCostBR" /></th>
		<th><bean:message key="app.proposalId" /></th>
		<th><bean:message key="app.remarks" /></th>
	</tr>
</thead>
<tbody class="formTBody">
<nested:iterate id="WORK" property="proposals" indexId="ndx">
<tr bgcolor="#ffffff" id="row1" style="display: block" summary="Grid Row for First Work">
	<td>
		<nested:text name="WORK" property="proposalName" indexed="true"
				   maxlength="100" styleClass="gridText" style="width:130px"
				   onkeypress="return textOnly(event)"/>
	</td>
	<td align="center">
		<nested:text name="WORK" property="noOfHabs" indexed="true"  
				     readonly="true" styleClass="gridText" style="text-align:center"/>
	</td>
	<td>
		<nested:select name="WORK" property="typeOfAsset" indexed="true"
					 styleClass="gridText" style="width:80px">
			<html:option value=""><bean:message key="app.pleaseSelect"/></html:option>
			<nested:options collection="assetTypes" name="labelValueBean"
						  property="value" labelProperty="label"/> 
		</nested:select>
	</td>
	<td>
		<nested:select name="WORK" property="programmeCode" styleClass="gridText" style="width:80px" 
					   indexed="true" onchange="javascript: getSubprogrammes(this)">
			<html:option value=""><bean:message key="app.pleaseSelect"/></html:option>
			<nested:options collection="programmes" name="labelValueBean"
						  property="value" labelProperty="label"/> 
		</nested:select>
	</td>
	<td>
		<nested:select name="WORK" property="subprogrammeCode" indexed="true"
					   styleClass="gridText" style="width:92px">
		<html:option value=""><bean:message key="app.pleaseSelect"/></html:option>
		<logic:notEmpty name="WORK" property="subprogrammes">
					<nested:optionsCollection property="subprogrammes" />
		</logic:notEmpty>
		</nested:select>
	</td>
	<td>
		<nested:select name="WORK" property="priorityCode" indexed="true" 
					  styleClass="gridText" style="width:80px">
			<html:option value=""><bean:message key="app.pleaseSelect"/></html:option>
			<nested:options collection="priorities" name="labelValueBean"
						  property="value" labelProperty="label"/> 
		</nested:select>
	</td>
	<td>
		<nested:text name="WORK" property="estimateCost" maxlength="10" styleClass="gridText"
				     style="width:50px;text-align:right" indexed="true"
					 onkeypress="decimalsOnly(event)" />
	</td>
	<td align="center">
		<nested:text name="WORK" property="proposalId" readonly="true" indexed="true"
				     styleClass="gridText" style="width:77"/>
	</td>
	<td>
		<nested:text name="WORK" property="remarks" onkeypress="textOnly(event)" indexed="true"
				     maxlength="100" styleClass="gridText" style="width:60" />
	</td>
</tr>
</nested:iterate>
</tbody>
</table>
</label>
</fieldset>

</td>
</tr>
<html:hidden property="leadHabitation" />
<tr id="id1">
<td>
<fieldset>
<legend>Selected Habitations</legend>
<label>
	<table id="proTable" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse:collapse">
	<thead class="gridLabel">
		<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.leadHabitation" /></th>
			<th><bean:message key="app.habitationCode" /></th>
			<th><bean:message key="app.habitationName" /></th>
			<th><bean:message key="app.population" /></th>
			<th><bean:message key="app.status" /></th>
		</tr>
	</thead>
	<tbody class="gridText">
	<c:forEach items="${sessionScope.habs}" var="item" varStatus="status">
		<c:set var="index" value="${status.index}" />
		<tr class="<c:out value='row${index%2}'/>">
			<td align="center">
			<input type="radio" name="<c:out value='${WORK.proposalId}'/>"
				   value="<c:out value="${item.habCode}"/>">
			<input type="hidden" name="habCodes" value="<c:out value="${item.habCode}"/>">	   
			</td>
			<td><c:out value="${item.habCode}"/></td>
			<td><c:out value="${item.habName}"/></td>
			<td align="right"><c:out value="${item.population}"/>&nbsp;</td>
			<td>&nbsp;<c:out value="${item.status}"/></td>
		</tr>
	</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<td align="left" colspan="5">
				<html:button property="mode" style="width: 150px" styleClass="btext" 
							 onclick="javascript: addRemoveHabs()">
					<bean:message key="button.addRemoveHabs" />
				</html:button>
			</td>
		</tr>
	</tfoot>
	</table>
</label>
</fieldset>
<script>
var frm = document.forms[0];
var oldHabs = frm.elements("<c:out value='${WORK.proposalId}'/>") ;
if(oldHabs)
{
	if(typeof oldHabs.length != "number") 
		oldHabs = [oldHabs];
	
	var leadHabCode = document.getElementById("leadHabitation").value; 
		
	for(var k=0; k<oldHabs.length; k++)
	{	
		if(oldHabs[k].value == leadHabCode)
		{
			oldHabs[k].checked = true;
		}
	}
}
</script>
</td>
</tr>
<tr>
	<td align="center">
		<html:submit property="mode" styleClass="btext" onclick="return fnUpdate(this.form)">Update</html:submit>
		<html:reset property="reset" styleClass="btext">Clear</html:reset>
		<html:button property="mode" styleClass="btext" onclick="javascript: fnCancel(this)">Cancel</html:button>
	</td>
</tr>
</table>
</td>
</tr>



</tbody>
</table>
<html:hidden property="init" />
<input type="hidden" name="type" value="<%= request.getAttribute("type")%>">
</html:form>
<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />