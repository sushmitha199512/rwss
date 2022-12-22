<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%int count = 1;
	nic.watersoft.commons.RwsUser rwsusers=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String rwsuserid = users.getUserId();

String md=request.getParameter("mode");
String md1=request.getParameter("mode1");


%>
<head>

<script>
function openFile(index){

	//var bslno=document.getElementById("VOUCHER_LIST["+index+"].billSlNo").value;
	//var bslno=document.forms[0].elements["VOUCHER_LIST["+index+"].billSlNo"].value;
	//var billdates=document.forms[0].elements["VOUCHER_LIST["+index+"].billDate"].value;
	//var type="qc";
	//alert("andhra pradesh");
	var work_id=document.getElementById('workId').value;
	if(parseInt(work_id)>0)
		{
		
		}
	var url="./switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=showQcCertificate&workId="+document.forms[0].workId.value;

	  // document.forms[0].action="switch.do?prefix=/works&page=/QC.do&mode=data&mode1=updatedetails";
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
	//agency
	var engineer_assn=document.getElementById('agency').value;
	//var engineer_assn1=document.getElementById('engineerAssign1').value;
	//var engineer_assn2=document.getElementById('engineerAssign2').value;
	//var agencyName=document.getElementById('agencyName').value;
	//alert("*******"+engineer_assn);
	 var work_id=document.getElementById('workId').value;
	 
	 var issueDate=document.getElementById('issueDate').value;
	 var certDate=document.getElementById('certDate').value;
	 
	//alert("*******"+issueDate);
	//alert("*******"+certDate);
	 var qcImg = document.getElementById('qcImg');
	 var FileUploadPath1 = qcImg.value;
	 
/* 	  var tptImg = document.getElementById('tptImg');
		var FileUploadPath2 = tptImg.value; */
		
		 
		
	  if(work_id==""){
	  alert("Please Select  Work ID");
		return;
	}
		 else   if(engineer_assn==""){
		  alert("Please Select Agency Name");
			return;
		}
		 /*else   if(engineer_assn1==""){
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
		} */
		
		
		/* else   if(agencyName==""){
			  alert("Please Enter AgencyName.");
				return;
			} */
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

/* else if (document.forms[0].tptImg.value == ""
|| document.forms[0].tptImg.value == "") {
alert("Please Upload TPT Report ");
return false;

}else if (!fileMimeType(FileUploadPath2)) {			
return false;
} */
 else{
 // alert("sssss");

//var ast= document.getElementById("astwork"+index).value;
//var atype=document.getElementById("assettype"+index).value;
 //alert(ast);
 // alert(atype);
  //document.forms[0].action="switch.do?prefix=/works&page=/QualityControl.do?mode=updatedetails";
  // document.forms[0].action="switch.do?prefix=/works&page=/QC.do&mode=updatedetails";
  document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=upddetails";
  document.forms[0].submit();
  }
}

function funcDistrictChanged() {
	var work_id=document.getElementById('workId').value;
	//alert(work_id);
	//document.forms[0].action = "/pred/masters/QC.do?mode=getDetails";
	document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=getDetails";
	document.forms[0].submit();
}

function getDivisions()
	{
	  document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=Divisions";
	  document.getElementById("workCat").selectedIndex = "0";
	  document.getElementById("agency").selectedIndex = "0";
	  monitoringForm.submit();
	}
function getWorkcategory()
	{
	  document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=workcategory";
	  document.getElementById("workCat").selectedIndex = "0";
		document.getElementById("program").selectedIndex = "0";
		document.getElementById("subprogram").selectedIndex = "0";
		document.getElementById("issueDate").value="";
		document.getElementById("certdate").value="";
	  monitoringForm.submit();
	}
function getSubDivisions()
	{
		document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=subDivisions";
		monitoringForm.submit();
	}
