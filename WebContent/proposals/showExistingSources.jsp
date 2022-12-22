<%@ include file="/commons/rws_header1.jsp" %>

<script>
function viewSourceDetails(sourceCode)
{
      
      var url = "switch.do?prefix=/masters&page=/Source.do&mode=viewSources&sourceCode="+sourceCode;
       var properties = "width=798,height=422,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	   var newWindow = window.open(url, "", properties);
      
      
 
}


</script>
</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table   cellpadding="0" cellspacing="0">
 
 
<!-- <tr>
<td>
<fieldset>
<legend>Office Details</legend>
<label>
	<table >
	<tbody class="label">
	<tr>
		<td  ><b><bean:message key="app.headoffice" /></b></td>
		<td  >
			<logic:equal name="RWS_USER" property="headOfficeCode" value="0">
				<html:select property="headOfficeCode" onchange="javascript: fnGetOffices(this)"
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="headOffices" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
					<html:text property="headOfficeName"   styleClass="label"
							name="RWS_USER" readonly="true"/>
					<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual>
		</td>
		<td  ><b><bean:message key="app.circle" /></b></td>
		<td  >
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
				<html:text property="circleOfficeName"  styleClass="label"
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
	 
		<td  ><b><bean:message key="app.division" /></b></td>
		<td  >
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
			<html:text property="divisionOfficeName"  styleClass="label"
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		<td ><b><bean:message key="app.subdivision" /></b></td>
		<td  >
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
			<html:text property="subdivisionOfficeName"  styleClass="label"
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
 -->
<logic:present name="existingSources">
 
<tr>

  
<%int sno=1;%>
<table bgcolor="#DEE3E0" border="1" bordercolor="black"   width="400"  cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr  bgcolor="#8A9FCD">
<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
	<th colspan=4 align="left">Sources Located in &nbsp;&nbsp;<bean:write property="subdivisionOfficeName" name="RWS_USER"  /> Sub Divison</td>
</logic:notEqual>
</tr>
<tr bgcolor="#8A9FCD">
    <th><bean:message key="app.sno" /></th>
 	<th><bean:message key="app.habCode" /></th>
	<th><bean:message key="app.habitation" /></th>
	<th><bean:message key="app.source" /></th>
 	 
</tr>
</thead>
 <tbody class="label">
 	 
	<c:forEach items="${sessionScope.existingSources}" var="item"varStatus="status">
	 
	<tr class='<c:out value="row${index%2}"/>'>
	<td width="20"><%=sno++%>
   	<td width="80" ><c:out value="${item.leadHabitation}" />
		</td>
		<td align="center" width="100"><c:out value="${item.habName}" /></td>
		<td align="center" width="85"><a href="#" title="View Source Details" onClick="viewSourceDetails('<c:out value="${item.sourceCode}"/>')"><font color="black"><c:out value="${item.sourceName}" /></font></a></td>
		 
	</tr>
	</c:forEach>
 </tbody>
</table><br>
 
</td>
</tr>
</logic:present>

 </table>

<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>

</body>
</html>
