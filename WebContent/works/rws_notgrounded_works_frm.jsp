<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%

int count = 1;
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();

String md=request.getParameter("mode");
String md1=request.getParameter("mode1");



%>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/ReqFormValidations.js"></script>

<STYLE>

.modeltextbox {
	width: 130px;
	background: transparent url('images/bgtext.jpg') no-repeat;
	color : green;
	height:20px;
	border:0;
	padding-top:3px;
	padding-bottom:3px;	
	margin-bottom:0px;
}
fieldset { border:1px solid green }
legend {
  padding: 0.2em 0.5em;
  border:1px solid green;
  color:green;
  font-size:90%;
  text-align:right;
  }
.tstyle {
width: 221px;
	background: transparent url('images/bg.jpg') no-repeat;
	color : #747862;
	height:20px;
	border:0;
	padding:4px 8px;
	margin-bottom:0px;
}
</STYLE>

<script  language="javascript" >
function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;

         return true;
      }
function date_time(id)
{
        date = new Date;
        year = date.getFullYear();
        month = date.getMonth();
        months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'Jully', 'August', 'September', 'October', 'November', 'December');
        d = date.getDate();
        day = date.getDay();
        days = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
        h = date.getHours();
        if(h<10)
        {
                h = "0"+h;
        }
        m = date.getMinutes();
        if(m<10)
        {
                m = "0"+m;
        }
        s = date.getSeconds();
        if(s<10)
        {
                s = "0"+s;
        }
        result = ''+days[day]+' '+months[month]+' '+d+' '+year+' '+h+':'+m+':'+s;

        document.forms[0].elements["id"].innerHTML=result;
       // document.getElementById(id).innerHTML = result;
        setTimeout('date_time("'+id+'");','1000');
        return true;
}
function partClearance(){
	 var value=document.forms[0].elements["partAClearnce"].checked;
		if(value){
			document.getElementById('partA').style.display='block';
		 	document.getElementById('partA1').style.display='block';
		}else{
			document.getElementById('partA').style.display='none';
			document.getElementById('partA1').style.display='none';
		}
	}

	function checkAmount(){

	var samount=parseFloat(document.forms[0].elements["sanctionedAmount"].value);
	var pamount=parseFloat(document.forms[0].elements["partAAmount"].value);
	var mileStoneAmount=parseFloat(document.forms[0].elements["mileStoneAmount"].value);
	
	if(!isNaN(mileStoneAmount)){
	pamount=pamount+mileStoneAmount;
	}
	//alert(totPart);
	if(pamount>samount){
	document.forms[0].elements["partAAmount"].value="";
	 alert("(Part A Amount+MileStone Amount) Should Not Be More Than Sanction Amount");
	return;
	}

	}

	function getDivisions()
		{

		 document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=Divisions";
			document.forms[0].submit();
		
		}
	function getWorkcategory()
		{
		  document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=workcategory";
		  monitoringForm.submit();
		}
	function getSubDivisions()
		{
		
			document.forms[0].action="switch.do?prefix=/works&page=/WorkReleases.do&mode=data";
			monitoringForm.submit();
		}
	function getProgramme()
	{

		//document.forms[0].action="switch.do?prefix=/works&page=/WorkReleases.do&mode=data&mode1=programmes";
		//monitoringForm.submit();
		
	}

	function getWorks()
	{
		
		document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=getworks";
		document.forms[0].submit();
		
	}
	function getYears()
	{
		
		document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=getYears";
		document.forms[0].submit();
		
	}
	function getPrograms()
	{
		
		document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=getPrograms";
		document.forms[0].submit();
		
	}

	function getWorkDetails()
	{
		document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=getworkDetails";
		document.forms[0].submit();
	}

	function show1(){
	 var value=document.forms[0].elements["dprPrepartion"].value;
	 if(value=="Agency"){
	//document.getElementById('dateComp2').style.display='block';
	document.forms[0].elements["agencyName"].value="";
	}else{
	document.forms[0].elements["agencyName"].value="RWSS";
	document.getElementById('dateComp2').style.display='none';
	}
	}

	function getDate(){

	  var value=document.forms[0].elements["dprStatus"].value;
	 if(value=="Completed/Approved"){
	  document.getElementById('dateComp').style.display='block';
	  
	}else{
	 document.getElementById('dateComp').style.display='none';
	}

	}

	function viewText(){

	var value=document.forms[0].elements["others"].value;
	 if(value=="on"){
	 document.getElementById('otherR').style.display='block';
	}else{
	document.getElementById('otherR').style.display='none';
	}

	}

	function validateSource(){
	var value=document.forms[0].elements["sourceCreated"].value;
		if(value=="Yes"){
		 	document.getElementById('source').style.display='block';
		}else{
			document.getElementById('source').style.display='none';
		}
	}