function getProgramme()
{

	document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=programmes";
	monitoringForm.submit();
	
}
function getSubProgramme()
{
	
	document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=subprogrammes";
	monitoringForm.submit();
	
}
function getWorks1()
{
	
	document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=getworks";
	monitoringForm.submit();
	
}

function getCancelWorks()
{
     	    
	  if(document.forms[0].circleCode.value==''){
	  alert("Please Select Circle Code");
		return false;
      }
	  else if(document.forms[0].cmbDivision.value==''){
	  alert("Please Select Division Code");
		return false;
      }
	 else if(document.forms[0].workCat.value==''){
	  alert("Please Select WorkCategory ");
		return false;
      } else if(document.forms[0].plan[0].checked==false && document.forms[0].plan[1].checked==false){
	  alert("Please Check Plan / Non Plan ");
		return false;
   	  } 
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=getCancelWorks";
		document.forms[0].submit();		
		}

}

function getWorks()
	{
    
	  if(document.forms[0].circleCode.value==''){
	  alert("Please Select Circle Code");
		return false;
	  }
	  else if(document.forms[0].cmbDivision.value==''){
	  alert("Please Select Division Code");
		return false;
	  }
	 else if(document.forms[0].workCat.value==''){
	  alert("Please Select WorkCategory ");
		return false;
	  } else if(document.forms[0].plan[0].checked==false && document.forms[0].plan[1].checked==false){
	  alert("Please Check Plan / Non Plan ");
		return false;
	  } 
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=getWorks";
		document.forms[0].submit();		
		}
	}
