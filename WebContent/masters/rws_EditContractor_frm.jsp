<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--


function ajaxFunction_ifsc()
{ 
 //document.getElementById('content').style.display='block';

contractorForm.bankName.value="";
           contractorForm.branchName.value="";
           contractorForm.branchAddress.value="";
  var ifsc=contractorForm.ifscCode.value;
  if(ifsc==null || ifsc=="" ){
		alert("Please Enter IFSC Code");
       
	return;
}else if(ifsc.length!=11) {
		alert("IFSC Code Length Should Be 11. ");
	return;

}else{
  
}
   var URL="rws_getbank_details_ifsc.jsp?ifsc="+ifsc.toUpperCase();

 //alert("URL:"+URL);
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {

  
		var resp = xmlHttp.responseText;

     	resp = resp.replace(/^\s*|\s*$/g,'');
		if(resp==null || resp=="" || resp.length==0)
		{
			alert("Please Enter Valid IFSC CODE");
contractorForm.ifscCode.value="";
        }
		else
		{       
		 var mytool_array=resp.split("^");
           contractorForm.bankName.value=mytool_array[0];
           contractorForm.branchName.value=mytool_array[3];
           contractorForm.branchAddress.value=mytool_array[4];
    
        //document.getElementById('content').style.display='none';
		}
	
      
	  }
	  else{
  
		
	  }
	}
	xmlHttp.open("GET",URL,true);
	xmlHttp.send(null);  
}


function openWindow(fileName)
{
	var code=contractorForm.contractorCode.value;
	url = 'switch.do?prefix=/masters&page=/construct.jsp';
	window.open(url,"", "width=400,height=150,left=300,top=200,scrollbars=1");
}
function eoatWin()
{
	var code=contractorForm.contractorCode.value;
	
	url = 'switch.do?prefix=/masters&page=/Eoat_Det.jsp?code='+code;
	window.open(url,"", "width=400,height=150,left=300,top=200,scrollbars=1");
}
function getDateObject(dateString,dateSeperator)
{
	//This function return a date object after accepting 
	//a date string ans dateseparator as arguments
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	//extract day portion
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	// alert("cdate:"+cDate);
	//extract month portion				
	endPos=dateString.indexOf(sepChar,curPos+1);
	cMonth=dateString.substring(curPos+1,endPos);
    // alert("cMonth:"+cMonth);
	//extract year portion				
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	// alert("cYear:"+cYear);
	//Create Date Object
	dtObject=new Date(cYear,cMonth-1,cDate);	
	// alert(dtObject);
	return dtObject;
} 
function validateFormm()
{   
	//alert("hfgjfdhgj");
    var firstname=document.contractorForm.firstName.value;
	var panno =document.contractorForm.panNo.value;
	var voterid=document.contractorForm.voterId.value;
	var contractorRegno =document.contractorForm.contractorRegno.value;
    var val=document.contractorForm.email.value;
	var pattern = /^[a-zA-Z0-9\_\.]+\@[a-zA-Z\.]+\.([a-z]{2,4})$/;
    var ph=document.contractorForm.phone.value;
    var cell=document.contractorForm.mobile.value;
   	
	var dt1=getDateObject(document.contractorForm.registrationDate.value,"/");
	var dt2=getDateObject(document.contractorForm.validFrom.value,"/");
    var dt3= getDateObject(document.contractorForm.validTo.value,"/");
	//alert("rdate:"+dt1);
	//alert("vTo:"+dt3); 
   // alert(dt1 < dt2);
	if(firstname ==null || firstname == "")
	{ 
		alert("Please Enter FirstName");
		document.contractorForm.firstName.focus();
		return false;
	}
	if(panno=="" && voterid =="" && contractorRegno=="")
	{
		alert("Please Provide any one of the Below \n PanNo (or) Regn No. (or) VoterId")
		return false;				  
	}
	if(panno!="" || voterid !="" || contractorRegno !="")
	{
		if(panno!="" && panno.length!=10)
		{
			alert("Please Provide Valid Pan NO");
			document.contractorForm.panNo.focus();
			return false;
		}
		if(voterid!="" && voterid.length!=10)
		{
			alert("Please Provide Valid Voter ID");
			document.contractorForm.voterId.focus();
			return false;
		}
		if(contractorRegno!="" && contractorRegno.length!=4)
		{
			alert("Please Provide Valid Contractor Registraion No.");
			document.contractorForm.contractorRegno.focus();
			return false;
		}
    }
	if(document.forms[0].email.value!="")
	{
		if(!eMailCheck(document.forms[0].email.value))
		{
			document.forms[0].email.value = '';
			return false;
		}
	}

   if(document.forms[0].mobile.value=="")
	{	
        alert("Please Provide Mobile No.");
		return false;
	}

   if(document.forms[0].email.value=="")
	{	
        alert("Please Provide Email No.");
		return false;
	}

   if(document.forms[0].bankName.value=="")
	{	
        alert("Please Provide Bank Name.");
		return false;
	}

	if(document.forms[0].branchName.value=="")
		{	
	        alert("Please Provide Branch Name.");
			return false;
		}
	
	if(document.forms[0].ifscCode.value=="")
		{	
	        alert("Please Provide IFSC Code No.");
			return false;
		}
	
	if(document.forms[0].accountNo.value=="")
		{	
	        alert("Please Provide Account No.");
			return false;
		}


   if(dt1 > dt2)
   {
     alert(" Valid From date must be greater than or equal to Registration date"); 
     return false;
   }
   if(dt3 < dt2 ) 
	{
	  alert(" Valid To Date must be greater than or equal to Valid From date"); 
	  return false;
	}
   
	else
	{
      //alert("submission");
		return true;
	}
  }