function fnSave(count)
{
 
var value1=document.forms[0].elements["landAquisition"].checked;
var value2=document.forms[0].elements["waterDrawlPermission"].checked;
var value3=document.forms[0].elements["railwayCrossingPermission"].checked;
var value4=document.forms[0].elements["roadCrossingPermission"].checked;
var value8=document.forms[0].elements["roadCrossingPermissionNHAI"].checked;
var value5=document.forms[0].elements["forestClearance"].checked;
var value6=document.forms[0].elements["others"].checked;
var value21=document.forms[0].elements["powerAPTranscoReq"].checked;
var value22=document.forms[0].elements["hmwsReq"].checked;
var value7=document.forms[0].elements["othersReason"].value;

var partAValue=document.forms[0].elements["partAAmount"].value;
if(partAValue==null || partAValue==""){
	alert("Please enter Part-A Sanction Amount (Rs InLakhs)");
	return;
}

if(document.forms[0].elements["workid"].value!=" "){

       if(value1 && document.forms[0].elements["landAquisitionReqNumber"].value=="" && document.forms[0].elements["landAquisitionReqDate"].value==""){
                alert("Please Enter LandAquistion Request Details");
					return;
					} else
 if(value2 && document.forms[0].elements["waterDrawlPermissionReqNumber"].value=="" && document.forms[0].elements["waterDrawlPermissionReqDate"].value==""){
                alert("Please Enter Water Drawl Permmision Request Details");
					return;
					} else if(value3 && document.forms[0].elements["railwayCrossingPermissionReqNumber"].value=="" && document.forms[0].elements["railwayCrossingPermissionReqDate"].value==""){
                alert("Please Enter Railway Crossing Permmision Request Details");
					return;
					} else if(value4 && document.forms[0].elements["roadCrossingPermissionReqNumber"].value=="" && document.forms[0].elements["roadCrossingPermissionReqDate"].value==""){
                alert("Please Enter Road Crossing State Permmision Request Details");
					return;
					} else if(value8 && document.forms[0].elements["roadCrossingPermissionReqNumberNHAI"].value=="" && document.forms[0].elements["roadCrossingPermissionReqDateNHAI"].value==""){
                alert("Please Enter Road Crossing NHAI Permmision Request Details");
					return;
					} else if(value5 && document.forms[0].elements["forestClearanceReqNumber"].value=="" && document.forms[0].elements["forestClearanceReqDate"].value==""){
                alert("Please Enter Forest Clearance Permmision Request Details");
					return;
					} else if(value6 && document.forms[0].elements["othersReqNumber"].value=="" && document.forms[0].elements["othersReqDate"].value==""){
                alert("Please Enter Others Permmision Request Details");
					return;
					} 
 else if(value21 && document.forms[0].elements["powerAPTranscoReqNumber"].value=="" && document.forms[0].elements["powerAPTranscoReqDate"].value==""){
                alert("Please Enter Power (AP Transco) Request Details");
					return;
					} 
 else if(value22 && document.forms[0].elements["hmwsReqNum"].value=="" && document.forms[0].elements["hmwsReqDate"].value==""){
                alert("Please Enter HMWSSB Request Details");
					return;
					} 

    if(value6){
    if(value7==""){
     alert("Please Select Others Reason Befor You Save.");
		
	}else{
  if(validateForm()){
document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=save";
         document.forms[0].submit();
}
}
}else{
if(validateForm()){
 document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=save";
        document.forms[0].submit();
}

}
		
}else{
  alert("Please Select Any Work");

}
}

