<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%

 System.out.println("RWSSDEPT");
int count = 1;

	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	String ad=(String)session.getAttribute("userId");
	System.out.println("user:"+ad);
%>
<head>
<style type="text/css"> 
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
function getDivisions()
	{
	 
	  document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=divisions";
	  document.forms[0].submit();
	}

function getPrograms()
{
		if(document.forms[0].divisionOfficeCode.value==''){
	  alert("Please Select Division");
		return false;
}
	document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=getPrograms";
	document.forms[0].submit();
	
}
function getWorkcategory()
	{
	  document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=workcategory";
	  PSWorkForm.submit();
	}
function getSubDivisions()
	{
	
		document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=data";
		PSWorkForm.submit();
	}
function getProgramme()
{

	document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=programmes";
	PSWorkForm.submit();
	
}
function getSubProgramme()
{
	
	document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=subprogrammes";
	PSWorkForm.submit();
	
}
function getWorks1()
{
	
	document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=getworks";
	PSWorkForm.submit();
	
}
function checkMe()
{
	if(document.forms[0].type[0].checked)
	{
		document.forms[0].type[0].checked =true;
	}
	else if(document.forms[0].type[1].checked)
	{
		document.forms[0].type[1].checked =true;
	}
	else
	{
		document.forms[0].type[0].checked =true;
	}
}

function getWorks()
	{
	  if(document.forms[0].circleOfficeCode.value==''){
	  alert("Please Select Circle");
		return false;
      //document.PSWorkForm.action="switch.do?prefix=/works&page=/aap.do&mode=data";
	  //document.PSWorkForm.submit();		
	  }
	  else if(document.forms[0].divisionOfficeCode.value==''){
	  alert("Please Select Division");
		return false;
     // document.PSWorkForm.action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=programmes";
	 // document.PSWorkForm.submit();		
	  }
	//   else if(document.forms[0].type[0].checked == false && document.forms[0].type[1].checked == false ){
	//  alert("Please Select Plan/Non Plan");
	//	return false;
     // document.PSWorkForm.action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=programmes";
	 // document.PSWorkForm.submit();		
	//  }
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=getWorks";
		document.forms[0].submit();		
		}
	}
function fnShowHabs(workid)
{
	var workId=workid.name;
	var url = "switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=showHabs&workID="+workId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
function getOldWorkDetails(){
 var work_id=document.getElementById('oldWorkId').value;
  if(work_id==""){
  alert("Please Enter Old Work ID");
	return;
}
var length=work_id.length;
 if(length!=14){
 alert("Work Id Length Should be 14 Didgit.");
	return; 
}

		document.forms[0].action="switch.do?prefix=/works&page=/WorkLink.do&mode=oldwork";
		document.forms[0].submit();		
		
}

function getNewWorkDetails(){
 var work_id=document.getElementById('newWorkId').value;
 var oldwork_id=document.getElementById('oldWorkId').value;

  if(work_id==""){
  alert("Please Enter New Work ID");
document.getElementById('newWorkId').value="";
	return;
}
var length=work_id.length;
 if(length!=14){
document.getElementById('newWorkId').value="";
 alert("Work Id Length Should be 14 Didgit.");

	return; 
}
if(work_id==oldwork_id){
alert("Old and New Works Should Not Be Same.");
document.getElementById('newWorkId').value="";
	return; 

}

		document.forms[0].action="switch.do?prefix=/works&page=/WorkLink.do&mode=newwork";
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

document.forms[0].action="switch.do?prefix=/works&page=/WorkLink.do&mode=save";
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

document.forms[0].action="switch.do?prefix=/works&page=/WorkLink.do&mode=update";
		document.forms[0].submit();	
}
</script>
</head>
<html:form action="/WorkLink"  >
<body >
<table width="100%">
<tr><td align=right><b><font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Amount in Lakhs</font></b></td><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Blocked Works Link Form " />
	<jsp:param name="TWidth" value="970" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="1000" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Old Work</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2"  width="800"  border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
		<tr class="textborder">	
          <td>Enter Work ID:<font color="red"><b>*</b></font></td><td><html:text styleClass="thin-text-box" property="oldWorkId"  maxlength="14" onkeypress="return decimalsOnly(event)" /></td>
             <td><input type="button" value="Get Details" onclick="getOldWorkDetails()"></td>
		</tr>
<tr>
			
			<td class="textborder" align="center">Work&nbsp;Name:&nbsp;</td><td colspan=10><html:text property="oldWorkName" size="130"  disabled="true" /></td>
</tr>
<tr>
			<td class="textborder" align="center">Program</td><td><html:text property="oldProgram" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">SubProgram</td><td><html:text property="oldSubProgName" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">Sanction&nbsp;Date</td><td><html:text property="oldSanctionedDate" size="20"  disabled="true" /></td>
</tr>
<tr>
			<td class="textborder" align="center">Sanction&nbsp;Amount<td><html:text property="oldSanctionedAmount" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">Released&nbsp;Amount(Bank+PAO)<td><html:text property="oldReleasesSoFar" size="20"  disabled="true" /></td>

</tr>
		</table>
</label>
</fieldset>
</td>
</tr>
<tr>
<td>
<fieldset>
		<legend  ><B>New Work</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2"  width="1000"  border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
		<tr class="textborder">	
          <td >Enter Work ID:<font color="red"><b>*</b></font></td><td><html:text styleClass="thin-text-box" property="newWorkId" maxlength="14" onkeypress="return decimalsOnly(event)"/></td>
             <td><input type="button" value="Get Details" onclick="getNewWorkDetails()"></td>
		</tr>
<tr>
			
			<td class="textborder" align="center">Work&nbsp;Name&nbsp;</td><td colspan=10><html:text property="newWorkName" size="130"  disabled="true" /></td>
</tr>
<tr>
			<td class="textborder" align="left">Program:</td><td><html:text property="newProgram" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">SubProgram</td><td><html:text property="newSubProgName" size="20"  disabled="true" /></td>
			<td class="textborder" align="center">Sanction&nbsp;Date</td><td><html:text property="newSanctionedDate" size="20"  disabled="true" /></td>
</tr>
<tr>
			<td class="textborder" align="center">Sanction&nbsp;Amount<td><html:text property="newSanctionedAmount" size="20"  disabled="true" /></td>
<td class="textborder" align="center">Sanctioned&nbsp;Habs<td><html:text property="adminHabs" size="20"  disabled="true" /></td>
</tr>
		</table>
</label>
</fieldset>
</td>
</tr>
<tr></tr>
<tr>
<%
   String  value=(String)request.getAttribute("saved");

   if(value!=null && value.equals("true")){

 %>
<td colspan=2  class=btext align=center><input type="button" class=btext value="UPDATE LINK" onclick="fnUpdate()" ></td>


<%}else { %>

<td colspan=2  class=btext align=center><input type="button" class=btext value="ADD LINK" onclick="fnSave()"  ></td>

<%} %>
</tr>

</table>

</body>

</html:form>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="970"/>
</jsp:include>
<script>

</script>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>