//-->
function ajaxFunction_ifsc()
{ 
 //document.getElementById('content').style.display='block';

contractorForm.bankName.value="";
           contractorForm.branchName.value="";
           contractorForm.branchAddress.value="";
  var ifsc=contractorForm.ifscCode.value;
  if(ifsc==null || ifsc=="" ){
		alert("Please Enter IFSC Code");
       
	return;
}else if(ifsc.length!=11) {
		alert("IFSC Code Length Should Be 11. ");
	return;

}else{
  
}
   var URL="rws_getbank_details_ifsc.jsp?ifsc="+ifsc.toUpperCase();

 //alert("URL:"+URL);
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {

  
		var resp = xmlHttp.responseText;

     	resp = resp.replace(/^\s*|\s*$/g,'');
		if(resp==null || resp=="" || resp.length==0)
		{
			alert("Please Enter Valid IFSC CODE");
contractorForm.ifscCode.value="";
        }
		else
		{       
		 var mytool_array=resp.split("^");
           contractorForm.bankName.value=mytool_array[0];
           contractorForm.branchName.value=mytool_array[3];
           contractorForm.branchAddress.value=mytool_array[4];
    
        //document.getElementById('content').style.display='none';
		}
	
      
	  }
	  else{
  
		
	  }
	}
	xmlHttp.open("GET",URL,true);
	xmlHttp.send(null);  
}


function openWindow(fileName)
{
	var code=contractorForm.contractorCode.value;
	url = 'switch.do?prefix=/masters&page=/construct.jsp';
	window.open(url,"", "width=400,height=150,left=300,top=200,scrollbars=1");
}
function eoatWin()
{
	var code=contractorForm.contractorCode.value;
	
	url = 'switch.do?prefix=/masters&page=/Eoat_Det.jsp?code='+code;
	window.open(url,"", "width=400,height=150,left=300,top=200,scrollbars=1");
}
function getDateObject(dateString,dateSeperator)
{
	//This function return a date object after accepting 
	//a date string ans dateseparator as arguments
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	//extract day portion
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	// alert("cdate:"+cDate);
	//extract month portion				
	endPos=dateString.indexOf(sepChar,curPos+1);
	cMonth=dateString.substring(curPos+1,endPos);
    // alert("cMonth:"+cMonth);
	//extract year portion				
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	// alert("cYear:"+cYear);
	//Create Date Object
	dtObject=new Date(cYear,cMonth-1,cDate);	
	// alert(dtObject);
	return dtObject;
} 