function validateForm(){
var landNumber=document.forms[0].elements["landAquisitionNumber"].value;
var landDate=document.forms[0].elements["landAquisitionObtainDate"].value;
var waterNumber=document.forms[0].elements["waterDrawlPermissionNumber"].value;
var waterDate=document.forms[0].elements["waterDrawlPermissionObtainDate"].value;
var railNumber=document.forms[0].elements["railwayCrossingPermissionNumber"].value;
var railDate=document.forms[0].elements["railwayCrossingPermissionObtainDate"].value;

var roadNumber=document.forms[0].elements["roadCrossingPermissionNumber"].value;
var roadDate=document.forms[0].elements["roadCrossingPermissionObtainDate"].value;

var forestNumber=document.forms[0].elements["forestClearanceNumber"].value;
var forestDate=document.forms[0].elements["forestClearanceObtainDate"].value;

var othersNumber=document.forms[0].elements["othersNumber"].value;
var othersDate=document.forms[0].elements["othersObtainDate"].value;

var partAClearnceDate=document.forms[0].elements["partAClearnceDate"].value;

if(document.forms[0].elements["sourceCreated"].value =="Yes" && document.forms[0].elements["sourceCreatedDate"].value=="")
{
 alert("Please Select Source Created Date");
	return false;
}



 if((landNumber!="" || landDate!="") && !document.forms[0].elements["landAquisition"].checked){
           alert("Please Select LandAquisition Permission");
   return false;
} else if((waterNumber!="" || waterDate!="") && !document.forms[0].elements["waterDrawlPermission"].checked ){
	 alert("Please Select Water Drawl Permission");
return false;
}else if((railNumber!="" || railDate!="") && !document.forms[0].elements["railwayCrossingPermission"].checked ){
	 alert("Please Select Railway Crossing Permission");
return false;
}else if((roadNumber!="" || roadDate!="")&& !document.forms[0].elements["roadCrossingPermission"].checked ){
	 alert("Please Select Rroad Crossing Permission");
return false;
}else if((forestNumber!="" || forestDate!="") && !document.forms[0].elements["forestClearance"].checked ){
	 alert("Please Select Forest Clearance");
return false;
}
else if((othersNumber!="" || othersDate!="") && !document.forms[0].elements["others"].checked ){
	 alert("Please Select Others Permission");
return false;
}
else if(partAClearnceDate=="" && document.forms[0].elements["partAClearnce"].checked ){
	 alert("Please Give PartA Clearance Date");
return false;
}
else{
return true;
}

}
function fnUpdate(){
		document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=update";
         document.forms[0].submit();

}
function fnView(){

  if(document.forms[0].elements["circleCode"].value!=" "){
		document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=view";
         document.forms[0].submit();
}else{
 alert("Please Select Circle");
}

}


function search(){
var work_id=document.forms[0].elements["workidS"].value;
if(work_id==""){
alert("Please Enter WorkId");
return;
} else if(work_id.length<14){
alert("WorkId Should  Be in 14 Didgit.");
return;

}


	document.forms[0].action="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=search";
	document.forms[0].submit();
	
}


</script>

</head>



<html:form action="NotGrounded.do">


<body>
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<table>
<tr><td align="left">
<font color="red"><b>Note:</b></font>1.All Request/Obtain Numbers Size Should be less than or equal 50.<br> 
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.All Amounts Should Be In Rupees Only Except Part A Amount.
</td></tr>

<tr><td align="right">
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>


</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="DPR/Permissions Status" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>


<font color="green">
<span id="date_time" bgcolor="#DEE3E0"></span>
            <script type="text/javascript">window.onload = date_time('date_time');</script></b></font>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=0 style="border-collapse:collapse;" >
<tr><td align="center" class="btext">Enter WorkID:<html:text property="workidS" maxlength="14"  styleClass="modeltextbox" onkeypress="return isNumberKey(event)"  ></html:text>&nbsp;<input type="button" value="Get&nbsp;Details" onclick="search()"></td></tr>
	<tr>
		<td class="bwborder" >


		<fieldset>
		<legend><b>Office Details</b></legend>
		
			<table  width="90%" border=0 style="border-collapse:collapse;" >
	
		

				<%
String cirfi=(String)session.getAttribute("fixcircle");
	  String usercode=RWS_USER.getCircleOfficeCode();
      String username=RWS_USER.getCircleOfficeName();
      String divusercode=RWS_USER.getDivisionOfficeCode();
      String divusername=RWS_USER.getDivisionOfficeName();
      String subusercode=RWS_USER.getSubdivisionOfficeCode();
      java.util.Date systemdate= new java.util.Date(System.currentTimeMillis());
	
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
	    String transdate=null;
	  transdate=dateFormat.format(systemdate);

 				%>


