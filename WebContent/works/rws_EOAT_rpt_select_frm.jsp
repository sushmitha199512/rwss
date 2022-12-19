<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function fnSubmit(mode)
{
	var validateSuccess=true;
	if(mode=='eoatRptview')
	{
		if(document.forms[0].circleOfficeCode.value=="")
		{
			validateSuccess=false;
			alert("Please Select Circle");
		}
		else if(document.forms[0].divisionOfficeCode.value=="")
		{
			validateSuccess=false;
			alert("Please Select Division");
		}
		
	
	}
	
	if(validateSuccess)
	{
		document.forms[0].action="/pred/works/eoatFrm.do?mode="+mode;
		document.forms[0].submit();
	}
}
</script>
<body onload="">
<html:form action="eoatFrm.do">

<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead>
<tr><td align="right"><b><small>Amount In Rs Lakhs</small></b></td></tr>
<tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="EOAT Form" />
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td></tr></thead>

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

<!--  form fields starts from here -->
<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"  style="border-collapse:collapse;" width="100%" >	
	<tr>
		<td class="mycborder" colspan="2">
			<fieldset>
				<legend align="left"></legend>
				<label>
					<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"   width="100%" >	
  						<tr class="textborder">
					   		<td class="textborder">
			<bean:message key="app.circle" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode"   style="width:250px" onchange="javascript: fnSubmit('eoatRptSelectFrm')" 
							 styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="mytext" style="width:250px"
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
	</tr>
	<tr>
		<td class="textborder"><bean:message key="app.division" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder">
		<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0" >
			<html:select property="divisionOfficeCode"  style="width:250px" onchange="javascript: fnSubmit('eoatRptSelectFrm')"
						 styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0" >
			<html:text property="divisionOfficeName" styleClass="mytext" style="width:250px"
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
	</tr>
	<tr class="textborder">
	<td class="textborder">
		<bean:message key="app.subdivision" />
		<span class="mandatory">*</span>
		</td>
	<td class="textborder">
		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subDivisionOfficeCode" styleClass="combo"  onchange="javascript: fnSubmit('eoatRptSelectFrm')"
			style="width:250px">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" styleClass="mytext" style="width:250px"
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
	</tr>
	<tr class="textborder">
					   	<td >Work Name</td>
					   	<td colspan="3">
					   			<html:hidden property="sno"/>
					   			<html:select  style="width:370" property="workId" styleClass="mycombo" >
									<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
										<logic:notEmpty name="workIdList">
										<html:options collection="workIdList" name="labelValueBean" property="value" labelProperty="label" />
										</logic:notEmpty>
								</html:select>
				    	</td>
	</tr>
</table>
</label>
</fieldset>
</td>
</tr>
<tr class="textborder">
	<td colspan="15" align="center">
		<input type="button" class="btext" value="View" onclick="fnSubmit('eoatRptview')">
	</td>
</tr>
</table>


<!--  end of form fields -->
</td>
</tr>
</tbody>
</table>
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
	