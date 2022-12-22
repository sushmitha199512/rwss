<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%

int count = 1;
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();

String md=request.getParameter("mode");
String md1=request.getParameter("mode1");
String releaseDate=request.getParameter("releaseDate");
if(releaseDate==null){
releaseDate=RwsUtils.getCurrentDate("dd-MMM-yyyy");
}


%>
<meta http-equiv="X-UA-Compatible" content="IE=8, IE=9, chrome=1"/>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
<script  language="javascript" >

function getDivisions()
	{

	 document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=Divisions";
		document.forms[0].submit();
	
	}
function getWorkcategory()
	{
	  document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=workcategory";
	  monitoringForm.submit();
	}
function getSubDivisions()
	{
	
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data";
		monitoringForm.submit();
	}

function getWorks1()
{
	
	document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=getworks";
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
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=getCancelWorks";
		document.forms[0].submit();		
		}

}

function checkAmount(value){
	value=value-1;

if(document.forms[0].elements["refundForm["+value+"].refundAmount"].value==""){
document.forms[0].elements["refundForm["+value+"].refundAmount"].value="0";
return;
}

var refundAmount=parseInt(document.forms[0].elements["refundForm["+value+"].refundAmount"].value);
var releaseAmount=parseInt(document.forms[0].elements["refundForm["+value+"].releaseAmount"].value);

if(refundAmount>releaseAmount){
alert("Please Make Sure Refund Amount Should be less then Or Eqaul to Release Amount");
document.forms[0].elements["refundForm["+value+"].refundAmount"].value="0";
return false;
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
	 
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=getWorks";
		document.forms[0].submit();	
		}
	}

function getWorks1()
	{
	   
	   	 	  if(document.forms[0].circleCode.value==''){
	  alert("Please Select Circle Code");
		return false;
	  }
	  else if(document.forms[0].cmbDivision.value==''){
	  alert("Please Select Division Code");
		return false;
	  }
	 
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=getWorks1";
		document.forms[0].submit();	
		}
	}



function getFinancialYears()
{

	   	 	  if(document.forms[0].circleCode.value==''){
	  alert("Please Select Circle Code");
		return false;
	  }
	  else if(document.forms[0].cmbDivision.value==''){
	  alert("Please Select Division Code");
		return false;
	  }
	 
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=finYears";
		document.forms[0].submit();	
		}

}

function getReleaseDates()
	{
	   
	   	 	  if(document.forms[0].circleCode.value==''){
	  alert("Please Select Circle Code");
		return false;
	  }
	  else if(document.forms[0].cmbDivision.value==''){
	  alert("Please Select Division Code");
		return false;
	  }
	 
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=releaseDates";
		document.forms[0].submit();	
		}
	}


function fnSave(count)
{

	  var flag=false;var i=0;
 for(i=1;i<count;i++){
if(document.forms[0].elements['check'+i].checked==true){

if(document.forms[0].elements['refundForm['+(i-1)+'].refundAmount'].value =='0'){
   alert("Please Enter Refund Amount for Selected Works");
return;
}
if(document.forms[0].elements['refundForm['+(i-1)+'].chequeNo'].value ==''){
   alert("Please Enter cheque Number for Selected Works");
return;
}
if(document.forms[0].elements['refundForm['+(i-1)+'].chequeDate'].value ==''){
	   alert("Please Enter cheque Date for Selected Works");
	return;
}

flag=true;
break;
}
}

if(!flag){
	alert("Please Select Work");
return;
}
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=save";
               document.forms[0].submit();
}

