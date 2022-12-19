<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
%>


<%@ include file="/commons/rws_header2.jsp" %>

<head>
<script language="javascript">
function funcInit()
{
	
	//code to check parent window or child window
	/*
	if(typeof(window.opener)!="undefined") 
	alert("child");
	else
	alert("parent");
	*/
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
		document.forms[0].addNew.disabled="true";
	}

}
function funcChanged()
{
	
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=get";
	document.forms[0].submit();
}


function fnSave()
{
	if(document.forms[0].circleOfficeCode.value=="")
	{
		alert("Please Select Circle");
		return;
	}
	else if(document.forms[0].divisionOfficeCode.value=="")
	{
		alert("Please Select Division");
		return;
	}
	else if(document.forms[0].subDivisionOfficeCode.value=="")
	{
		alert("Please Select Sub Division");
		return;
	}
	else if(document.forms[0].employeeId.value=="")
	{
		alert("Please Select Employee Id");
		return;
	}
	else if(document.forms[0].employeeName.value=="")
	{
		alert("Please Select Employee Name");
		return;
	}
	else if(document.forms[0].employeeMobile.value=="")
	{
		alert("Please Select Employee Mobile");
		return;
	}
	else{
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=ubdateMobile";
	document.forms[0].submit();
	}
}




</script>
</head>
<body>
<html:form action="employeeEntry.do" method="post">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Employee Mobile Entry Form" />
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

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="350" >
<tr>
<td>
	
		<fieldset>
		<legend><bean:message key="legend.rwsOffices"/></legend>
		<label>
		<table  border=0  width="100%">
		
		<tr>
			<td class="textborder">Circle
			<span class="mandatory">*</span>
		</td>
		
		<td class="textborder">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode" style="width:140px"   onchange="javascript: funcChanged()"	 styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			
			
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="mytext" style="width:140px"
						    readonly="true" />
				
				<html:hidden property="circleOfficeCode" />
			</logic:notEqual>
		</td>
		</tr>
		<tr>
		<td class="textborder">Division
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="divisionOfficeCode" style="width:140px"  onchange="funcChanged()"  styleClass="mycombo"  >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="divisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		
		<tr>
		<td class="textborder">Sub Division
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="subDivisionOfficeCode" style="width:140px" styleClass="mycombo" onchange="funcChanged()" >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="subDivisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		<tr>
			<td class="textborder">Employee Id
				<span class="mandatory">*</span>
			</td>
			<td>
				
				<html:select property="employeeId" style="width:140px" styleClass="mycombo"  onchange="funcChanged()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="employeeIds" name="labelValueBean" 
								  property="value" labelProperty="value" />
				</html:select>
		</td>
		
		
		</tr>
		<tr>
			<td class="textborder">Employee Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="employeeName" style="width:140px"  readonly="true"/>
					
			</td>
		
		
		</tr>
		<tr>
			<td class="textborder"> Mobile No
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="employeeMobile" style="width:140px" readonly="false" maxlength="10" onkeypress="return numeralsOnly()" />
					
			</td>
		</tr>
		
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<tr>
	<td>
		<table width="100%">
		<tr>
			<td class="textborder" align=center>
			<input type=button value=Save id="sBtn" onClick="fnSave();" class="btext">
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
		</html:form>
</body>
<%@ include file="/commons/rws_alert.jsp"%>		 
	