function validateFormm()
{   
	//alert("hfgjfdhgj");
    var firstname = document.contractorForm.firstName.value;
    var cell = document.contractorForm.mobile.value;
    var e_Mail = document.contractorForm.email.value;
    var contractorRegno = document.contractorForm.contractorRegno.value;
	var panno = document.contractorForm.panNo.value;
	var voterid = document.contractorForm.voterId.value;    
    var adharno = document.contractorForm.adharNo.value;
	var ifsc_Code  = document.forms[0].ifscCode.value;
    var bank_Name = document.forms[0].bankName.value;
	var branch_Name = document.forms[0].branchName.value;
	var account_Number = document.forms[0].accountNo.value;
    var pattern = /^[a-zA-Z0-9\_\.]+\@[a-zA-Z\.]+\.([a-z]{2,4})$/;
    
	var dt1 = getDateObject(document.contractorForm.registrationDate.value,"/");
	var dt2 = getDateObject(document.contractorForm.validFrom.value,"/");
    var dt3 = getDateObject(document.contractorForm.validTo.value,"/");

    if(firstname == null || firstname == ""){ 
		alert("Please Enter FirstName");
		document.contractorForm.firstName.focus();
		return false;
	}
    if(cell == null || cell == ""){	
        alert("Please Provide Mobile Number Linked With Aadhaar Number.");
        document.contractorForm.mobile.focus();
		return false;
	}
	if(e_Mail == null || e_Mail == ""){	
        alert("Please Provide Email ID.");
        document.contractorForm.email.focus();
		return false;
	}
	if(contractorRegno == null || contractorRegno == ""){
		alert("Please Provide Regn. Number.");
		document.contractorForm.contractorRegno.focus();
		return false;				  
	}
	if(panno == null || panno == ""){
		alert("Please Provide PAN Number.");
		document.contractorForm.panNo.focus();
		return false;				  
	}
	if(voterid == null || voterid ==""){
		alert("Please Provide VoterId.");
		document.contractorForm.voterId.focus();
		return false;				  
	}
	if(adharno == null || adharno == ""){	
        alert("Please Provide Aadhaar Number.");
        document.contractorForm.adharNo.focus();
		return false;
	}
	if(ifsc_Code == null || ifsc_Code == ""){	
        alert("Please Provide IFSC Code.");
        document.contractorForm.ifscCode.focus();
		return false;
	}
	if(bank_Name == null || bank_Name == ""){	
        alert("Please Provide Bank Name.");
        document.contractorForm.bankName.focus();
		return false;
	}
	if(branch_Name == null || branch_Name == ""){	
        alert("Please Provide Branch Name.");
        document.contractorForm.branchName.focus();
		return false;
	}	
	if(account_Number == null || account_Number == ""){	
        alert("Please Provide Account Number.");
        document.contractorForm.accountNo.focus();
		return false;
	}
	if(cell != "" && cell.length != 10){	
        alert("Please Provide 10 Digit Valid Mobile Number.");
        document.contractorForm.mobile.focus();
		return false;
	}
	if(e_Mail != ""){
		if(!eMailCheck(e_Mail)){
			document.contractorForm.email.value = '';
			document.contractorForm.email.focus();
			return false;
		}
	}
	if(contractorRegno != "" && contractorRegno.length != 4){
		alert("Please Provide 4 Digit Valid Contractor Registraion Number.");
		document.contractorForm.contractorRegno.focus();
		return false;
	}
	if(panno != "" && panno.length != 10){
		alert("Please Provide Valid PAN Number");
		document.contractorForm.panNo.focus();
		return false;
	}
	if(voterid != "" && voterid.length != 10){
		alert("Please Provide Valid Voter ID");
		document.contractorForm.voterId.focus();
		return false;
	}
	if(adharno != "" && adharno.length != 12){	
        alert("Please Provide 12 Digit Valid  Aadhaar Number.");
        document.contractorForm.adharNo.focus();
		return false;
	}
   if(dt1 > dt2){
	     alert(" Valid From date must be greater than or equal to Registration date"); 
	     return false;
   }
   if(dt3 < dt2 ){
		  alert(" Valid To Date must be greater than or equal to Valid From date"); 
		  return false;
	}
	else{
	      	return true;
		}
  }
  

