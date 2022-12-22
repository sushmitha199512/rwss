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

		document.forms[0].action="switch.do?prefix=/works&page=/QualityControl.do&mode=details";
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

if(work_id==""){
	  
	}



function openFile(index){

	//var bslno=document.getElementById("VOUCHER_LIST["+index+"].billSlNo").value;
	//var bslno=document.forms[0].elements["VOUCHER_LIST["+index+"].billSlNo"].value;
	//var billdates=document.forms[0].elements["VOUCHER_LIST["+index+"].billDate"].value;
	//var type="qc";
	var url="./switch.do?prefix=/works&page=/QualityControl.do&mode=showQcCertificate&workId="+document.forms[0].workId.value;

/* 	var url="./switch.do?prefix=/works&page=/WorkStatus.do&mode=showScannedCopy&slNo="+bslno+"&workId="+document.forms[0].workId.value;
 */	var width = 990;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";

	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
	
	
}

function openFile1(index){

	//var bslno=document.getElementById("VOUCHER_LIST["+index+"].billSlNo").value;
	//var bslno=document.forms[0].elements["VOUCHER_LIST["+index+"].billSlNo"].value;
	//var billdates=document.forms[0].elements["VOUCHER_LIST["+index+"].billDate"].value;
	//var type="qc";
	var url="./switch.do?prefix=/works&page=/QualityControl.do&mode=showTptCertificate&workId="+document.forms[0].workId.value;

/* 	var url="./switch.do?prefix=/works&page=/WorkStatus.do&mode=showScannedCopy&slNo="+bslno+"&workId="+document.forms[0].workId.value;
 */	var width = 990;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";

	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
	
	
}







function updateDetails()
{
	//engineerAssign
	var engineer_assn=document.getElementById('engineerAssign').value;
	var engineer_assn1=document.getElementById('engineerAssign1').value;
	var engineer_assn2=document.getElementById('engineerAssign2').value;
	var engineer_assn3=document.getElementById('engineerAssign3').value;
	//alert("*******"+engineer_assn);
	 var work_id=document.getElementById('workId').value;
	 
	 var issueDate=document.getElementById('issueDate').value;
	 var certDate=document.getElementById('certDate').value;
	 
	//alert("*******"+issueDate);
	//alert("*******"+certDate);
	 var qcImg = document.getElementById('qcImg');
	 var FileUploadPath1 = qcImg.value;
	 
	 var tptImg = document.getElementById('tptImg');
		var FileUploadPath2 = tptImg.value;
		
		
		
	  if(work_id==""){
	  alert("Please Enter Old Work ID");
		return;
	}else   if(engineer_assn==""){
		  alert("Please Select Name of the AE Inspected.");
			return;
		}
	else   if(engineer_assn1==""){
		  alert("Please Select Name of the DEE Inspected.");
			return;
		}
	else   if(engineer_assn2==""){
		  alert("Please Select Name of the EE Inspected.");
			return;
		}
	else   if(engineer_assn3==""){
		  alert("Please Select Name of the SE Inspected.");
			return;
		}
	else   if(issueDate==""){
		  alert("Please select Date of Inspection");
			return;
		}
	else   if(certDate==""){
		  alert("Date of Issue Certificate");
			return;
		}
	else if (document.forms[0].qcImg.value == ""
		|| document.forms[0].qcImg.value == "") {
	alert("Please Upload QC Certificate ");
	return false;

}else if (!fileMimeType(FileUploadPath1)) {			
	return false;
}

else if (document.forms[0].tptImg.value == ""
|| document.forms[0].tptImg.value == "") {
alert("Please Upload TPT Report ");
return false;

}else if (!fileMimeType(FileUploadPath2)) {			
return false;
}
 else{
 // alert("sssss");

//var ast= document.getElementById("astwork"+index).value;
//var atype=document.getElementById("assettype"+index).value;
 //alert(ast);
 // alert(atype);
  document.forms[0].action="switch.do?prefix=/works&page=/QualityControl.do?mode=upddetails";
  document.forms[0].submit();
  }
}
</script>
</head>
<html:form action="/QualityControl.do"  method="post" enctype="multipart/form-data">
<body >
<table width="100%">
<tr><td align=right><b><font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Amount in Lakhs</font></b></td><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Quality Control Entry Form " />
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

			
</tr>
		</table>
