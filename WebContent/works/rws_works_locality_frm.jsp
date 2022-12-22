<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<script>
function fnGetdata(val)
{
	document.forms[0].mode1.value=val;  
	document.forms[0].action = "switch.do?prefix=/works&page=/worklocality.do&mode=data";
	document.forms[0].submit();
}

function fnHabs()
{
 
	if(document.forms[0].workId.value!=""){
	document.forms[0].workName.value=document.forms[0].workId.options[document.forms[0].workId.selectedIndex].text;
	}
	 if(document.forms[0].circleOfficeCode.value=="00")
	{
	  alert("Please Select Circle");
	}
	else if(document.forms[0].workCat.value=="")
	{
		alert("Please Selet Work Category");
	}
	else if(document.forms[0].workId.value=="")
	{
		alert("Please Select Work");
	}	  
	else{
		document.forms[0].action = "switch.do?prefix=/works&page=/worklocality.do&mode=getHabs";
		document.forms[0].submit();
	}
}
</script>
 
<html:form action="/worklocality.do?">
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b></b>&nbsp;&nbsp;</caption>
<thead>
<tr>
	<td>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Works Localities" />
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
				<html:select property="headOfficeCode" onchange="javascript: fnGetdata()"
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="headOffices" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
					<html:text property="headOfficeName" styleClass="text-box" 
							name="RWS_USER" readonly="true"/>
					<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual>
		</td>
		<%// System.out.println("code1");%>
		<td class="column3"><bean:message key="app.circle" /><span class="mandatory">*</span></td>
		<td class="column4">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode" onchange="javascript: fnGetdata('divisions')" 
							 styleClass="combo">
					<html:option value="00"><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</logic:equal>
					<%// System.out.println("code2");%>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="thin-text-box" 
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
				<%// System.out.println("code3");%>
	</tr>
	<tr>
		<td class="column1"><bean:message key="app.division" /></td>
		<td class="column2">
		<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:select property="divisionOfficeCode" onchange="javascript: fnGetdata('subdivisions')"
						 styleClass="combo">
			<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
		</logic:equal>
		<%// System.out.println("code4");%>
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
						 onchange="javascript: fnGetdata('asttypes')">
			<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<%// System.out.println("code5");%>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" styleClass="thin-text-box" 
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		<%// System.out.println("code6");%>
	</tr>
	</tbody> 
	</table>
	</label>
	</fieldset>
</td>
</tr>
<td>
	<fieldset><legend>Work Details</legend>
	<label>
	<table>
	<tbody  class="formTBody">
	<tr>
		<td class="column1">Work Category<span class="mandatory">*</span></td>
		<td class="column2">
	
		<html:select property="workCat"
				onchange="javascript: fnGetdata('works')" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<logic:notEmpty name="assetTypes">
				<html:options collection="assetTypes" name="labelValueBean"
					property="value" labelProperty="label" />
					</logic:notEmpty>
					</html:select>
			
		</td>
		<%// System.out.println("code7");%>
		<td class="column3"></td>
		<td class="column4"></td>
	 </tr>
	 <tr>	
		<td class="column1">Work<span class="mandatory">*</span></td>
		<td colspan="3">
		
		<html:select property="workId" style="width:500px"  onchange="javascript: fnGetdata('getMiles')" >
		<html:option value="">SELECT...</html:option>
		<logic:notEmpty name="workIds">
		<html:options collection="workIds" name="labelValueBean"
			property="value" labelProperty="label" />
			</logic:notEmpty>
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
<td align="center" >
<html:button property="mode" styleClass="btext" value="Get Habs"  onclick="fnHabs() " title="Click to Getting Habitations"/>
</tr>
<html:hidden property="mode1"/>
<input type="hidden" name="workName"/>
<%@ include file="/commons/rws_alert.jsp"%> 
</html:form>
 