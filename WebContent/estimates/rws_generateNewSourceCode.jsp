<%@ include file="/commons/rws_header1.jsp"%>

<script language="JavaScript">
<!--
function fnInit()
{
<%if(request.getAttribute("sourceCodeExists")!=null && ((String)request.getAttribute("sourceCodeExists")).equals("false")){ %>

opener.document.forms[0].sourceCode.value=document.forms[0].sourceCode.value;
self.close();
<%}%>

}
function fnSubmit()
{
if(document.forms[0].habCode.value!="" && document.forms[0].schemeCode.value!="" && document.forms[0].sno.value!="")
{
	document.forms[0].action="switch.do?prefix=/estimates&page=/NewEstimateAction.do?mode=submitNewSourceCode";
	document.forms[0].submit();
}
else if(document.forms[0].habCode.value=="")
	alert("Habitation Code is required");
else if(document.forms[0].schemeCode.value=="")
	alert("SchemeCode is required");
else if(document.forms[0].sno.value=="")
	alert("SNO required");
	
}
function snoChanged()
{
	if(document.forms[0].habCode.value!="" && document.forms[0].schemeCode.value!="" && document.forms[0].sno.value!="")
	document.forms[0].sourceCode.value=document.forms[0].habCode.value+document.forms[0].schemeCode.value+"SO"+document.forms[0].sno.value;
	else
	document.forms[0].sourceCode.value="";
}
function getHabDirData1()
{
	document.forms[0].action="switch.do?prefix=/estimates&page=/NewEstimateAction.do?mode=generateNewSourceCode";
	document.forms[0].submit();
}
//-->
</script>
<body onload="fnInit()">
<html>
<%@ include file="/commons/rws_header2.jsp"%>

<html:form action="NewEstimateAction" >
<table border=0 align="center" cellpadding="0" cellspacing="0">

<thead>
<tr>
	<td>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="New Estimates - SourceCode Generation" />
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
	</table>
	</label>
	</fieldset>
	</td>
	</tr>
	<tr>
	<td>
	<fieldset>
	<legend><bean:message key="legend.habitationDetails"/></legend>
	<label>
	<table border=0 width="100%" align="center" cellspacing="8">
	<tr>
	<td class="textborder" width="80"><bean:message key="app.district" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
	 <html:text property="districtName" style="width:150px"  styleClass="mytext" readonly="true" />
		
	</td>
	<td class="textborder" width="20"><bean:message key="app.mandal" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="mandal" styleClass="mycombo" style="width:150px" onchange="javascript:getHabDirData1()" >
			<html:option value="">SELECT...</html:option>
			<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
		</html:select>
	</td>
	<td class="textborder" width="100"><bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="pcode" styleClass="mycombo" style="width:150px"  onchange="javascript:getHabDirData1()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="panchyats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
	</td>
	</tr>
	<tr>
	<td class="textborder" width="80"><bean:message key="app.village" /><font color="#FF6666">*</font></td>
	<td  class="textborder" width="150">
		<html:select property="vcode" styleClass="mycombo" style="width:150px"   onchange="javascript:getHabDirData1()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="villages" name="rwsLocationBean" property="villageCode" labelProperty="villageName" />
		</html:select>
	</td>
	<td class="textborder" nowrap width="100"><bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:snoChanged()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="habs" name="rwsLocationBean" property="habCode" labelProperty="habName" />
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
	<legend>Source Code Details</legend>
	<label>
	<table border=0 width="100%" align="center" cellspacing="8">
	<tr>
	<td class="textborder" >Scheme Code&nbsp;&nbsp;&nbsp;<font color="#FF6666">*</font></td>
	<td class="textborder"> <html:select property="schemeCode" styleClass="mycombo" style="width:50px"  onchange="javascript:snoChanged()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="schemeCodes" name="LabelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	
	<td class="textborder" >Running SNO<font color="#FF6666">*</font></td>
	<td class="textborder"><html:select property="sno" styleClass="mycombo" style="width:50px"  onchange="javascript:snoChanged()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="snos" name="LabelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	<td class="textborder" >Source Code</td>
	<td><html:text property="sourceCode" style="width:180px"  readonly="true"/></td>
	</tr>
	</label>
	</fieldset>
	</td>
	</tr>
	</table>
	<tr><td align="center" colspan=10><input type="button" value="submit" onclick="fnSubmit()"/></td></tr>
	<html:hidden property="assetType" />
</td>
</tr>




</table>
</td>
</tr>
</tbody>
</table>
</html:form>
</body>
<%@ include file="/commons/rws_alert.jsp"%>

<%@ include file="/commons/rws_footer.jsp"%>
