<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<%
	 nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
%>


<%@ include file="/commons/rws_header2.jsp" %>

<head>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="javascript">

function autocompletion()
{
      // alert("auto comp");
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}

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
	if(document.forms[0].headOfficeCode.value=="")
	{
		alert("Please Select Head Office");
		return;
	}
	if(document.forms[0].employeeId.value=="")
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
	else if(document.forms[0].employeeMobile.value.length!=10)
	{
		alert("Please Enter 10 Digits Mobile Number");
		return;
	}
	else{
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=ubdateMobile";
	document.forms[0].submit();
	}
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
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=circleOffice";
	document.forms[0].submit();
	
}
function funcsubDivisionOfficeChanged()
{
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=divisionOffice";
	document.forms[0].submit();
	
}
function funcdivisionOfficeChanged()
{
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=divisionOffice";
	document.forms[0].submit();
	
}
function funcEmployeeIdChanged(){
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=employeeId";
	document.forms[0].submit();
}
function fnView() {
	var headOfficeCode=document.forms[0].headOfficeCode.value;
	var circleOfficeCode=document.forms[0].circleOfficeCode.value;
	var divisionOfficeCode=document.forms[0].divisionOfficeCode.value;
	var subDivisionOfficeCode=document.forms[0].subDivisionOfficeCode.value;
	
	var employeeId=document.forms[0].employeeId.value;
	
	if(document.forms[0].headOfficeCode.value=="")
	{
		alert("Please Select Head Office");
		return;
	}
	else
		{
	
	document.forms[0].action="/pred/smsmobile/employeeEntry.do?mode=viewMobile&headOfficeCode="+headOfficeCode+"&circleOfficeCode="+circleOfficeCode+"&divisionOfficeCode="+divisionOfficeCode+"&subDivisionOfficeCode="+subDivisionOfficeCode+"&employeeId="+employeeId+"";
	document.forms[0].submit();
		}
	
}

</script>
</head>
<body  onload="autocompletion()">
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
			<td class="textborder">Head Office
			
		</td>
			<td>
				
				<html:select property="headOfficeCode" style="width:140px" styleClass="mycombo" onchange="funcHeadOfficeChanged()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:option value="1">Head Office</html:option>
				</html:select>
		</td>
		</tr>
			<tr>
			<td class="textborder">Circle
			
		</td>
		
		<td class="textborder">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode" style="width:140px"   onchange="javascript: funccircleOfficeChanged()"	 styleClass="mycombo">
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
				
				<html:select property="divisionOfficeCode" style="width:140px"  onchange="funcdivisionOfficeChanged()"  styleClass="mycombo">
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
				
				<html:select property="subDivisionOfficeCode" style="width:140px" styleClass="mycombo" onchange="funcsubDivisionOfficeChanged()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="subDivisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		<!-- </div> -->
		<tr>
			<td class="textborder">Employee Id
				<span class="mandatory">*</span>
			</td>
			<td>
				
				<html:select property="employeeId" style="width:140px" styleClass="mycombo"  onchange="funcEmployeeIdChanged()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="employeeIds" name="labelValueBean" 
								  property="value" labelProperty="labelValue" />
				</html:select>
				<input type=button name="button1"   Class="btext" value="&nbsp;&nbsp;...&nbsp;&nbsp;" onmouseover="Tip(this.value,TITLE,'Change Place of posting or Designation')"  onmouseout="UnTip()" onclick="opennewWindow('')"/>
		</td>
		
		
		</tr>
		<tr>
			<td class="textborder">Employee Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="employeeName" style="width:200px"  readonly="true"/>
					
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
		<html:hidden property="designation" />
		<html:hidden property="designation" />
		<html:hidden property="officecode"/>
		
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
			<input type=button value=View id="sBtn" style="display: none;" onclick="fnView();"  class="btext">
			
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
	