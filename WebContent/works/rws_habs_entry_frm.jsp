<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%

int count = 1;
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	String ad=(String)session.getAttribute("userId");
	//System.out.println("user:"+ad);

      String work_id=(String)request.getAttribute("workId");
             String code="Habs";
         if(work_id!=null && work_id.substring(6,8).equals("11")){
			code="Schools";
    }else          if(work_id!=null && work_id.substring(6,8).equals("12")){
			code="Labs";
    }else {
code="Habs";
         }

%>
<head>
<style type="text/css">
fieldset { border:2px solid orange }
legend {
  padding: 0.2em 0.5em;
  border:2px solid orange;
  color:blue;
  font-size:90%;
  text-align:right;
  }
 
<!--
.style1 {color: #FF0000;
font-family: verdana;
font-size: 13px;}
-->
</style>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script>
function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}

function fnShowHabs()
{
	var url = "switch.do?prefix=/works&page=/HabLink.do&mode=adminhabs";
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}

 function fnMandals(type)
{
var w=document.getElementById('workId').value;
	var url = "switch.do?prefix=/works&page=/HabLink.do&mode=pickmandals&workId="+w+"&type="+type;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
} 
function fnDistrictsMandals(type)
{
var w=document.getElementById('workId').value;
	var url = "switch.do?prefix=/works&page=/HabLink.do&mode=pickdistricts&workId="+w+"&type="+type;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}

function fnShowSchools(){
var url = "switch.do?prefix=/works&page=/HabLink.do&mode=showschools";
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);


}
function fnAddSchool(){

}

function  fnAddLabs(type){

var w=document.getElementById('workId').value;
	var url = "switch.do?prefix=/works&page=/HabLink.do&mode=District-Labs&workId="+w+"&type="+type;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
function fnShowLabs(){

var url = "switch.do?prefix=/works&page=/HabLink.do&mode=showlabs";
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);



}



function fnTechHabs(){
var url = "switch.do?prefix=/works&page=/HabLink.do&mode=techhabs";
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}