<logic:present name="circles">
					<logic:notPresent name="fixcircle">
						<td class="textborder">Circle<span class="mandatory">*</span></td>
						<td class="textborder"><html:select  property="circleCode" 
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getDivisions();">
							<html:option value=" ">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="circles" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:notPresent>
					<logic:present name="fixcircle">

						<td class="textborder">Circle<span class="mandatory">*</span></td>
						<logic:present name="RWS_USER" property="circleOfficeName">
							<html:hidden property="circleCode" />
							<td class="textborder"><html:text property="circleOfficeName"
								name="RWS_USER" readonly="true" styleClass="mytext"
								style="width:100px" /> <html:hidden property="circleCode"
								 /></td>
						</logic:present>
					</logic:present>
				</logic:present>


				<%if(divusercode.equals("0")){%>
				<td class="textborder"><bean:message key="app.division" /><span class="mandatory">*</span></td>
				<td class="textborder"><html:select property="cmbDivision" style="width:183px"
					styleClass="mycombo" onchange="Javascript:getWorkcategory();">
					<html:option value="">Select...</html:option>
					<logic:present name="divisions">
						<html:options collection="divisions" name="division"
							property="value" labelProperty="label" />
					</logic:present>

				</html:select></td>
				<%} else{%>
				<td class="textborder"><bean:message key="app.division" /><span class="mandatory">*</span></td>
				<td class="textborder"><html:select property="cmbDivision" style="width:183px"
					styleClass="mycombo" onchange="Javascript:getWorkcategory();">
					<html:option value='<%=divusercode%>'>
						<%=divusername%>
					</html:option>
				</html:select> <%} %>







<td class="textborder">Category:



<html:select property="category"
							style="width:135px" styleClass="mycombo"
							onchange="javascript:getPrograms();">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
<html:option value="1">
								<font class="myfontclr1">Projects
							</html:option>
<html:option value="2">
								<font class="myfontclr1">Normal
							</html:option>
<html:option value="3">
								<font class="myfontclr1">District Level
							</html:option>
</html:select>
</td>


<logic:present name="programs">
						<td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Programs</td>
						<td class="textborder"><html:select property="programCode"
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getYears();">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="programs" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present>
</tr>
<tr>
<logic:present name="sanYears">
						<td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sanction Year</td>
						<td class="textborder" ><html:select property="sanctionYear"
							style="width:83px" styleClass="mycombo"
							onchange="javascript:getWorks();">
							<html:option value=" ">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="sanYears" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present></td></td>

<logic:present name="works">
						<td class="textborder" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Works</td>
						<td class="textborder" colspan=5><html:select property="workIdList"
							style="width:560px" styleClass="mycombo"
							onchange="javascript:getWorkDetails();">
							<html:option value=" ">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="works" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present></td>



</tr>
</table>
	</fieldset>
<fieldset>
   	<legend  ><B>Work Details</B></legend>
	<table width="100%" border=0 style="border-collapse:collapse;"><tr>
			<tr>
			
			<td class="textborder" align="center">Work ID</td><td><html:text property="workid" size="20" maxlength="20"  disabled="true" /></td>

			<td class="textborder" align="center">Work Name</td><td colspan=6><html:text property="workName" size="150"  disabled="true" /></td>
</tr>
<tr>
			<td class="textborder" align="center">Program</td><td><html:text property="program" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">SubProgram</td><td><html:text property="subProgName" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">Sanction Date</td><td><html:text property="sanctionedDate" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">Sanction&nbsp;Amount<td><html:text property="sanctionedAmount" size="20"  disabled="true" /></td>
<td class="textborder" align="center">MileStone&nbsp;Amount<html:text property="mileStoneAmount"  size="20"  disabled="true" /></td>
</tr>
<tr>
<td class="textborder" align="left" >Part-A&nbsp;Sanction Amount &nbsp;(Rs InLakhs)<span class="mandatory">*</span><td><html:text  property="partAAmount" size="10"  onblur="checkAmount()" onkeypress="return decimalsOnly(event)" /></td>
			
		</tr>


</table>
	</fieldset>

<fieldset>
   	<legend  ><b>Required Permissions</b><span class="mandatory">*</span></legend>
	<table  width="100%" border=0 style="border-collapse:collapse;">
