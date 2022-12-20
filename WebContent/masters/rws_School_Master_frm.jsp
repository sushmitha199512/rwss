<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<script language="JavaScript">



function init()
{
	
	for (i = 0; i < document.forms.length; i++) {
		document.forms[i].setAttribute("AutoComplete", "off");
	}
	
var hab=document.getElementById('habitation').value;
var cat=document.getElementById('category').value;
var fac=document.getElementById('facilities').value;
var schname=document.getElementById('schoolName').value;

var toi=document.getElementById('toilets').value;
//alert("this is toilet"+toi);
var runwater=document.getElementById('runningwater').value;

if(schname=='')
{
document.forms[0].schoolName.focus();
}

if(document.getElementById('district').value=="-1")
{
	document.getElementById('schoolName').value="";
	document.getElementById('nostudents').value="";
	document.getElementById('noBoys').value="";
	document.getElementById('noGirls').value="";
	document.getElementById('facilities').value="00";
	//document.getElementById('toilets').value="00";
	}


if(hab=="-1")
{
	disable('category');
	disable('classify');
	disable('facilities');
	disable('toilets');
	disable('runningwater');
	disable('urinals');
	disable('nonDrink');
	disable('nonSani');
	disable('drkMonth');
	disable('drkYear');
	disable('saniMonth');
	disable('saniYear');
	disable('sourceDrkFund');
	disable('sourceSaniFund');	
}
if(hab!="-1")
{
	
	disable('classify');
	disable('facilities');
	disable('toilets');
	disable('runningwater');
	disable('urinals');
	disable('nonDrink');
	disable('nonSani');
	disable('drkMonth');
	disable('drkYear');
	disable('saniMonth');
	disable('saniYear');
	disable('sourceDrkFund');
	disable('sourceSaniFund');	
	
}
if(cat!="00")
{	
	enable('classify');
	enable('facilities');
	disable('toilets');
	disable('runningwater');
	disable('urinals');
	disable('nonDrink');
	disable('nonSani');
	disable('drkMonth');
	disable('drkYear');
	disable('saniMonth');
	disable('saniYear');
	disable('sourceDrkFund');
	disable('sourceSaniFund');	
}
if(fac=="Drinking Water Only")
{	
	enable('classify');
	enable('facilities');
	disable('toilets');
	disable('runningwater');
	disable('urinals');
	disable('nonDrink');
	enable('nonSani');
	disable('drkMonth');
	disable('drkYear');
	enable('saniMonth');
	enable('saniYear');
	disable('sourceDrkFund');
	enable('sourceSaniFund');	
		
}
if(fac=="Sanitation (Toilet Only)")
{	
	enable('classify');
	enable('facilities');
	enable('toilets');
	enable('runningwater');
	disable('urinals');
	enable('nonDrink');
	enable('nonSani');
	enable('drkMonth');
	enable('drkYear');
	enable('saniMonth');
	enable('saniYear');
	enable('sourceDrkFund');
	enable('sourceSaniFund');	
	
}
if(fac=="Sanitation (Urinal Only)")
{
	enable('classify');
	enable('facilities');
	disable('toilets');
	disable('runningwater');
	enable('urinals');
	enable('nonDrink');
	enable('nonSani');
	enable('drkMonth');
	enable('drkYear');
	enable('saniMonth');
	enable('saniYear');
	enable('sourceDrkFund');
	enable('sourceSaniFund');	
}
if(fac=="Sanitation (Both)")
{
	enable('classify');
	enable('facilities');
	enable('toilets');
	enable('runningwater');
	enable('urinals');
	enable('nonDrink');
	disable('nonSani');
	enable('drkMonth');
	enable('drkYear');
	disable('saniMonth');
	disable('saniYear');
	enable('sourceDrkFund');
	disable('sourceSaniFund');	
	
}
if(fac=="Both (Drink. and Sani.)")
{
	enable('classify');
	enable('facilities');
	enable('toilets');
	enable('runningwater');
	enable('urinals');
	disable('nonDrink');
	disable('nonSani');
	disable('drkMonth');
	disable('drkYear');
	disable('saniMonth');
	disable('saniYear');
	disable('sourceDrkFund');
	disable('sourceSaniFund');	
	
}
if(fac=="None")
{
	enable('classify');
	enable('facilities');
	disable('toilets');
	disable('runningwater');
	disable('urinals');
	enable('nonDrink');
	enable('nonSani');
	enable('drkMonth');
	enable('drkYear');
	enable('saniMonth');
	enable('saniYear');
	enable('sourceDrkFund');
	enable('sourceSaniFund');	
}


if(toi=="None")
{
	disable('runningwater');
}


if(toi=="Yes(Only for Boys)")
{
	
	enable('runningwater');
	document.getElementById('runningwater').value="Yes(Only for Boys)";
	
}


if(toi=="Yes(Only for Girls)")
{
	
	enable('runningwater');
	document.getElementById('runningwater').value="Yes(Only for Girls)";
	
}
if(toi=="Yes(for Both)")
{
	
	enable('runningwater');
	document.getElementById('runningwater').value="Yes(for Both)";
	
}


}