function fnforwardToENC(count)
{
    
   	  var flag=false;var i=0;
 for(i=1;i<count;i++){

if(document.forms[0].elements['check'+i].checked==true){
flag=true;
break;
}
}

if(!flag){
	alert("Please Select Work");
return;
}
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=forwardenc";
               document.forms[0].submit();
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
		  document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=data&mode1=DeleteWorks";
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
	var url = "switch.do?prefix=/works&page=/SpillWorkReleases.do&mode=showHabs&workID="+workId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
</script>

</head>

<html:form action="SpillWorkReleases.do">
<body>

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<table width="100%">
<tr><td align=right><a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>

</td></tr>
</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Spill Refunds" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Office Details</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2" border="0"
				bordercolor="#8A9FCD" style="border-collapse:collapse;" >
	
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
						<td class="textborder">Circle<span class="mandatory">*</span></td>
						<td class="textborder"><html:select property="circleCode"
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getDivisions();">
							<html:option value="">
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
								style="width:100px" /> <html:hidden property="circleOfficeCode"
								name="RWS_USER" /></td>
						</logic:present>
					</logic:present>
				</logic:present>
				<%if(divusercode.equals("0")){%>
				<td><bean:message key="app.division" /><span class="mandatory">*</span></td>
				<td><html:select property="cmbDivision" style="width:183px"
					styleClass="mycombo" >
					<html:option value="">Select...</html:option>
					<logic:present name="divisions">
						<html:options collection="divisions" name="division"
							property="value" labelProperty="label" />
					</logic:present>

				</html:select></td>
				<%} else{%>
				<td><bean:message key="app.division" /><span class="mandatory">*</span></td>
				<td><html:select property="cmbDivision" style="width:183px"
					styleClass="mycombo" >
					<html:option value='<%=divusercode%>'>
						<%=divusername%>
					</html:option>
				</html:select> <%} %>






<logic:present name="programs">
						<td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Programs</td>
						<td class="textborder"><html:select property="programCode"
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getWorks1();">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="programs" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present>


</tr>
	</table>
	</label>
	</fieldset>

	</td>

	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="100%" border=1
		style="border-collapse:collapse">
		<tr bgcolor="#8A9FCD">
			<td class="bwborder" colspan="14"><B><font color="#FFFFFF">Spill Works For
			Refund</B></td>
			<td align="center"></td>
		</tr>
		<tr>
			<td class="clrborder" align="center">S.No.</td>
			<td class="clrborder" align="center">Work Name</td>
			<td class="clrborder" align="center">Work ID</td>
			<td class="clrborder" align="center">Program</td>
			<td class="clrborder" align="center">SubProgram</td>
			<td class="clrborder" align="center">Sanction Date</td>
			<td class="clrborder" align="center">Sanction&nbsp;Amount<br>
			(in lakhs)</td>
	<td class="clrborder" align="center">Release&nbsp;Amount<br>
			(in Rupees)</td>
<td class="clrborder" align="center"><span class="mandatory">*</span>So Far Refund Amount (In Rupees)</td>
			<td class="clrborder" align="center"><span class="mandatory">*</span>Refund Amount (In Rupees)</td>

			<td class="clrborder" align="center"><span class="mandatory">*</span>Cheque No</td>
			<td class="clrborder" align="left" width="10%" ><span class="mandatory">*</span>Cheque Date</td>

			<td class="clrborder" align="center">Remarks</td>
<td class="clrborder" align="center">Select</td>

		</tr>


		<nested:iterate id="refundForm" property="refundWorks"
			indexId="ndx">


<nested:equal name="refundForm" property="checks" value="on">
<!-- some action -->
	<tr align="left" bgcolor="#E3E4FA">
</nested:equal>

<nested:notEqual name="refundForm" property="checks" value="on">
<!-- some other action -->
	<tr align="left" onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
</nested:notEqual>
		
				<td class="bwborder"><%=count++%></td>

				<td class="bwborder"><bean:write name="refundForm"
					property="work_name" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="work_id" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="programme_name" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="subProgramme_name" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="sanctionDate" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="sanctionAmoount" /></td>
<td class="bwborder"><nested:text  name="refundForm" indexed="true"  style="width: 0px" property="releaseAmount" disabled="true" /><bean:write name="refundForm"
					property="releaseAmount" /></td>
<td class="bwborder"><bean:write name="refundForm"
					property="soFarRefundAmount" /></td>
<td class="bwborder">
<nested:text name="refundForm" property="refundAmount" indexed="true"  style="width: 120px"  onblur='<%="return checkAmount("+(count-1)+")"%>'   onkeypress="return decimalsOnly(event)"/>
</td>
	
<td>
   <nested:text name="refundForm" property="chequeNo" indexed="true"  style="width: 120px"  />
</td>

<td><html:text name="refundForm" property="chequeDate"  indexed="true"  onkeypress="return decimalsOnly(event)" style="width: 70px" />
		<a href="javascript:NewCal('refundForm[<%=count-2 %>].chequeDate','DDMMYYYY')">
        
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>


<td class="bwborder"><nested:textarea name="refundForm" property="remarks" indexed="true"  style="width: 120px"  /></td>

<td>
<nested:equal name="refundForm" property="checks" value="on">
<!-- some action -->
<input type=checkbox name=check<%=count-1%>  checked value='<bean:write name="refundForm" property="work_id" />' >
</nested:equal>

<nested:notEqual name="refundForm" property="checks" value="on">
<!-- some other action -->
<input type=checkbox name=check<%=count-1%>   value='<bean:write name="refundForm" property="work_id" />' >
</nested:notEqual>
</td>

			</tr>
			</nested:iterate>

		<%if(count==1)
{ %>
		<tr>
			<td colspan="14" align="center" class="btext">No Records</td>
		</tr>
		<%}
	else
	{
		
		%>
		<tr>
			<td colspan="11" align="center"><input type="button" value="Save"
				onClick="fnSave(<%=count %>);">&nbsp;&nbsp;&nbsp;<input type="button" value="Forward To ENC"
				onClick="fnforwardToENC(<%=count %>);"></td>
		</tr>
		<%
	
	
}
%>
<input type="hidden" name="resultCount" value="<%=count%>">
<html:hidden property="deldate" value='<%=transdate%>'/>
</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
<br>
<br>
<table align=left><tr><td><font color="red">Note:</font></td><td>1.Please Select the Work before saving.</td></tr>
<tr><td><font color="red" colspan=1></font></td><td>2.After Saving then you can forward to ENC.</td></tr>
</table>
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


	
	