<tr><td ></td><td class="textborder" align="left">Request Number<span class="mandatory">*</span></td><td class="textborder" align="left">Request Date<span class="mandatory">*</span></td><td class="textborder" align="left">Obtain Number</td><td class="textborder" align="left">Obtain Date</td><td class="textborder" align="left">Charges(In Rupees)</td></tr>
<tr>

<td class="textborder"><html:checkbox property="landAquisition" />Land Aquisition</td>

<td class="textborder"><html:text property="landAquisitionReqNumber" maxlength="50" /></td>

<td><html:text property="landAquisitionReqDate"   style="width: 100px"    onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].landAquisitionReqDate);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td>

<td><html:text property="landAquisitionNumber" maxlength="50"  /></td><td><html:text property="landAquisitionObtainDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].landAquisitionObtainDate);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td><td><html:text property="landAquisitionChrg"  onkeypress="return decimalsOnly(event)" onblur="return totCheck()"/></td>
</tr>
<tr>


<td class="textborder"><html:checkbox property="waterDrawlPermission" />Water Drawl Permission</td>

<td class="textborder"><html:text property="waterDrawlPermissionReqNumber" maxlength="50" /></td>

<td><html:text property="waterDrawlPermissionReqDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].waterDrawlPermissionReqDate);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td>

<td><html:text property="waterDrawlPermissionNumber"  maxlength="50" /></td><td><html:text property="waterDrawlPermissionObtainDate"    style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].waterDrawlPermissionObtainDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td>
<td><html:text property="waterDrawlPermissionChrg" onkeypress="return decimalsOnly(event)" onblur="return totCheck1()"/></td>
</tr>
</tr>

<tr>

<td class="textborder"><html:checkbox property="railwayCrossingPermission" />Railway Crossing Permission </td>

<td class="textborder"><html:text property="railwayCrossingPermissionReqNumber"  maxlength="50" /></td>

<td><html:text property="railwayCrossingPermissionReqDate"    style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].railwayCrossingPermissionReqDate);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td>

<td><html:text property="railwayCrossingPermissionNumber" maxlength="50" /></td><td><html:text property="railwayCrossingPermissionObtainDate"    style="width: 100px"   onkeypress="return decimalsOnly(event)"/>

<a href="javascript: showCalendarFuture(document.forms[0].railwayCrossingPermissionObtainDate);">

       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td><td><html:text property="railwayCrossingPermissionChrg" onkeypress="return decimalsOnly(event)" onblur="return totCheck2()" /></td>


</tr>

</tr>


<tr>

<td class="textborder"> <html:checkbox property="roadCrossingPermission" />Road crossing Permission State</td>

<td class="textborder"><html:text property="roadCrossingPermissionReqNumber"  maxlength="50" /></td>

<td><html:text property="roadCrossingPermissionReqDate"   style="width: 100px"    onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].roadCrossingPermissionReqDate);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td>
<td><html:text property="roadCrossingPermissionNumber" maxlength="50"  /></td><td><html:text property="roadCrossingPermissionObtainDate"    style="width: 100px"   onkeypress="return decimalsOnly(event)"/>

<a href="javascript: showCalendarFuture(document.forms[0].roadCrossingPermissionObtainDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td><td><html:text property="roadCrossingPermissionChrg"  onkeypress="return decimalsOnly(event)" onblur="return totCheck3()"/></td>
</tr>

<tr>

<td class="textborder"><html:checkbox property="roadCrossingPermissionNHAI" />Road crossing Permission  NHAI</td>

<td class="textborder"><html:text property="roadCrossingPermissionReqNumberNHAI" maxlength="50" /></td>

<td><html:text property="roadCrossingPermissionReqDateNHAI"    style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].roadCrossingPermissionReqDateNHAI);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td>
<td><html:text property="roadCrossingObtainNHAINumber" maxlength="50" /></td><td><html:text property="roadCrossingNHAIObtainDate"    style="width: 100px"   onkeypress="return decimalsOnly(event)"/>

<a href="javascript: showCalendarFuture(document.forms[0].roadCrossingNHAIObtainDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td><td><html:text property="roadCrossingPermissionNHAIChrg"  onkeypress="return decimalsOnly(event)" onblur="return totCheck4()" /></td>
</tr>

<tr>

<td class="textborder"><html:checkbox property="forestClearance" />Forest Clearance</td>