</label>
</fieldset>
</td>
</tr>



<tr>
		<td class="bwborder" >
		<fieldset>
		 <legend  ><B>Engineers Section</B></legend> 
		<label>
		
			<table cellpadding="0" cellspacing="2"   border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
<tr>
		
		<td class="textborder" align="right">Name of the AE Inspected.&nbsp;<html:select property="engineerAssign" style="width: 400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr>
		<tr>
		<td class="textborder" align="right">Name of the DEE Inspected.&nbsp;<html:select property="engineerAssign1" style="width: 400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr>
		<tr>
		<td class="textborder" align="right">Name of the EE Inspected.&nbsp;<html:select property="engineerAssign2" style="width:400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr><tr>
		<td class="textborder" align="right">Name of the SE Inspected.&nbsp;<html:select property="engineerAssign3" style="width: 400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr>
		


		</table>
</label>
</fieldset>
</td>
</tr>
<tr>
		<td class="bwborder" >
		<fieldset>
		 <legend  ><B>Dates Section</B></legend> 
		<label>
		
			<table cellpadding="0" cellspacing="2"   border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >


<tr>
		<td class="textborder" align="right" ><font face=verdana size=2><b>Date of Inspection</b><font color="#FF6666">*</font></td>
		<td class="textborder" align="right" style="padding-right: 200px;"><html:text  property="issueDate" style="width:145" styleClass="mytext"   />
		<a href="javascript: showCalendar(document.forms[0].issueDate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
			</a>
		</td>
		<td class="textborder" align="right"><font face=verdana size=2><b>Date of Issue Certificate</b><font color="#FF6666">*</font></td>
		<td class="textborder" align="right"><html:text property="certDate" style="width:145" styleClass="mytext" />
		<a href="javascript: showCalendar(document.forms[0].certDate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
			</a>
		</td>
		
		</tr> 
		</table>
</label>
</fieldset>
</td>
</tr>
 <tr>
		<td class="bwborder" >
		<fieldset>
		 <legend  ><B>Uploading Images Section</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2"   border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >


												<tr>
													<td class="textborder" width="100">
														Upload&nbsp;QC&nbsp;Certificate<font color="#FF6666">*</font>
													</td>
													
							
		
													<td ><html:file property="qcImg"
															styleClass="mytext" style="width:150px"
															onchange="javascript:rest();javascript:ValidateFileUpload();" /></td>
		<%String ndx=""; %>
		<logic:equal name="QualityControlBean"  property="qcImgAvailble"  value="Y">
		<td style="padding-right: 120px;"><a href="#" onclick='<%= "openFile(" + ndx + ")" %>'>View</a></td>
		</logic:equal>
													
													<td class="textborder" width="100">
														Upload&nbsp;TPT&nbsp;Report<font color="#FF6666">*</font>
													</td>
													
													<td><html:file property="tptImg"
															styleClass="mytext" style="width:150px"
															onchange="javascript:rest();javascript:ValidateFileUpload();" /></td> 
													<logic:equal name="QualityControlBean"  property="tptImgAvailble"  value="Y">
													<td><a href="#" onclick='<%= "openFile1(" + ndx + ")" %>'>View</a></td>

</logic:equal>
                                                         <td style="padding-left: 30px;"><input type="button" value="Update Details" onclick="updateDetails()" ></td>


												</tr>
	


		</table>
</label>
</fieldset>
</td>
</tr> 

</table>
</body>
</html:form>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="960"/>
</jsp:include>
<%@ include file="/commons/rws_alert.jsp"%>