function fnchkdelete(){

     var len=document.monitoringForm.elements.length;
	
      var yes=0;
      
      for( var i=1;i<len;i++)
	  {       
        if(document.monitoringForm.elements[i].name.substring(0,5)=="check")
         
			if(document.monitoringForm.elements[i].checked == false)
		    { 
		       yes=1; 
		      
		     }
		    else if(document.monitoringForm.elements[i].checked==true)
		        { 
		      
		        yes=0;
		        break; 
		        }
		 
      }

	  if(yes==1)
	   {
		 alert("TO DELETE WORKS SELECT CHECK BOXES");
		
       }
	  else if(yes==0){
	
		  var val=confirm("Are You Sure To Delete The Checked Work(S)");
		  if(val){
		  document.forms[0].action="switch.do?prefix=/works&page=/TPQC.do&mode=data&mode1=DeleteWorks";
          document.forms[0].submit();
	}
          
}
}
function checkMe()
 {
    
 if(document.forms[0].plan[0].checked)
 {
	
 }
 else if(document.forms[0].plan[1].checked)
 {
 }
 else
 {
 document.forms[0].plan[0].checked=true;
 document.forms[0].wrktype[0].checked=true;
 }
 }
 function fnShowHabs(workid)
{
	var workId=workid.name;
	var url = "switch.do?prefix=/works&page=/TPQC.do&mode=showHabs&workID="+workId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
</script>
</head>

<html:form action="TPQC.do" method="post" enctype="multipart/form-data">
<body onload="checkMe()">
<%-- <table width="100%">
<tr><td align=right><a href="switch.do?prefix=/works&page=/TPQC.do">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table> --%>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Third Party Quality Control Entry Form " />
	<jsp:param name="TWidth" value="870" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" value="700" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend><B>Office Details</B></legend>
		<label>
		
<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tbody class="formTBody">
	  
  <tr class="textborder">	
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
				<td class="textborder" >Circle<span class="mandatory">*</span></td>
				<td class="textborder">
		        <html:select property="circleCode" style="width:143px" styleClass="mycombo" onchange="javascript:getDivisions();" >
	            <html:option value="-1"><font class="myfontclr1">Select...</html:option>
	            <html:options collection="circles"   property="value" labelProperty="label"/>
	             </html:select>
				</td>
			</logic:notPresent>
		    <logic:present name="qccircles">
		    
			<td class="textborder">Circle<span class="mandatory">*</span></td>
				 <logic:present name="RWS_USER" property="circleOfficeName">
				 <html:hidden property="circleCode"/>
			 	<td class="textborder">
				<html:text property="circleOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			</logic:present>
			</logic:present>
			<%if(divusercode.equals("0")){%>
		  <td ><bean:message key="app.division" /><span class="mandatory">*</span></td>
		   <td ><html:select property="cmbDivision" style="width:183px" styleClass="mycombo" onchange="Javascript:getSubDivisions();" >
			<html:option value="-1">Select...</html:option>
			<logic:present name="divisions"> 
				<html:options collection="divisions" name="division" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
		</td>
          <%} else{%>
		  <td ><bean:message key="app.division" /><span class="mandatory">*</span></td>
		   <td ><html:select property="cmbDivision" style="width:183px" styleClass="mycombo" onchange="Javascript:getSubDivisions();" >
		   <%-- <html:option value='<%=divusercode%>'><%=divusername%></html:option> --%>
		   <html:option value="0">Select...</html:option>
		   <logic:present name="QCdivisions"> 
				<html:options collection="QCdivisions" name="division" property="value" labelProperty="label" />
		   </logic:present>
           </html:select>
          <%} %>
<!-- 12082021 -->	
			<logic:present name="subdivisions" >
				 	<td class="textborder">SubDivision<span class="mandatory">*</span></td>
						<td class="textborder">
						<html:select property="subdivisioncode" style="width:143px" styleClass="mycombo" onchange="javascript:getWorkcategory();" >
			            <html:option value="-1"><font class="myfontclr1">Select...</html:option>
			            <html:options collection="subdivisions"   property="value" labelProperty="label" />
			            </html:select>
					</td>
			</logic:present>
			<logic:notPresent name="subdivisions">
				<td class="textborder">SubDivision<span class="mandatory">*</span></td>
					<td class="textborder">
				        <html:select property="subdivisioncode" style="width:143px" styleClass="mycombo"  onchange="javascript:getWorkcategory();">
			            	<html:option value="-1"><font class="myfontclr1">Select...</html:option>
			        	</html:select>
				</td>
			</logic:notPresent>
			</td>
<!-- 12082021 -->
		 <tr>
		<td class="textborder" colspan="4" nowrap>
		<html:radio property="plan" value="1" onclick="checkMe();getProgramme();"/>Plan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:radio property="plan" value="2" onclick="checkMe();getProgramme();"/>Non Plan
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <html:radio property="wrktype" value="1" onclick="JavaScript:getProgramme();">MainScheme</html:radio>
        <html:radio property="wrktype" value="2" onclick="JavaScript:getProgramme();">Augmentation</html:radio>
        <html:radio property="wrktype" value="3" onclick="JavaScript:getProgramme();">Maintenance</html:radio>
		</td>
		<td class="textborder" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Work Category<span class="mandatory">*</span></td>
		<td>
		<html:select property="workCat" style="width:143px" styleClass="mycombo" onchange="getProgramme();">
		<html:option value="-1">Select...</html:option>
		<logic:present name="workCategory">
		<html:options collection="workCategory" property="value" labelProperty="label"/>
		</logic:present>
		</html:select>
		</td>
		</tr>
	
	<tr>
	<td>Programme</td>
        <td>
		     <html:select property="program" style="width:183px" styleClass="mycombo" onchange="JavaScript:getSubProgramme();">
			<html:option value="-1">Select...</html:option>
			<logic:present name="programmes"> 
			<html:options collection="programmes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
	    <td>SubProgramme</td>
        <td>
		     <html:select property="subprogram" style="width:183px" styleClass="mycombo" onchange="JavaScript:getWorks1();">
			<html:option value="-1">Select...</html:option>
			<logic:present name="subprogrammes"> 
			<html:options collection="subprogrammes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
	  <%-- <%if(!subusercode.equals("00")){ %>
			<td  ><input type=submit name=GetData value=GetRegularWorks onClick="return getWorks();" disabled></td> 
			<td  ><input type=submit name=GetData value=GetCancelWorks onClick="return getCancelWorks();" disabled ></td> 
			<%} else if(subusercode.equals("00")){%>
			<td  ><input type=submit name=GetData value=GetRegularWorks  onClick="return getWorks();" ></td> 
			<td  ><input type=submit name=GetData value=GetCancelWorks onClick="return getCancelWorks();" ></td> 
			<%} %> --%>
		
	 </tr>
	 <%-- <tr >
		<logic:present name="works">
		 <td><bean:message key="app.work" /><span class="mandatory">*</span></td>
		
		<td  colspan=3><html:select property="cmbWorks" style="width:490px" styleClass="mycombo" onchange="JavaScript:init();fnWorks();">
		 	<html:option value="">Select...</html:option>
			<html:options collection="works"  property="workid" labelProperty="workname" />
			</html:select>
			
		</td>
		</logic:present>
	    </tr> --%>
	    <tr class="textborder">
			<logic:present name="rwsWorks">			 
				<td class="textborder">Work<span class="mandatory">*</span></td>
				<td class="textborder" colspan="6"  >
		        <html:select property="workId" style="width:643px" styleClass="mycombo" onchange="javascript: funcDistrictChanged()" >
	            <html:option value="-1"><font class="myfontclr1">Select...</html:option>
	            <html:options collection="rwsWorks"   property="workId" labelProperty="workName" />
	            </html:select>
				</td>
			</logic:present>
			<logic:notPresent name="rwsWorks">
				<td class="textborder" >Work<span class="mandatory">*</span></td>
				<td class="textborder" colspan="4">
		        <html:select property="workId" style="width:527px" styleClass="mycombo"  >
	            	<html:option value="-1"><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
			</logic:notPresent>
				</tr>
		</table>
		</label>
		</fieldset>				
			</td>
		<tr>
		<td class="bwborder">
		<fieldset>
		 <legend><B>Agency Section</B></legend> 
		<label>
			<table cellpadding="0" cellspacing="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >

		<tr>
													<%-- <td class="textborder" align="left" >Agency Name <span
														class="mandatory">*</span> &nbsp;&nbsp; <html:text property="agencyName" style="width:240px"
															maxlength="30" onkeypress="return textOnly()" />
													</td> --%>
													
												</tr>
												<tr>
		
		<td class="textborder" align="right">Agency Name<font color="#FF6666">*</font><html:select property="agency" style="width: 400px" styleClass="mycombo" >
			<html:option value="-1"><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="agency">
				<html:options collection="agency" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr>

<%-- <tr>
		
		<td class="textborder" align="right">Name of the AE Inspected<font color="#FF6666">*</font><html:select property="engineerAssign" style="width: 400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr>
		<tr>
		<td class="textborder" align="right">Name of the DEE Inspected<font color="#FF6666">*</font><html:select property="engineerAssign1" style="width: 400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr>
		<tr>
		<td class="textborder" align="right">Name of the EE Inspected<font color="#FF6666">*</font><html:select property="engineerAssign2" style="width:400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr><tr>
		<td class="textborder" align="right">Name of the SE Inspected<font color="#FF6666">*</font><html:select property="engineerAssign3" style="width: 400px" styleClass="mycombo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="engAssignedBy">
				<html:options collection="engAssignedBy" property="value" labelProperty="label" />
			</logic:present>
		</html:select></td>
		</tr> --%>
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
		<logic:equal name="monitoringForm"  property="qcImgAvailble"  value="Y">
		<td style="padding-right: 120px;"><a href="#" onclick='<%= "openFile(" + ndx + ")" %>'>View</a></td>
		</logic:equal>
													
													<%-- <td class="textborder" width="100">
														Upload&nbsp;TPT&nbsp;Report<font color="#FF6666">*</font>
													</td>
													
													<td><html:file property="tptImg"
															styleClass="mytext" style="width:150px"
															onchange="javascript:rest();javascript:ValidateFileUpload();" /></td> 
													<logic:equal name="QualityControlBean"  property="tptImgAvailble"  value="Y">
													<td><a href="#" onclick='<%= "openFile1(" + ndx + ")" %>'>View</a></td> 

</logic:equal>--%>
                                                         <!-- <td style="padding-left: 30px;"><input type="button" value="Update Details" onclick="updateDetails()" ></td> -->
                                                         <td style="padding-left: 30px;"><input type="button" value="Update Details" onclick="updateDetails()" ></td>
                                                     <%
								String csrfToken = "";
								nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
								csrfToken = valUtil.getCSRFCode();
								session.setAttribute("csrfToken", csrfToken);
							%>
							<html:hidden property="token" styleClass="mytext"	value="${sessionScope.csrfToken}" />

												</tr>
	


		</table>
</label>
</fieldset>
</td>
</tr> 
				
				
				
				
				
				
				
				
				
				

<!-- <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="10"><B><font color="#FFFFFF">Works For Deletion</B></td>
<td align="center">
</td>
</tr> -->
<%-- <tr >
	<td class="clrborder" align="center">S.No.</td>
	<td class="clrborder" align="center">Work Name</td>	  
	<td class="clrborder" align="center">Work ID</td>
	<td class="clrborder" align="center">Program Name</td>
	<td class="clrborder" align="center">SubProgram Name</td>
	<td class="clrborder" align="center">Sanction No</td>
	<td class="clrborder" align="center">Sanction date</td>
	<td class="clrborder" align="center">Sanction&nbsp;Amount<br>(in lakhs)</td>
	<td class="clrborder" align="center">No of Habitations</td>
	<%if(md1!=null && !md1.equals("") && md1.equals("getCancelWorks")){%>
	<td class="clrborder" align="center">Work Cancel Date</td>
	<%}%>
	<td class="clrborder" align="center">Check</td>
	</tr> --%>
	
	
<%-- <nested:iterate id="WORKS_DELETES" property="worksforDelete" indexId="ndx">
<tr align="left" >
<td class="bwborder"><%=count++%></td>

<td class="bwborder"><bean:write name="WORKS_DELETES" property="workname" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="workid" /></td>
<td class="bwborder"><bean:write name="WORKS_DELETES" property="progName" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="subprogName" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="sanctionno" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="sanctiondt" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETES" property="sanctionamount" /></td>
<td  class="bwborder" align="right" ><bean:write name="WORKS_DELETES" property="noofhabs" />
		&nbsp;<input type="button" value="..." title="Show Selected Habs"  class="btext" 
			name="<bean:write name="WORKS_DELETES" property="workid" />" onclick="javascript:fnShowHabs(this)">
	</td>
<%if(md1!=null && !md1.equals("") && md1.equals("getCancelWorks")){%>
<td class="bwborder" align=center><bean:write name="WORKS_DELETES" property="wrkCanDate" /></td>
<%}%>
<td class="bwborder" align=center><input type=checkbox name=check<%=count%> value='<bean:write name="WORKS_DELETES" property="workid" />' ></td>

</tr>
</nested:iterate> --%>

<%-- <%if(count==1)
{ %>
<tr><td colspan="11" align="center" class="btext">No Records</td></tr>
<%}
	else
	{
		if(subusercode.equals("00"))
		{
		%>
			<tr><td colspan="11" align="center" ><input type=button value=Delete onClick="fnchkdelete();" ></td></tr>
		<%
		}
		else 
		{
	%>
			<tr><td colspan="11" align="center" ><input type=button value=Delete onClick="fnchkdelete();" disabled></td></tr>
		<%
		}
	}
%> --%>
<%-- <input type="hidden" name="resultCount" value="<%=count%>">
<html:hidden property="deldate" value='<%=transdate%>'/>
</table> --%>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="870"/>
</jsp:include>
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>