function fnCompHabs(){
var url = "switch.do?prefix=/works&page=/HabLink.do&mode=comphabs";
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
function getOldWorkDetails(){

 var work_id=document.getElementById('workId').value;
  if(work_id==""){
  alert("Please Enter Old Work ID");
	return;
}
var length=work_id.length;
 if(length!=14){
 alert("Work Id Length Should be 14 Didgit.");
	return; 
}

if(work_id.substr(6,2)=='12'){
alert("Lab Work Id Should Not be allowed Here.");
	return; 
}

		document.forms[0].action="switch.do?prefix=/works&page=/HabLink.do&mode=details";
		document.forms[0].submit();		
		
}


function fnSave(){

var work_id=document.getElementById('newWorkName').value;
 var oldwork_id=document.getElementById('oldWorkName').value;

  if(work_id==""){
  alert("Please Enter New Work ID");
	return;
}
if(oldwork_id==""){
  alert("Please Enter Old Work ID");
	return;
}

document.forms[0].action="switch.do?prefix=/works&page=/HabLink.do&mode=save";
		document.forms[0].submit();	
}

function fnsubDivSave(){
	var subdiv=document.getElementById('subdivname').value;
	  if(subdiv=="00"){
	  alert("Please Select Subdivision");
		return;
	}
	 document.forms[0].action="switch.do?prefix=/works&page=/HabLink.do&mode=savesubdiv";
			document.forms[0].submit();	 
	}


function fnUpdate(){

var work_id=document.getElementById('newWorkName').value;
 var oldwork_id=document.getElementById('oldWorkName').value;

  if(work_id==""){
  alert("Please Enter New Work ID");
	return;
}
if(oldwork_id==""){
  alert("Please Enter Old Work ID");
	return;
}

document.forms[0].action="switch.do?prefix=/works&page=/HabLink.do&mode=update";
		document.forms[0].submit();	
}
</script>
</head>
<html:form action="/HabLink.do"  >
<body >
<table width="100%">
<tr><td align=right><b><font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Amount in Lakhs</font></b></td><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Habs Entry Form " />
	<jsp:param name="TWidth" value="960" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" width="1000" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Admin Sanction</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2"   border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
		<tr class="textborder">	
          <td>Enter Work ID:<font color="red"><b>*</b></font></td><td><html:text styleClass="thin-text-box" property="workId"  maxlength="14" onkeypress="return decimalsOnly(event)" /></td>
             <td><input type="button" value="Get Details" onclick="getOldWorkDetails()"></td>
		</tr>
<tr>
			
			<td class="textborder" align="right">Work&nbsp;Name:&nbsp;</td><td colspan=10><html:text property="workName" size="130"  disabled="true" /></td>
</tr>
<tr>
			<td class="textborder" align="right">Program</td><td><html:text property="programName" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">Sub&nbsp;Program</td><td><html:text property="subProgName" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">Sanction&nbsp;Date</td><td ><html:text property="sanctionedDate" size="20"  disabled="true" /></td>
</tr>
<tr>
			<td class="textborder" align="right">Sanction&nbsp;Amount<td><html:text property="sanctionedAmount" size="20"  disabled="true" /></td>
<td class="textborder" align="center">Sanction&nbsp;<%=code %><td><html:text property="sanctionedHabs" size="20"  disabled="true" /></td>
<logic:equal  name="HabLinkBean" property="isAdmnSanction" value="true">
<logic:equal  name="HabLinkBean" property="typeOfWork" value="hab">
<td class="textborder" align="center" colspan=2><input type="button" class=btext value="Show&nbsp;Habs" onclick="fnShowHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add/Remove&nbsp;Habs"  onclick="fnDistrictsMandals('admin');" /></td>
</logic:equal>
<logic:equal  name="HabLinkBean" property="typeOfWork" value="school">
<td class="textborder" align="center" colspan=2><input type="button" class=btext value="Show&nbsp;Schools" onclick="fnShowSchools()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add/Remove&nbsp;School"  onclick="fnMandals('admin');" /></td>
</logic:equal>
<logic:equal  name="HabLinkBean" property="typeOfWork" value="lab">
<td class="textborder" align="center" colspan=2><input type="button" class=btext value="Show&nbsp;Labs" onclick="fnShowLabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add/Remove&nbsp;Labs"  onclick="fnAddLabs('admin');" /></td>
</logic:equal>


</logic:equal>
<logic:notEqual  name="HabLinkBean" property="isAdmnSanction" value="true">
<td class="textborder" align="center" colspan=2><input type="button" disabled class=btext value="Show&nbsp;Habs" onclick="fnShowHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" disabled class=btext value="Add/Remove&nbsp;Habs"  onclick="fnDistrictsMandals('admin');" /></td>
</logic:notEqual>

			
</tr>
		</table>
</label>
</fieldset>
</td>
</tr>
<tr>
<td>
<fieldset>
		<legend  ><B>Technical Sanction</B></legend>
<label>
<table cellpadding="0" cellspacing="2"   border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
		<tr class="textborder">	
<td class="textborder" align="center">Sanction&nbsp;Numer</td><td><html:text property="tsNo" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">&nbsp;&nbsp;&nbsp;Sanction&nbsp;Date</td><td><html:text property="tsDate" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">&nbsp;&nbsp;Sanction&nbsp;Amount</td><td><html:text property="tsAmount" size="20"  disabled="true" /></td>
</tr>
<tr><td class="textborder" align="center">Tech&nbsp;<%=code %><td><html:text property="techHabs" size="20"  disabled="true" /></td>
<logic:equal  name="HabLinkBean" property="isTechSancationed" value="true">
<logic:equal  name="HabLinkBean" property="typeOfWork" value="hab">
<td colspan=2></td><td></td><td class="textborder" align="center" ><input type="button" class=btext value="Show&nbsp;Habs" onclick="fnTechHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add/Remove&nbsp;Habs" onclick="fnDistrictsMandals('tech');"  /></td>
</logic:equal>
<logic:equal  name="HabLinkBean" property="typeOfWork" value="school">
<td colspan=2></td><td></td><td class="textborder" align="center" ><input type="button" class=btext value="Show&nbsp;Schools" onclick="fnTechHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add/Remove&nbsp;Schools" onclick="fnMandals('tech');"  /></td>
</logic:equal>

<logic:equal  name="HabLinkBean" property="typeOfWork" value="lab">
<td colspan=2></td><td></td><td class="textborder" align="center" ><input type="button" class=btext value="Show&nbsp;Labs" onclick="fnTechHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add/Remove&nbsp;Habs" onclick="fnMandals('tech');"  /></td>
</logic:equal>


</logic:equal>
<logic:notEqual name="HabLinkBean" property="isTechSancationed" value="true">
<td colspan=2></td><td></td><td class="textborder" align="center" ><input type="button" class=btext value="Show&nbsp;Habs" disabled onclick="fnTechHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext disabled value="Add/Remove&nbsp;Habs" onclick="fnDistrictsMandals('tech');"  /></td>
</logic:notEqual>

</tr>
</table>
</label>
</fieldset>
</td>
</tr>


<tr>
<td>
<fieldset>
		<legend  ><B>Completion</B></legend>
<label>
<table cellpadding="0" cellspacing="2"   border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
		<tr class="textborder">	
<td class="textborder" align="center">Phisical&nbsp;Date</td><td><html:text property="phisicalDate" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fin.&nbsp;Date</td><td><html:text property="financialDate" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Partial&nbsp;Date</td><td><html:text property="partialDate" size="20"  disabled="true" /></td>
</tr>
<tr><td class="textborder" align="center">Covered&nbsp;<%=code %><td><html:text property="coveredHabs" size="20"  disabled="true" /></td>
<logic:equal  name="HabLinkBean" property="isCompletion" value="true">

<logic:equal  name="HabLinkBean" property="typeOfWork" value="hab">
<td colspan=2></td><td></td><td class="textborder" align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Show&nbsp;Habs" onclick="fnCompHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add/Remove&nbsp;Habs" onclick="fnDistrictsMandals('comp');"  /></td>
</logic:equal>
<logic:equal  name="HabLinkBean" property="typeOfWork" value="school">
<td colspan=2></td><td></td><td class="textborder" align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Show&nbsp;Habs" onclick="fnCompHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add/Remove&nbsp;Habs" onclick="fnMandals('comp');"  /></td>
</logic:equal>


<logic:equal  name="HabLinkBean" property="typeOfWork" value="lab">
<td colspan=2></td><td></td><td class="textborder" align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Show&nbsp;Labs" onclick="fnCompHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add/Remove&nbsp;Habs" onclick="fnMandals('comp');"  /></td>
</logic:equal>


</logic:equal>
<logic:notEqual name="HabLinkBean" property="isCompletion" value="true">
<td colspan=2></td><td></td><td class="textborder" align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" disabled class=btext value="Show&nbsp;Habs" onclick="fnCompHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" disabled class=btext value="Add/Remove&nbsp;Habs" onclick="fnDistrictsMandals('comp');"  /></td>
</logic:notEqual>

</tr>
</table>
</label>
</fieldset>
</td>
</tr>

<%-- <logic:equal  name="HabLinkBean" property="ishavesubdivcode" value="true"> --%>
<tr>
<td>
<fieldset>
		<legend  ><B>Sub Division</B></legend>
<label>
<table cellpadding="0" cellspacing="2"   border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
		<tr class="textborder">	
<td class="textborder" align="center">Circle&nbsp;</td><td><html:text property="cname" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Division&nbsp;</td><td><html:text property="divname" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sub&nbsp;Division</td>
			<td>
				<html:select property="subdivname" style="width:150px" styleId="vol"   styleClass="mycombo" >
					<%-- <html:option value="00"><bean:message key="app.pleaseSelect" /></html:option> --%>
					
					<html:options collection="subdivisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		   </td>
			<logic:equal  name="HabLinkBean" property="typeOfWork" value="hab">
<td colspan=2></td><td></td><td class="textborder" align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Save&nbsp;" onclick="fnsubDivSave()" />&nbsp;&nbsp;&nbsp;</td>
</logic:equal>
</tr>
<tr>
</tr>
</table>
</label>
</fieldset>
</td>
</tr>
<%-- </logic:equal> --%>




</table>

</body>

</html:form>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="960"/>
</jsp:include>
<%@ include file="/commons/rws_alert.jsp"%>