function  enable(field)
{
	document.getElementById(field).disabled=false;
}

function  disable(field)
{
	document.getElementById(field).disabled=true;
}

function getClassify()
{
	init();
	return true;
}

function funFac()
{
init();
return true;
}

function charNotAllowed()
{
var charCode=event.keyCode;
if(charCode == 39)
{
	alert("Symbol Not Allowed");
	return false;
}
else
{
	return true;
}
}

function getData()
{
document.forms[0].action="switch.do?prefix=/masters&page=/school.do&mode=data";
document.forms[0].submit();
}
function funview()
{
	if(document.getElementById('district').value == "-1")
	{
		alert("District Required")
		return false;
	}
	else 
	{
		return true;
	}
}
function funViewLinkAsset()
{
	if(document.getElementById('district').value == "-1")
	{
		alert("District Required")
		return false;
	}
	if(document.getElementById('mandal').value == "-1")
	{
		alert("Mandal Required")
		return false;
	}
	else 
	{
		document.forms[0].action="switch.do?prefix=/masters&page=/school.do&mode=addAsset";
		document.forms[0].submit();
return true;
	}
}
function funsave()
{

var dist=document.getElementById('district').value;
var mand=document.getElementById('mandal').value;
var panch=document.getElementById('panchayat').value;
var vill=document.getElementById('village').value;
var hab=document.getElementById('habitation').value;
var name=document.getElementById('schoolName').value;
var nos=document.getElementById('nostudents').value;
var nob=document.getElementById('noBoys').value;
var nog=document.getElementById('noGirls').value;
var faci=document.getElementById('facilities').value;
var classi=document.getElementById('classify').value;
var categ=document.getElementById('category').value;
var lat=document.getElementById('schoolLatitude').value;
var lon=document.getElementById('schoolLongitude').value;
var ele=document.getElementById('schoolElevation').value;
var way=document.getElementById('schoolWaypoint').value;
var message="";
var res=0;
if(hab=="-1")
{
alert("Select Habitation Name");
return false;
}
else if(name=="")
{
alert("Select School Name");
return false;
}
else if(categ=="00")
{
alert("Select Category Of School");
return false;
}
else if(classi=="00")
{
alert("Select Classification Of School");
return false;
}
else if(nos=="")
{
alert("Select Number of Students");
return false;
}
else if(nob=="")
{
alert("Select Number Boys");
return false;
}
else if(nog=="")
{
alert("Select Number Girls");
return false;
}
else if(faci=="00")
{
alert("Select Facilities Available");
return false;
}
else if(document.forms[0].toilets.disabled==false && document.forms[0].toilets.value=="00")
{
	alert("Select Separate Toilets Option");
	return false;
}
else if(document.forms[0].runningwater.disabled==false && document.forms[0].runningwater.value=="00")
{
	alert("Select Separate Running Water in Toilets Option");
	return false;
}
else if(document.forms[0].urinals.disabled==false && document.forms[0].urinals.value=="00")
{
	alert("Select Separate Urinals Option");
	return false;
}
else if(document.forms[0].nonDrink.disabled==false && document.forms[0].nonDrink.value=="00")
{
	alert("Select Reasons For Non Availability Of Drinking Water Facility Option");
	return false;
}
else if(document.forms[0].nonSani.disabled==false && document.forms[0].nonSani.value=="00")
{
	alert("Select Reasons For Non Availability Of Sanitation Facility Option");
	return false;
}
else if(document.forms[0].drkMonth.disabled==false && document.forms[0].drkMonth.value=="00")
{
	alert("Select Target for Drinking Water:Month");
	return false;
}
else if(document.forms[0].drkYear.disabled==false && document.forms[0].drkYear.value=="00")
{
	alert("Select Target for Drinking Water:Year");
	return false;
}
else if(document.forms[0].saniMonth.disabled==false && document.forms[0].saniMonth.value=="00")
{
	alert("Select Target for Sanitation:Month");
	return false;
}
else if(document.forms[0].saniYear.disabled==false && document.forms[0].saniYear.value=="00")
{
	alert("Select Target for Sanitation:Year");
	return false;
}
else if(document.forms[0].sourceDrkFund.disabled==false && document.forms[0].sourceDrkFund.value=="00")
{
	alert("Select Source of Funding(Drinking Water Facility)");
	return false;
}
else if(document.forms[0].sourceSaniFund.disabled==false && document.forms[0].sourceSaniFund.value=="00")
{
	alert("Select Source of Funding(Sanitation Facility)");
	return false;
}
else if(document.forms[0].schoolLatitude=="" && document.forms[0].schoolLatitude.value==null)
{
	alert("Enter Latitude)");
	return false;
}
else if(document.forms[0].schoolLongitude=="" && document.forms[0].schoolLongitude.value==null)
{
	alert("Enter Longitude)");
	return false;
}
else if(document.forms[0].schoolElevation=="" && document.forms[0].schoolElevation.value==null)
{
	alert("Enter Elevation)");
	return false;
}
else if(document.forms[0].schoolWaypoint=="" && document.forms[0].schoolWaypoint.value==null)
{
	alert("Enter Waypoint)");
	return false;
}
else 
{
	return true;
}
}