<td class="textborder"><html:text property="forestClearanceReqNumber" maxlength="50"/></td>

<td><html:text property="forestClearanceReqDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].forestClearanceReqDate);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td>

<td><html:text property="forestClearanceNumber" maxlength="50" /></td><td><html:text property="forestClearanceObtainDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>

<a href="javascript: showCalendarFuture(document.forms[0].forestClearanceObtainDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td><td><html:text property="forestClearanceChrg" onkeypress="return decimalsOnly(event)" onblur="return totCheck5()" /></td>

</tr>



<tr>


<td class="textborder"><html:checkbox property="powerAPTranscoReq" />Power (AP Transco)</td>

<td class="textborder"><html:text property="powerAPTranscoReqNumber" maxlength="50" /></td>

<td><html:text property="powerAPTranscoReqDate"   style="width: 100px"    onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].powerAPTranscoReqDate);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td>
<td><html:text property="powerAPTranscoObtainNumber" maxlength="50" /></td><td><html:text property="powerAPTranscoObtainDate"    style="width: 100px"   onkeypress="return decimalsOnly(event)"/>

<a href="javascript: showCalendarFuture(document.forms[0].powerAPTranscoObtainDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td><td><html:text property="powerAPTranscoChrgs"  onkeypress="return decimalsOnly(event)" onblur="return totCheck6()" /></td>

</tr>
<tr>
<td class="textborder"><html:checkbox property="hmwsReq" />HMWSSB</td>

<td class="textborder"><html:text property="hmwsReqNum" maxlength="50" /></td>

<td><html:text property="hmwsReqDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].hmwsReqDate);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td>

<td><html:text property="hmwsReqobtainNum"  maxlength="50" /></td><td><html:text property="hmwsReqobtainDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>

<a href="javascript: showCalendarFuture(document.forms[0].hmwsReqobtainDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td><td><html:text property="hmwsChrgs"  onkeypress="return decimalsOnly(event)" onblur="return totCheck7()"/></td>

</tr>





<tr>


<td class="textborder"><html:checkbox property="others" onclick="javascript:viewText();"/>If Any Other<html:text property="othersReason" size="50"  />

<td class="textborder"><html:text property="othersReqNumber" maxlength="50" /></td>

<td><html:text property="othersReqDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].othersReqDate);"><img src="./images/cal.gif" border="0" align="absmiddle"></a>

</td>
<td><html:text property="othersNumber"  maxlength="50" /></td><td><html:text property="othersObtainDate"    style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].othersObtainDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td><td><html:text property="othersChrg" onkeypress="return decimalsOnly(event)" onblur="return totCheck8()" /></td>

</tr>
</table>
</fieldset>
<fieldset>
   	<legend  ><B>Source Details</B></legend>
	<table width="100%" border=0 style="border-collapse:collapse;">
<tr><td class="textborder">Source Created&nbsp;&nbsp;


<html:select property="sourceCreated"
							style="width:90px" styleClass="mycombo"
							onchange="javascript:validateSource();">
							<html:option value="No">
								<font class="myfontclr1">No
							</html:option>
<html:option value="Yes">
								<font class="myfontclr1">Yes
							</html:option>
<html:option value="Not Required">
								<font class="myfontclr1">Not Required
							</html:option>

</html:select>





</td>
<td class="textborder">
<logic:equal  name="NotGrounded" property="sourceCreated" value="Yes">
<div id="source" style="display:block">
</logic:equal>
<logic:notEqual  name="NotGrounded" property="sourceCreated" value="Yes">
<div id="source" style="display:none">
</logic:notEqual>
<table><tr><td class="textborder">
Source Created Date:<span class="mandatory">*</span><html:text property="sourceCreatedDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].sourceCreatedDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</div></td>


<td class="textborder">
<fieldset>
   	<legend  ><B>Charges(In Rupees)</B></legend>
	<table width="100%" border=0 style="border-collapse:collapse;">
<tr><td class="textborder">
Ground Water Investigation</td>&nbsp;<td><html:text property="groundWaterInvestigationChg" onkeypress="return decimalsOnly(event)" onblur="totCheck9()" /></td>

<td class="textborder">Yield Testing </td><td><html:text property="yieldTestingChg" onkeypress="return decimalsOnly(event)" onblur="totCheck10()"/></td>
</tr>
<tr>
<td class="textborder">Source Creation</td><td><html:text property="sourceCreationChg" onkeypress="return decimalsOnly(event)" onblur="totCheck11()" /></td>
<td></td>
</tr>
</table>
</fieldset>
</td>
</tr>

