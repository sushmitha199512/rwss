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
	
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=officedetailsup";
	document.forms[0].submit();
	
}
function show()
{
	document.getElementById('search').style.display='block';
	document.getElementById('selecthab').style.display='none';
}
function funcHeadOfficeChanged(){
	
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=headOffice";
	document.forms[0].submit();
	/* document.getElementById("circleOfficeCode").disabled=true;
	document.getElementById("divisionOfficeCode").disabled=true;
	document.getElementById("subDivisionOfficeCode").disabled=true; */
	
}

function opennewWindow()
{
	var zURL = "./switch.do?prefix=/smsmobile&page=/employeeEntry.do&mode=officechnges";
	var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'newWinddow',popFeatures);
	myWin.focus();
}

function getProgrammes2(){
	
	 document.getElementById("circleOfficeCode").disabled=false;
	 /*document.getElementById("divisionOfficeCode").disabled=true;
	document.getElementById("subDivisionOfficeCode").disabled=true; */
	
}
function getProgrammes3(){
	alert("hi3");
	
}
function getProgrammes4(){
	alert("hi4");
	
}
function funccircleOfficeChanged()
{
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=circleOffice1";
	document.forms[0].submit();
	
}
function funcsubDivisionOfficeChanged()
{
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=subDivisionOffice1";
	document.forms[0].submit();
	
}
function funcdivisionOfficeChanged()
{
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=divisionOffice1";
	document.forms[0].submit();
	
}

function funcsubDivisionOfficeChanged1()
{
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=divisionOffice";
	document.forms[0].submit();
	
}
function funcdivisionOfficeChanged1()
{
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=divisionOffice";
	document.forms[0].submit();
	
}


function funcEmployeeIdChanged(){
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=employeeId";
	document.forms[0].submit();
}

</script>
</head>
<body>
<html:form action="employeeEntry.do" method="post">

	<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />
			
			
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
		<legend>Existing Employee Details</legend>
		<label>
		<table  border=0  width="100%">
		
		
			
		
		<tr>
			<td class="textborder">Employee Id
				<span class="mandatory">*</span>
			</td>
			<td>
				
				<html:select property="employeeId" style="width:140px" styleClass="mycombo"   disabled="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="employeeIds" name="labelValueBean" 
								  property="value" labelProperty="labelValue" />
				</html:select>
				
		</td>
		
		
		</tr>
		
		
		
		
			<tr>
			<td class="textborder">Circle
			
		</td>
		
		<td class="textborder">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode" style="width:140px"   onchange="javascript: funccircleOfficeChanged1()"	 styleClass="mycombo" disabled="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			
			
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00" >
				<html:text property="circleOfficeName" styleClass="mytext" style="width:140px"
						    readonly="true" />
				
				<html:hidden property="circleOfficeCode" />
			</logic:notEqual>
		</td>
		</tr>
		<tr>
		<td class="textborder">Division
			
		</td>
		<td>
				
				<html:select property="divisionOfficeCode" style="width:140px"  onchange="funcdivisionOfficeChanged1()"  styleClass="mycombo" disabled="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="divisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		
		<tr>
		<td class="textborder">Sub Division
			
		</td>
		<td>
				
				<html:select property="subDivisionOfficeCode" style="width:140px" styleClass="mycombo"  disabled="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="subDivisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		<tr>
		<td class="textborder">Designation</td>
		<td>
		<html:text property="designation" styleClass="mytext" style="width:140px"
						    disabled="true"/>
						    </td>
		</tr>
		
		<tr>
		<td class="textborder">Office Code</td>
		<td>
		<html:text property="officecode" styleClass="mytext" style="width:140px"
						    disabled="true"/>
						    </td>
		</tr>
		
		
		
		
		<!-- </div> -->
		
		
		
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		
		<tr>
<td>
	
		<fieldset>
		<legend>Change Employee Details</legend>
		<label>
		<table  border=0  width="100%">
		
		<tr>
			<td class="textborder">Circle
			
		</td>
		
		<td class="textborder">
			
				<html:select property="circleOfficeCode1" style="width:140px"   onchange="javascript: funccircleOfficeChanged()"	 styleClass="mycombo" >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="circles1" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			
			
			
		</td>
		</tr>
		
			
			
		<tr>
		<td class="textborder">Division
			
		</td>
		<td>
				
				<html:select property="divisionOfficeCode1" style="width:140px"  onchange="funcdivisionOfficeChanged()"  styleClass="mycombo" >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="divisions1" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		
		<tr>
		<td class="textborder">Sub Division
			
		</td>
		<td>
				
				<html:select property="subDivisionOfficeCode1" style="width:140px" styleClass="mycombo" onchange="funcsubDivisionOfficeChanged()" >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="subDivisions1" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		
		<tr>
			<td class="textborder">Designation
				<span class="mandatory">*</span>
			</td>
			<td>
				
				<html:select property="designations" style="width:140px" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="designations" name="labelValueBean" 
								  property="value" labelProperty="labelValue" />
				</html:select>
				
		</td>
		
		
		</tr>
		
		
		<!-- </div> -->
		
		
		
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
	