function totalfn1()
{

/*var nos=document.getElementById('noStudents').value;
var nob=document.getElementById('noBoys').value;
var nog=document.getElementById('noGirls').value;
no=parseInt(nob)+parseInt(nog);
if(parseInt(nos)!=no)
{
alert("No.Of Students != No.Of Boys+No.Of Girls");
}
return true;
}*/
var nos=document.getElementById('noStudents').value;
var nob=document.getElementById('noBoys').value;
var nog=document.getElementById('noGirls').value;
no=parseInt(nob)+parseInt(nog);

if(nob!='' && nog=='')
{
document.getElementById('noStudents').value=nob;
} 
if(nob=='' && nog!='')
{
document.getElementById('noStudents').value=nog;
} 
if(nob!='' && nog!='')
{
document.getElementById('noStudents').value=no;
} 
return true;
}
// code added by sridhar 
function fnViewschool()
{
  
var rdist=document.getElementById('district').value;
var rmand=document.getElementById('mandal').value;
var rpanch=document.getElementById('panchayat').value;
var rvill=document.getElementById('village').value;
var rhab=document.getElementById('habitation').value;

if(rdist=="-1")
 {
  alert("Please Select District");
  return false;
 }
else if(rmand=="-1")
 {
  alert("Please Select Mandal");
  return false;
 }
 else{
    document.forms[0].action="/pred/masters/rws_school_view_rpt.jsp?&dcode="+rdist+"&mcode="+rmand+"&pcode="+rpanch+"&vcode="+rvill+"&habcode="+rhab;
    document.forms[0].submit(); 
   } 
 }

</script>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy serve
%>

<title>School Master</title>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>

<body bgcolor="#edf2f8" onload="init()" >
<html:form action="school.do&mode=data">

		<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />


<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="School Form" />
	<jsp:param name="TWidth" value="890" />
	<jsp:param name="contextHelpUrl" value="./help/Help For PRED.doc" />
</jsp:include>