</table>
</td>
</tr>
</table>



</fieldset>
	
<fieldset>
   	<legend  ><B>DPR Status</B></legend>
	<table  width="100%" border=0 style="border-collapse:collapse;">

<tr><td><html:select property="dprStatus"
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getDate();">
							<html:option value="">
								<font class="myfontclr1">Select...
							</html:option>
<html:option value="Survey Stage">
								<font class="myfontclr1">Survey Stage
							</html:option>
<html:option value="Estimate Stage">
								<font class="myfontclr1">Estimate Stage
							</html:option>
<html:option value="Completed/Approved">
								<font class="myfontclr1">Completed/Approved
							</html:option>
							
						</html:select>
</td>
<td class="textborder">
      

<logic:equal  name="NotGrounded" property="dprStatus" value="Completed/Approved">
<div id="dateComp" >
</logic:equal>

<logic:notEqual  name="NotGrounded" property="dprStatus" value="Completed/Approved">
<div id="dateComp" style="display:none">
</logic:notEqual>
<table><tr><td class="textborder">
Completed Date<span class="mandatory">*</span><html:text property="dprCompDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].dprCompDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>

       </td>

<td class="textborder">DPR Preparation&nbsp;<html:select property="dprPrepartion" style="width: 150px" onchange="show1()">
<html:option value="">Select</html:option>
<html:option value="Through Department">Through Department</html:option>
<html:option value="Agency">Agency</html:option>
</html:select>
</div>
</td>

<td class="textborder" >Agency Name&nbsp;<html:text property="agencyName"   style="width: 110px" /></td>
<td class="textborder" >DPR Charges&nbsp;<html:text property="dprCharges"   style="width: 100px"  onblur="totCheck12()" onkeypress="return decimalsOnly(event)"/></div></td>
</tr>
</table>
</td>
</tr>
</table>
	</fieldset>
<fieldset>
   	<legend  ><B>Part A</B></legend>


<logic:equal  name="NotGrounded" property="partAClearnceDate" value="">

	<table>
<tr><td  class="textborder">Part A Clearance<html:checkbox property="partAClearnce" onclick="partClearance();"/></td>

<td  class="textborder"><div id="partA1" style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;Clearance Date<span class="mandatory">*</span></div></td><td  class="textborder">
<div id="partA" style="display:none">
<html:text property="partAClearnceDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].partAClearnceDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</div>
</td>

</tr>


</table>

</logic:equal>
<logic:notEqual  name="NotGrounded" property="partAClearnceDate" value="">

	<table>
<tr><td  class="textborder">Part A Clearance<html:checkbox property="partAClearnce" onclick="partClearance();"/></td>

<td  class="textborder"><div id="partA1" style="display:block">&nbsp;&nbsp;&nbsp;&nbsp;Clearance Date<span class="mandatory">*</span></div></td><td  class="textborder">
<div id="partA" style="display:block">
<html:text property="partAClearnceDate"   style="width: 100px"   onkeypress="return decimalsOnly(event)"/>
<a href="javascript: showCalendarFuture(document.forms[0].partAClearnceDate);">
       <img src="./images/cal.gifgif" width="16" height="16" border="0" alt="Pick a date"></a>
</div>
</td>

</tr>


</table>

</logic:notEqual>


	</fieldset>

<table >
<tr>
<td class="textborder">Remarks:
<html:textarea property="remarks" rows="3"  cols="20" /></td>
<td></td>		


<td  align="center" >
<%
 if(session.getAttribute("isUpdate")!=null && !((String)session.getAttribute("isUpdate")).equals("true"))
 {	
%>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Save"
				onClick="fnSave();">&nbsp;&nbsp;&nbsp;
<%}  else {%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
<input type="button" value="Update"
				onClick="fnSave();">&nbsp;&nbsp;&nbsp;
<%} %>


 
<input type="button" value="View"
				onClick="fnView();">&nbsp;&nbsp;&nbsp; 


		</tr>
</table>

</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
<br>
<br>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%
 if(session.getAttribute("message")!=null)
 {	
	 String message=(String)session.getAttribute("message");
session.removeAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess)
	</script>
<%
 } %>