function autocompletion()
{
  // alert("auto comp");
 for (i=0; i<document.forms.length; i++) {
    document.forms[i].setAttribute("AutoComplete","off");
   }
}
</script>
<style>
.btext1
{
	border-width:1;
	border-color:#000000;
	color:#660099;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}
.btext2
{
	text-transform:uppercase;
	color:green;
	
}
.btext3
{
	
	color:red;
font-weight:bold;
	
}
</style>

<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="/Contractor.do?mode=edit">

<%
			String csrfToken = "";
					nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
					csrfToken = valUtil.getCSRFCode();
					session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Contractor Entry Form" />
	<jsp:param name="TWidth" value="855px" />
</jsp:include>
	<body onload="autocompletion()"> 
<table   bgcolor="#FFFFE0" bordercolor= "#8A9FCD" rules="cols"  border=1  style="border-collapse:collapse;" width="725" align="center">
<tr>
<td class="mycborder">
<table cellpadding="1" border="0"  bordercolor= "#8A9FCD" style="border-collapse:collapse;">
<tr>
	<td class="btext1"><font color="#FF6666">*</font>FirstName:</td>
<td><html:text property="firstName"  styleClass="mytext1"  size="25" tabindex="0" maxlength="25" onkeypress="return textOnly1(event)" /></td>
<td class="btext1"><font color="#FF6666"></font>&nbsp;&nbsp;MiddleName:</td>
<td><html:text property="middleName"  styleClass="mytext1"  size="25" tabindex="3" maxlength="25" onkeypress="return textOnly1(event)" /></td>
<td class="btext1"><font color="#FF6666"></font>&nbsp;&nbsp;LastName:</td>
	<td><html:text property="lastName"  styleClass="mytext1"  size="25" tabindex="4" maxlength="25" onkeypress="return textOnly1(event)" /></td>

</tr>
<tr>
<td class="btext1">&nbsp;Code:</td>
	<td><html:text property="contractorCode" styleClass="btext3" value="<%=(String)request.getAttribute(\"code\")%>" size="5" tabindex="1" readonly="true"/></td>
	
	<td class="btext1">&nbsp;Class:</td>
	<td><html:select property="contractorClass" styleClass="mytext1" tabindex="3" style="width:100px">
		<html:option value="">SELECT...</html:option>
		<html:option value="1">SuperClass</html:option>
		<html:option value="2">I</html:option>
		<html:option value="3">II</html:option>
		<html:option value="4">III</html:option>
		<html:option value="5">IV</html:option>
		</html:select>
	</td>
	<td class="btext1">&nbsp;Rating:</td>
	<td><html:select property="contractorRating" styleClass="mytext1" tabindex="4" >
		<html:option value="">SELECT...</html:option>
		<html:option value="A">Active</html:option>
		<html:option value="B">Black-Listed</html:option>
		</html:select>
	</td>
	
</tr>
</table>
<table border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" width="625">
<tr>
<td>
<table><tr>
<td class="btext1"> <font color="maroon"> <b>Contractor Contact Details:</b></font></td></tr>
<tr><td>
<table cellspacing="0" cellpadding="0">

<tr>
	<td class="btext1">HNo:/Street:</td>
	<td><html:text property="street"  styleClass="mytext1" tabindex="5" size="20"  onkeypress="upperOnly()"/></td>
	<td class="btext1">Phone:</td>
	<td><html:text property="phone"  styleClass="mytext1" tabindex="9" size="20" maxlength="20"  onkeypress="return numeralsOnly(event)" /></td>

</tr><tr>
	<td class="btext1">Area:</td>
	<td><html:text property="area"  styleClass="mytext1" tabindex="6" size="20" onkeypress="upperOnly()"/></td>
	<td nowrap class="btext1">&nbsp;Cell No:<font color="#FF6666">*</font></td>
	<td><html:text property="mobile"  styleClass="mytext1" tabindex="10" size="20" maxlength="10" onkeypress="return numeralsOnly(event)" /></td>
	
</tr>
<tr>
	<td class="btext1">City:</td>
	<td><html:text property="city"  styleClass="mytext1" tabindex="7" size="20" onkeypress="upperOnly()"/></td>	
	<td class="btext1">&nbsp;Fax:</td>
	<td><html:text property="fax"  styleClass="mytext1" tabindex="11" size="20" onkeypress="upperOnly()" /></td>
	
</tr>
<tr>
	<td class="btext1">&nbsp;PinCode:</td>
	<td><html:text property="pin"  styleClass="mytext1" tabindex="8" size="6" maxlength="6" onkeypress="return numeralsOnly(event)" /></td>
</TR>
<TR>
	<td class="btext1">&nbsp;Email<font color="#FF6666">*</font></td>
	<td colspan="2"><html:text property="email"  styleClass="mytext1" tabindex="12" size="40" /></td>
	
</tr>
</table>
</td>
</tr></table>
</td>
<td>
<table>
<tr><td class="btext1"><font color="maroon"> <b>Registration Details:</b></font></td></tr>
<tr><td>
<table cellspacing="0" cellpadding="0">
<tr>
	<td class="btext1">Regn No:<font color="#FF6666">*</font></td>
	<td><html:text property="contractorRegno"  styleClass="mytext1" tabindex="13" size="12" maxlength="4"  onkeypress="return checkSpaceAndSpecial(event)"/></td>
	</tr>
	<tr>
	<td nowrap class="btext1">Registered At:</td>
	<td><html:text property="registerAt"  styleClass="mytext1" tabindex="14" size="12" onkeypress="upperOnly()" /></td>
	</tr>
	<tr>
	<td nowrap class="btext1">Registration Dt:</td>
	<td><html:text property="registrationDate"  styleClass="mytext1" tabindex="15" size="8" /><a href="javascript: showCalendar(document.contractorForm.registrationDate);"></font><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="30" border="0" height="19" align="absmiddle"></a></td>
   </tr>
	<tr><td class="btext1">&nbsp;Validity From:</td>
	<td><html:text property="validFrom" value="" styleClass="mytext1" tabindex="16" size="8" /><a href="javascript: showCalendar(document.contractorForm.validFrom);"></font><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="30" border="0" height="19" align="absmiddle"></td>
    </tr>
	<tr><td class="btext1">&nbsp;Validity To:</td>
	<td colspan=2><html:text property="validTo" styleClass="mytext1" tabindex="17" size="8" /><a href="javascript: showCalendarFuture(document.contractorForm.validTo);"></font><img src="<rws:context page='/images/calendar.gif'/>" width="30" height="19" border="0" alt="" align="absmiddle"/></td>
    </tr>
  
	
	</table>
	</td></tr></table>
	</td><td>
	<table>
	<tr><td class="btext1"><font color="maroon"> <b>Other Details:</b></font></td></tr>
	<tr><td>
	<table>
<tr>
	<td class="btext1">PAN No:<font color="#FF6666">*</font></td>
	<td><html:text property="panNo" value="" styleClass="mytext1" tabindex="18" size="12" maxlength="10" onkeypress="return checkSpaceAndSpecial(event)"/></td></tr>
	<tr><td class="btext1">TIN No:</td>
<td><html:text property="tinNo" value="" styleClass="mytext1" tabindex="19" size="12" /></td>
</tr>
<tr><td class="btext1">Voter ID:<font color="#FF6666">*</font></td>
	<td><html:text property="voterId" value="" styleClass="mytext1" tabindex="18" size="12" maxlength="10" onkeypress="return checkSpaceAndSpecial(event)"/></td></tr>
	<tr><td nowrap class="btext1">VAT/CST No:</td>
	<td><html:text property="vatNo" value="" styleClass="mytext1" tabindex="20" size="12" /></td></tr>
	<tr>
    <td nowrap class="btext1">Aadhaar No<font color="#FF6666">*</font>:</td>
	<td><html:text property="adharNo" value="" styleClass="mytext1" tabindex="20" maxlength="12" size="12" onkeypress="return numeralsOnly(event)" /></td>
    </tr>
</table>
</tr></td></table>
</td></tr></table>


<table cellpadding="0" cellspacing="2">
<tr>
<td colspan=4 class="btext1"><font color="maroon"> <b>Bank Details:</b></font></td></tr>
<tr>
<td class="btext1">IFSC Code<font color="#FF6666">*</font>:</td>
	<td><html:text property="ifscCode"  styleClass="btext2"  size="11" maxlength="11" onblur="ajaxFunction_ifsc();" /></TD>
	<td class="btext1">Bank Name<font color="#FF6666">*</font>:</td>
	<td><html:text property="bankName" readonly="true" styleClass="btext2" size="20"  /></TD>
	<td class="btext1">&nbsp;&nbsp;Branch Name<font color="#FF6666">*</font>:</td>
	<td><html:text property="branchName"  readonly="true" styleClass="btext2" size="20"  /></TD>
   
<tr>
<tr>
	    <td class="btext1">Account Number<font color="#FF6666">*</font>:</td>
	<td><html:text property="accountNo"   styleClass="btext2"  size="20" maxlength="24" onkeypress="return numeralsOnly(event)" /></TD>
	 <td class="btext1">&nbsp;&nbsp;Address:<font color="#FF6666">*</font>:</td>
	<td><html:textarea property="branchAddress"  readonly="true" styleClass="btext2"  rows="4" cols="25"   /></TD>

</tr>

</table>


<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext1" value="Save" onclick="return validateFormm()"/>
     <html:submit title="close" styleClass="btext1" value="Close" onclick="closewin(this)" />
 
	</td>
</tr>

</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="855px"/>
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