<table width="931" border="0" bgcolor="#DEE3E0" bordercolor="#8A9FCD" style="border-collapse:collapse;" align="center">
<tr>
<td>  
	<fieldset>
	<legend>District Details</legend>
	<label>
	<table border=0 width="924">
	<tr>
		<td class="textborder" width="245">District<font color="red">*</font>&nbsp;&nbsp;&nbsp;</td>
		<td width="200">  
		<html:select property="district" styleClass="mycombo" style="width:150px" onchange="getData();">
		<option value="-1">SELECT...</option>
		<logic:present name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	</td>

   	<td class="textborder" width="234">Mandal</td>
	<td width="217"> 
	<html:select property="mandal" style="width:150px" styleClass="mycombo" onchange="getData();">
	<option value="-1">SELECT...</option>
	<logic:present name="mandals">
	<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
    </td>
  </tr>
  
  <tr>
 		<td class="textborder" width="245">Panchayat</td>
		<td width="200">
		<html:select property="panchayat" style="width:150px" styleClass="mycombo" onchange="getData();">
		<option value="-1">SELECT...</option>
		<logic:present name="panchayats">
		<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	    </td>

		<td class="textborder" width="210">Village</td><td width="190">
		<html:select property="village" style="width:150px" styleClass="mycombo" onchange="getData();" >
		<option value="-1">SELECT...</option>
		<logic:present name="villages">
		<html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
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
	<legend>School Details</legend>
	<label>
	<table width="910" border="0">
  
 <tr>
    
	
    <td width="245"><span class="textborder">Name of School:</span></td>
    <td width="199"><span class="textborder">
    <html:text property="schoolName" style="width:160px" styleClass="mytext" maxlength="30" onkeypress="return charNotAllowed()" />      
    </span>
    </td>
	
     
	<td width="230"><span class="textborder">Name of Habitation :</span></td>
	<td width="202"><span class="textborder">
	<html:select property="habitation" style="width:160px" styleClass="mycombo" onchange="javascript:getData();" ><!-- disabled="true" -->
	<option value="-1">SELECT...</option>
	<logic:present name="habitations">
	<html:options collection="habitations" name="labelValueBean" property="habCode" labelProperty="habName" />
	</logic:present>
	</html:select> 
    </td>
 </tr>  
  
  <tr>
    <td><span class="textborder">Category of School:</span></td>
    <td><span class="textborder">
		 <html:select property="category" style="width:160px" styleClass="mycombo" onchange="return getClassify();">
			<option value="00">SELECT..</option>
			<option value="01">Balwadi/Aganwadi</option>
	        <option value="02">Primary</option>
	        <option value="03">Upper Primary</option>
	        <option value="04">Secondary </option>
	        <option value="05">Sr. Secondary</option>
	      </html:select></span>
    </td>
    
    <td><span class="textborder">Classification of School: </span></td>
    <td><span class="textborder">
       <html:select property="classify" style="width:160px" styleClass="mycombo" >
		    <option value="00">SELECT..</option>
		    <option value="Government">Govt.</option>
	        <option value="Local Body">Local Body</option>
	        <option value="Govt.Aided">Govt. Aided</option>
	        <option value="Private">Private</option>
		</html:select></span>
	</td>
  </tr>  
  
  <tr>
    <td width="245"><span class="textborder">Number of Boys:</span></td>
    <td width="199"><span class="textborder">
  	  <html:text property="noBoys" style="width:160px" styleClass="mytext" onkeypress="return numeralsOnly(event)" onblur="return totalfn1()"  maxlength="3"/>      
    </span></td>

    <td width="245"><span class="textborder">Number of Girls:</span></td>
    <td width="199" class="textborder">
    	<html:text property="noGirls" style="width:160px" styleClass="mytext" onkeypress="return numeralsOnly(event)" onblur="return totalfn1()" maxlength="3" />      
	</td>
   
  </tr>
  
  <tr>    
    <td class="textborder">Number of <span id="lblnoofStudents">Students</span></td>
    <td><span class="textborder">
	    <html:text property="noStudents" style="width:160px" styleClass="mytext" onkeypress="return numeralsOnly(event)" readonly="true"/></span>
    </td>
    
    <td class="textborder">Facilities Available:</td>
    <td><span class="textborder">
    <html:select property="facilities" style="width:160px" styleClass="mycombo" onchange="return funFac();">
	    <html:option value="00">SELECT..</html:option>
		<html:option value="Drinking Water Only">Drinking Water Only</html:option>
        <html:option value="Sanitation (Toilet Only)">Sanitation (Toilet Only)</html:option>
        <html:option value="Sanitation (Urinal Only)">Sanitation (Urinal Only)</html:option>
        <html:option value="Sanitation (Both)">Sanitation (Both)</html:option>
        <html:option value="Both (Drink. and Sani.)">Both (Drink. &amp; Sani.)</html:option>
        <html:option value="None">None</html:option>
	</html:select>
    </span></td>
    
  </tr>

  <tr>
    <td class="textborder">Separate Toilets Available for Boys <br>&amp; Girls:</td>
    <td>
    <html:select property="toilets" style="width:160px" styleClass="mycombo" onchange="return funFac();">
	  <option value="00">SELECT..</option>
	  <option value="Yes(Only for Boys)">Yes (Only for Boys)</option>
      <option value="Yes(Only for Girls)">Yes (Only for Girls)</option>
      <option value="Yes(for Both)">Yes (for Both)</option>
      <option value="None">None</option>
    </html:select>
    </td>
    
    <td class="textborder">Separate Urinal   Available for Boys <br>&amp; Girls:</td>
    <td><span class="textborder">
    <html:select property="urinals" style="width:160px" styleClass="mycombo" >
	    <option value="00">SELECT..</option>
        <option value="Yes(Only for Boys)">Yes (Only for Boys)</option>
        <option value="Yes(Only for Girls)">Yes (Only for Girls)</option>
        <option value="Yes(for Both)">Yes (for Both)</option>
        <option value="None">None</option>
      </html:select>
    </span></td>
  </tr>
   <tr>
    <td class="textborder">Running Water in Toilets</td>
    <td>
    <html:select property="runningwater" style="width:160px" styleClass="mycombo" >
	  <option value="00">SELECT..</option>
	  <option value="Yes(Only for Boys)">Yes (Only for Boys)</option>
      <option value="Yes(Only for Girls)">Yes (Only for Girls)</option>
      <option value="Yes(for Both)">Yes (for Both)</option>
      <option value="None">None</option>
    </html:select>
    </td>
    </tr>
  <tr>
    <td class="textborder">Reasons for Non Availibility of<br>Drinking Water Facility:</td>
    <td><span class="textborder">
    <html:select property="nonDrink" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="O and M">O &amp; M</option>
        <option value="Quality Of Water">Quality Of Water</option>
        <option value="Quantity Of Water">Quantity Of Water</option>
        <option value="Drying Of Sources">Drying Of Sources</option>
        <option value="Multiple Reasons">Multiple Reasons</option>
        <option value="Others">Others</option>
     </html:select>
    </span></td>

    <td class="textborder">Reasons for Non   Availibility of Sanitation Facility:</td>
    <td><span class="textborder">
    <html:select property="nonSani" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="O and M">O &amp; M</option>
        <option value="Quantity Of Water">Quantity Of Water</option>
        <option value="Drying Of Sources">Drying Of Sources</option>
        <option value="Multiple Reasons">Multiple Reasons</option>
        <option value="Others">Others</option>
      </html:select>
    </span></td>
  </tr>
 
  <tr>
    <td class="textborder"><p><span id="lblTargetDrinking">Target for Drinking water:</span><span id="lblTargetDrinkingMonth">Month:</span></p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year:</p></td>
    <td><p>
    <html:select property="drkMonth" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="Jaunary">Jaunary</option>
        <option value="Febuary">Febuary</option>
        <option value="March">March</option>
        <option value="April">April</option>
        <option value="May">May</option>
        <option value="June">June</option>
        <option value="July">July</option>
        <option value="August">August</option>
        <option value="September">September</option>
        <option value="October">October</option>
        <option value="November">November</option>
        <option value="December">December</option>
    </html:select>
    </p>
 
    <p>
    <html:select property="drkYear" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
	    <%Date sysdate = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		String currentYear = format.format(sysdate);
		String Year = "";
		int cy = 0;
		
		
			cy = Integer.parseInt(currentYear);
			
			while (cy >= 2001) {
				 Year=""+cy;
		%>
		<option value=<%=cy %>><%=cy %></option>
		<%
				cy = cy - 1;
				
			}
		
		%>
        
        
    </html:select>
	</p></td>
    
    <td class="textborder">Target for Sanitation:<span id="lblSanitationMonth">&nbsp;&nbsp;&nbsp;Month:</span>
    <label></label>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year:</p></td>
    <td><p>
    <html:select property="saniMonth" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="Jaunary">Jaunary</option>
        <option value="Febuary">Febuary</option>
        <option value="March">March</option>
        <option value="April">April</option>
        <option value="May">May</option>
        <option value="June">June</option>
        <option value="July">July</option>
        <option value="August">August</option>
        <option value="September">September</option>
        <option value="October">October</option>
        <option value="November">November</option>
        <option value="December">December</option>
    </html:select>
    </p>
    
    <p>
    <html:select property="saniYear" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
       <%Date sysdate = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		String currentYear = format.format(sysdate);
		String Year = "";
		int cy = 0;
		
		
			cy = Integer.parseInt(currentYear);
			
			while (cy >= 2001) {
				 Year=""+cy;
		%>
		<option value=<%=cy %>><%=cy %></option>
		<%
				cy = cy - 1;
				
			}
		
		%>
  </html:select>
  </p></td>
  </tr>
 <tr>
    <td class="textborder" align="left">Completion Drinking Water</td>
		<td class="textborder">
		<html:text property="complDateDW"    style="width: 100px"  readonly="true" onkeypress="return decimalsOnly(event)"/>

<a href="javascript: showCalendarFuture(document.forms[0].complDateDW);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
       </td>
       
       <td class="textborder" align="left">Completion Sanitation</td>
       
       <td><html:text property="complDateSanitation"    style="width: 100px"  readonly="true" onkeypress="return decimalsOnly(event)"/>

<a href="javascript: showCalendarFuture(document.forms[0].complDateSanitation);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
       </tr>





  <tr>
    <td class="textborder">Source of Funding(Drinking Water   Facility):</td>
		<td class="textborder"><html:select property="sourceDrkFund"
							 style="width:160px" styleClass="mycombo">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="programs" property="value"
								labelProperty="label" />
						</html:select></td>
    
    <td class="textborder"><span class="textborder">Source of Funding(Sanitation Facility):</span></td>
    <td><span class="textborder">
    <html:select property="sourceSaniFund" style="width:160px" styleClass="mycombo">
	 						<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="programs" property="value"
								labelProperty="label" />
						</html:select>
   
    </span></td>
   </tr>
   <tr>
    <td width="245"><span class="textborder">Latitude-N:</span></td>
    <td width="199"><span class="textborder">
    <html:text property="schoolLatitude" style="width:160px" styleClass="mytext" maxlength="10"  onkeypress="return decimalsOnly()" />      
    </span>
    </td>
	<td width="245"><span class="textborder">Longitude-E:</span></td>
    <td width="199"><span class="textborder">
    <html:text property="schoolLongitude" style="width:160px" styleClass="mytext" maxlength="10" onkeypress="return decimalsOnly()" />      
    </span>
    </td>
	</tr>
	<tr>
    <td width="245"><span class="textborder">Elevation:</span></td>
    <td width="199"><span class="textborder">
    <html:text property="schoolElevation" style="width:160px" styleClass="mytext" maxlength="10" onkeypress="return decimalsOnly()" />      
    </span>
    </td>
	<td width="245"><span class="textborder">Way Point:</span></td>
    <td width="199"><span class="textborder">
    <html:text property="schoolWaypoint" style="width:160px" styleClass="mytext"  maxlength="4" onkeypress="return decimalsOnly()" />      
    </span>
    </td>
	</tr>
	
	
   
 </table>

</label>
</fieldset>

</td>
</tr>


 <tr>
    <td colspan="2" align="center">
	    <html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return funsave();" />
 		<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" /> 
		<html:submit property="mode" title="View the Fields" styleClass="btext" value="View" onclick="return funview()" />
		<html:button property="mode" title="View the Fields" styleClass="btext" value="Link Asset/Work" onclick="return funViewLinkAsset()" />
        <html:button  property="schoolview" title="View the Fields" styleClass="btext" value="View Schools with Assets" onclick="fnViewschool()" />
	</td>
 </tr>

</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="890" />
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

