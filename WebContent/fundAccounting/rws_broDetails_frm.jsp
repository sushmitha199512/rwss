
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%int count=0; %>
<head>
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0"> 
</head>
<script language="javascript">
var globaldeltecount=0;
  function retrieveURL(url) 
	{
	if (window.XMLHttpRequest) 
	{ 
	// Non-IE browsers
				req = new XMLHttpRequest();       
				req.onreadystatechange = processStateChange;
				try {
					 req.open("GET", url, true);
				} catch (e) {
					 //alert(e);
				}
				req.send(null);
			} else if (window.ActiveXObject) { // IE
			
				 req = new ActiveXObject("Microsoft.XMLHTTP");
				if (req) {
					 req.onreadystatechange = processStateChange;
					 req.open("GET", url, true);
					 req.send();
				 }
			}
	  }

function ajaxRequest(){

var  httpRequest2;
				if (window.ActiveXObject) { //IE
		           httpRequest2 = new ActiveXObject("Microsoft.XMLHTTP"); 
		        } 
		        else if (window.XMLHttpRequest)  { //other browsers
		            httpRequest2 = new XMLHttpRequest(); 
		        } 
		        return httpRequest2;
		  }
function ajaxFunction(URL)
		{ 
			if (URL.indexOf("?") != -1) { URL = URL;  } else { URL = URL ; }
			//alert(URL);
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
			/*xmlHttp.onreadystatechange=function()
			{
			  if(xmlHttp.readyState==4)
			  {
				divobj.innerHTML=xmlHttp.responseText;
			  }
			  else{
				divobj.innerHTML="<FONT SIZE='1' COLOR='black' face=verdana></FONT>";
			  }
			}*/
			//alert(URL);
			xmlHttp.open("POST",URL,true);
			xmlHttp.send(null);  
		}
		//var mcode=document.forms[0].majorHead.value;
  //ajaxFunction(' switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=accDetails&val='+value+'&rowId='+count);

function fndetails(count,value)
{
 //alert("value:"+value);
  //alert("count:"+count);
 document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=accDetails&val="+value+"&rowId="+count;
document.forms[0].submit();
}

function getAjaxRequest()
{
var openRequest;
try {
openRequest = new XMLHttpRequest();
return openRequest;
}
catch (error) {
try {
openRequest = new ActiveXObject("Microsoft.XMLHTTP");
return openRequest;
}
catch (error)
	{
if(isDebugOn)
displayDebugError("Error crea");
	}
	
  }
}

function getSubprograms(count)
{
	var programCode = document.getElementById("BRO_DETAILS_LIST["+count+"].programmeCode").value;
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=getSubProgram&program="+programCode+"&rowId="+count;
//	var url="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=getSubProgram&program="+programCode+"&rowId="+count;
	document.forms[0].submit();
}
function fnDeleteBro()
{
	if(document.forms[0].bro_id.value=="")
		alert("Please select Bro Id");
	else
	{
		if(confirm("Do you want to delete the record"))
		{
		document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=deleteBro";
		document.forms[0].submit();
		}
	}
}

function checkBroAmount()
{

var sanctionamount=parseFloat(document.forms[0].bro_sanctionAmount.value);
var broamount=parseFloat(document.forms[0].bro_amount.value);
var estimate=parseInt(document.forms[0].bro_budgetEstimate.value);
//num.toFixed(2)
if(broamount>0)
{
document.forms[0].gf.value=((broamount)*(77.2/100)).toFixed(2);
document.forms[0].scp.value=((broamount)*(16.2/100)).toFixed(2);
document.forms[0].tsp.value=((broamount)*(6.6/100)).toFixed(2);

}
else
{
document.forms[0].gf.value=0;
document.forms[0].scp.value=0;
document.forms[0].tsp.value=0;
}
if(sanctionamount<broamount)
{
alert("BRO Amount <= Sanction Amount");
document.forms[0].bro_amount.value='';
document.forms[0].gf.value='';
document.forms[0].scp.value='';
document.forms[0].tsp.value='';
return false;
}
/*else
if(sanctionamount>estimate)
{
alert("Sanction <= Estimate Amount");
document.forms[0].bro_sanctionAmount.value='';
document.forms[0].gf.value='';
document.forms[0].scp.value='';
document.forms[0].tsp.value='';
return false;
}*/
}

function fnBroamt(num)
{
	//alert(" in dfdfg");
	var broamt=document.forms[0].bro_amount.value;
	var gf=document.forms[0].gf.value;
    var scp=document.forms[0].scp.value;
	var tsp=document.forms[0].tsp.value;
	var totamt=parseFloat(gf) +parseFloat(scp) + parseFloat(tsp);
//alert(totamt);
	if(totamt>broamt)
	{
		alert("  GF + SCP + TSP is must be Less than Bro Amount ");
		if(num=='1'){
		document.forms[0].gf.value='';
		}else if(num=='2'){
		document.forms[0].scp.value='';
		}else if(num=='3'){
		document.forms[0].tsp.value='';
		}
		return false;
	}
	else {
		return true;
	}
}


function fnEdit()
{
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=edit";
	document.forms[0].submit();
}
function fnGetBro()
{
	var broId=document.forms[0].bro_id.value;
	document.forms[0].bro_reference.value = broId;
	var broRef = document.forms[0].bro_reference.value;
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=edit&bro_id="+broId+"&bro_reference="+broRef;
	document.forms[0].submit();
	
}

function enableDisableQuarters(i)
{
var saveorupdate=document.forms[0].save.value;
var quarter=document.getElementById("BRO_DETAILS_LIST["+i+"].quarter").value;
var mode='<%=request.getParameter("mode")%>';
//alert(mode);	
	if(saveorupdate=='Update'&&quarter.length!=0)
	{
//	 alert(saveorupdate);
	//document.getElementById("BRO_DETAILS_LIST["+i+"].quarter").disabled=true;
	 }
}

/*function fnmindetails(count,value)
{
 alert("value:"+value);
document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=minorhead&rowId="+count+"&value="+value;
document.forms[0].submit();
}*/

function fnGetBro1()
{
	var broId=document.forms[0].bro_id.value;
	document.forms[0].bro_reference.value = broId;
	var broRef = document.forms[0].bro_reference.value;
}
function fnAddNewBro()
{
	//alert("shdgfgdsf ");
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=addNew";
	document.forms[0].submit();
}
function fnSave()
{
	//alert(document.forms[0].tsp.value);
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=save"
	var cnt=readCookie("deletecount");
	var count=0;
	if(checkForm())
	document.forms[0].submit();
	while(cnt!=null)
	{
	eraseCookie("deletecount");
	cnt=readCookie("deletecount");
	}
	
}


function fnView()
{
	document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=view";
	document.forms[0].submit();
}
var brodetails;
function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {

	var nameEQ;
	if(name==null)
	return "";
	else
	{
	nameEQ= name + "=";
	var ca = document.cookie.split(';');
	
	
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}



function deleteBRODetails(i){

	if(confirm("Are You Sure You Want To Delete")){
	
		var programmecode=document.getElementById("BRO_DETAILS_LIST["+i+"].programmeCode").value;
		var subprogrammecode=document.getElementById("BRO_DETAILS_LIST["+i+"].subprogrammeCode").value;
		//var hoa=document.getElementById("BRO_DETAILS_LIST["+i+"].headOfAccount").value;
		var quater=document.getElementById("BRO_DETAILS_LIST["+i+"].quarter").value;
		var amt_now_auth=document.getElementById("BRO_DETAILS_LIST["+i+"].amountNowAuthorised").value;
		var brodetail=programmecode+","+subprogrammecode+","+quater;
		var be_year=document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").value;
		
		var progcode,spcode,hoacod,quarter1,amtnowauth,byear;
	
		var deletecount=parseInt(isNull(readCookie("deletecount"))); 
		progcode=readCookie("programmecode"+deletecount);
		spcode=readCookie("subprogrammecode"+deletecount);
		//hoacod=readCookie("hoa"+deletecount);
		quarter1=readCookie("quarter"+deletecount);
		amtnowauth=readCookie("amtnowauth"+deletecount);
		byear=readCookie("be_year"+deletecount);
		
		
		
		if(progcode!=null){
		eraseCookie("programmecode"+deletecount);		
		if(spcode!=null){
		eraseCookie("subprogrammecode"+deletecount);
		 i	 
		 if(quarter1!=null){
		 eraseCookie("quarter"+deletecount);
		 if(amtnowauth!=null){		
		 eraseCookie("amtnowauth"+deletecount);
		 if(byear!=null){
		 eraseCookie("be_year"+deletecount);
		 }}}}}

		 createCookie("programmecode"+deletecount,programmecode,1);
		 createCookie("subprogrammecode"+deletecount,subprogrammecode,1);
		 //createCookie("hoa"+deletecount,hoa,1);
		 createCookie("quarter"+deletecount,quater,1);
		 createCookie("amtnowauth"+deletecount,amt_now_auth,1);
		 createCookie("be_year"+deletecount,be_year,1);
		 
		 //alert("pcode"+readCookie("hoa"+deletecount));
		 deletecount++;
		
		
		
		
		
		
		//alert(parseInt(isNull(readCookie("deletecount")))); 
		
		createCookie("deletecount",parseInt(deletecount));
		document.getElementById("BRO_DETAILS_LIST["+i+"].programmeCode").value="";
		document.getElementById("BRO_DETAILS_LIST["+i+"].subprogrammeCode").value="";
		//document.getElementById("BRO_DETAILS_LIST["+i+"].headOfAccount").value="";
		document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimate").value="";
		document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").value="";
		document.getElementById("BRO_DETAILS_LIST["+i+"].amountAlreadyAuthorised").value="";
		document.getElementById("BRO_DETAILS_LIST["+i+"].amountNowAuthorised").value="";
		document.getElementById("BRO_DETAILS_LIST["+i+"].procedureForDrawl").value="";
		document.getElementById("BRO_DETAILS_LIST["+i+"].drawingOfficer").value="";
		document.getElementById("BRO_DETAILS_LIST["+i+"].remarks").value="";
		document.forms[0].action="switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=deleteFromBroProgList&rowId="+i;
		document.forms[0].submit();
		
	}
	
	
}
function addNewProgrammeForBRO(rowCount){
	//alert(" in adds ");
if(rowCount>0){
//alert(" in first if");
var progcode=document.getElementById("BRO_DETAILS_LIST["+(rowCount-1)+"].programmeCode").value;
var spcode=document.getElementById("BRO_DETAILS_LIST["+(rowCount-1)+"].subprogrammeCode").value;
var mhead=document.getElementById("BRO_DETAILS_LIST["+(rowCount-1)+"].majorHead").value;		
//alert("hoa:"+hoa);
//alert(document.getElementById("BRO_DETAILS_LIST["+(rowCount-1)+"].budgetEstimate").value);		
if(progcode.length==0||spcode.length==0){
alert("Please select programme supbrograme for above BRO");
return false;
}if(mhead.length==0){
 alert("Please select Major Head Code");
 return false;
}if(document.getElementById("BRO_DETAILS_LIST["+(rowCount-1)+"].budgetEstimate").value =="")
{
	alert("Please Provide Budget Estimate ");
	return false;
}if(document.getElementById("BRO_DETAILS_LIST["+(rowCount-1)+"].selects").value=="")
	{
	   alert("Please Select State or Center ");
		return false;
	}
	if(document.getElementById("BRO_DETAILS_LIST["+(rowCount-1)+"].quarter").value=="")
	{
	   alert("Please Select  Quaters / Instalments ");
		return false;
	}

}
if(document.forms[0].bro_id.value!=""){
  document.forms[0].action="./switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=addNewProgrammeForBro";
  document.forms[0].submit();
  document.getElementById("BRO_DETAILS_LIST["+rowCount+"].quarter").disabled=false;
   return true;
}
else{
		alert("BRO Id is Mandatory");
		return false;
	 }
	  return true;
}
function isNull(count)
{
if(count==null||count.length==0)
{
return 0;
}
else
return count;
}


function fnValidateBE(index)
{

var be1 = document.getElementById("BRO_DETAILS_LIST["+index+"].budgetEstimate").value;
var be2 = document.forms[0].bro_budgetEstimate.value;
var be = parseFloat(document.getElementById("BRO_DETAILS_LIST["+index+"].budgetEstimate").value);
var i2 = parseInt(document.forms[0].bro_amount.value);
var gf=document.forms[0].gf.value;
var scp=document.forms[0].scp.value;
var ts=document.forms[0].tsp.value;
var detailcount;
be*=1.0;
var subprogrammeCode=document.getElementById("BRO_DETAILS_LIST["+index+"].subprogrammeCode").value;
var budgetestimate=document.getElementById("BRO_DETAILS_LIST["+index+"].budgetEstimate").value;
var amountNowAuthorised=document.getElementById("BRO_DETAILS_LIST["+index+"].amountNowAuthorised").value


if(amountNowAuthorised>budgetestimate&&budgetestimate>0&&budgetestimate.length!=0)
{
	alert("AmountNowAuthorized < Budget Estimate of the record with S.No."+(index+1)+"");
	document.getElementById("BRO_DETAILS_LIST["+index+"].amountNowAuthorised").value=0;
	document.getElementById("BRO_DETAILS_LIST["+index+"].budgetEstimate").focus();
}

}



function fnBeToSa()
{
	document.forms[0].bro_sanctionAmount.value = document.forms[0].bro_budgetEstimate.value;
}
function fnGetQtrs(i)
{
   
	var saveorupdate=document.getElementById("save").value;
	if(document.getElementById("BRO_DETAILS_LIST["+i+"].programmeCode").value == null || document.getElementById("BRO_DETAILS_LIST["+i+"].programmeCode").value == "")
	{
		alert("Please Select Programme for BRO List with S.No "+(i+1));
	}
	else 	if(document.getElementById("BRO_DETAILS_LIST["+i+"].subprogrammeCode").value == null || document.getElementById("BRO_DETAILS_LIST["+i+"].subprogrammeCode").value == "")
	{
		alert("Please Select Sub Programme for BRO List with S.No "+(i+1));
	}
	else if(saveorupdate=="Update")
	{
		//document.forms[0].action="switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=getQtrs&rowId="+i;
		//document.forms[0].submit();
	}
		
}
function fnGetQtrDetails(i)
{
   
var saveorupdate=document.getElementById("save").value;
 	
 	var brodetailscount=0;
	var programmeCode=document.getElementById("BRO_DETAILS_LIST["+i+"].programmeCode").value;
	var subprogrammeCode=document.getElementById("BRO_DETAILS_LIST["+i+"].subprogrammeCode").value;
	//var hoa=document.getElementById("BRO_DETAILS_LIST["+i+"].headOfAccount").value;
	var budgetEstimateYear=document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").value;
	var statecenter=document.getElementById("BRO_DETAILS_LIST["+i+"].selects").value;
	var pcode,spcode,hoa1,beyear,statecenter1;
	var currentbrodetails="";
	var flag=0,prevamt=0;
	var amountnow=document.getElementById("BRO_DETAILS_LIST["+i+"].amountNowAuthorised").value;
	currentbrodetails=programmeCode+subprogrammeCode+budgetEstimateYear+statecenter;
	var previousbrodetails="",amountalready=0;
	if( programmeCode== null || programmeCode == ""){
		alert("Please Select Programme for BRO List with S.No "+(i+1));
	}
	else 	if( subprogrammeCode == null || subprogrammeCode == ""){
		alert("Please Select Sub Programme for BRO List with S.No "+(i+1));
	}
	/*else 	if(hoa == null || hoa == ""){
		alert("Please Select headOfAccount for BRO List with S.No "+(i+1));
	}*/
	/*else if(saveorupdate=="Update"){
		document.forms[0].action="switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=getQtrDetails&rowId="+i;
		document.forms[0].submit();
	}*/
	else{
	for(brodetailscount=0;brodetailscount<=i;brodetailscount++){
	 pcode=document.getElementById("BRO_DETAILS_LIST["+brodetailscount+"].programmeCode").value;
	 spcode=document.getElementById("BRO_DETAILS_LIST["+brodetailscount+"].subprogrammeCode").value;
	 //hoa1=document.getElementById("BRO_DETAILS_LIST["+brodetailscount+"].headOfAccount").value;
	 beyear=document.getElementById("BRO_DETAILS_LIST["+brodetailscount+"].budgetEstimateYear").value;
	 statecenter1=document.getElementById("BRO_DETAILS_LIST["+brodetailscount+"].selects").value;
	 previousbrodetails=pcode+spcode+beyear+statecenter1;
	 if(currentbrodetails.toString()==previousbrodetails.toString()){
	 flag++;
	 amountalready+=parseFloat(isNull(document.getElementById("BRO_DETAILS_LIST["+parseInt(brodetailscount)+"].amountNowAuthorised").value));
	 if(brodetailscount>0&&amountnow>0&&i==brodetailscount){
	 amountalready-=amountnow;
	 prevamt=amountnow;
	 }
	 else
	 amountalready-=prevamt;
	// alert(amountnow);
//	alert(flag+"IVAL"+i+"amount already"+amountalready+"Now "+amountnow);
	if(flag>1)
	document.getElementById("BRO_DETAILS_LIST["+brodetailscount+"].amountAlreadyAuthorised").value=amountalready.toFixed(2);
	 }
	
	 }

	}
	
	}


function checkBudgetEstmateAndAmountNow(index)
{

var budgetestimate=parseInt(document.getElementById("BRO_DETAILS_LIST["+index+"].budgetEstimate").value);
var amountNowAuthorised=parseInt(document.getElementById("BRO_DETAILS_LIST["+index+"].amountNowAuthorised").value);
var subprogrammeCode=document.getElementById("BRO_DETAILS_LIST["+index+"].subprogrammeCode").value;

var gf=document.forms[0].gf.value;
var scp=document.forms[0].scp.value;
var ts=document.forms[0].tsp.value;
var detailcount;
//alert(amountNowAuthorised);
/*if(amountNowAuthorised>budgetestimate)
{
alert("Amount Now Authorized must be lessthan  Estimated Amount");
document.getElementById("BRO_DETAILS_LIST["+index+"].amountNowAuthorised").value=0;
return false;
}

if(amountNowAuthorised>budgetestimate&&budgetestimate>0&&budgetestimate.length!=0)
{
	alert("AmountNowAuthorized must be less than Budget Estimate of the record with S.No."+(index+1)+"");
	//document.getElementById("BRO_DETAILS_LIST["+index+"].amountNowAuthorised").value=0;
	document.getElementById("BRO_DETAILS_LIST["+index+"].amountNowAuthorised").focus();
	return false;
}*/
/*if(amountNowAuthorised>gf&&(subprogrammeCode=="01"||subprogrammeCode=="04"))
{
		alert(" Amount Now must Be Less Than  BRO Budget Estimate for GF of the record with S.No."+(index+1)+"");
		document.getElementById("BRO_DETAILS_LIST["+index+"].amountNowAuthorised").focus();
		return false;
}
else if(amountNowAuthorised>scp&&subprogrammeCode=="02"){
		alert(" Amount Now Must Be Less Than BRO Budget Estimate for SCP of the record with S.No."+(index+1)+"");
		document.getElementById("BRO_DETAILS_LIST["+index+"].amountNowAuthorised").focus();
		return false;
}
else if(amountNowAuthorised>ts&&subprogrammeCode=="03"){
		alert(" Amount Now Must Be Less Than  BRO Budget Estimate for TSP of the record with S.No."+(index+1)+"");
		document.getElementById("BRO_DETAILS_LIST["+index+"].amountNowAuthorised").focus();
		return false;

}*/


}

</script>
<%
 out.println("<SCRIPT TYPE='text/javascript'> var a =new Array()");

//for(int i=0;i<
 out.println("</SCRIPT>");  

%>
<body  onload="initFunc()">
<html:form action="broDetails.do" >
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="BRO Details Entry Form" />
		<jsp:param name="TWidth" value="100%"/>
		
	</jsp:include>
</td></tr></thead>

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


<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	

<tr>
	<td class="mycborder">
		<fieldset>
			<legend>BRO Details (Amount In Rs. Lakhs)</legend>
			<label>
				<table  border=0  width="100%">
				
				<tr>
					<TD class="textborder">
					
						BRO Id<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    <%if((session.getAttribute("mode")==null)||((String)session.getAttribute("mode")).equals("data"))
					{ %>
					<html:select property="bro_id" 
									   style="width: 125px" styleClass="noborder-text-box" 
									   onchange='<%= "javascript: fnGetBro()"%>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options  name="broIdList" />
						</html:select>
						<%}else{ %>
				    	<html:text property="bro_id"   
				    			   styleClass="mytext"  maxlength="40"  style="width:125" onkeypress="upperOnly();" onchange="fnGetBro1();"/>
				    	<%} %>
				    </TD>
				    <TD class="textborder">
				     
						BRO Reference<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="bro_reference"   
				    			   styleClass="mytext" maxlength="40" style="width:125" onkeypress="upperOnly()"/>
				    </TD>
				    <TD class="textborder">
				     
						BRO Date<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="bro_date"   
				    			   styleClass="mytext" style="width:100" onkeypress="upperOnly()" readonly="true"/>
				    			   <a href="javascript: showCalendar(document.getElementById('bro_date'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
						  </a>
				    </TD>
				</tr>
				<tr>
					<TD class="textborder">
				     
						Budget Estimate<font color="#FF6666">*</font>
					</TD>
					<TD class="bwborder">
				    	<html:text property="bro_budgetEstimate"   
				    			   styleClass="mytext"  maxlength="8"  style="width:125" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
								  
				    </TD>
				    <TD class="textborder">
				     
						Sanction Amount<font color="#FF6666">*</font>
					</TD>
					<TD class="bwborder">
				    	<html:text property="bro_sanctionAmount"   
				    			   styleClass="mytext" maxlength="8"  style="width:125" onkeyup="extractNumber2(this,7,2,false); checkBroAmount();" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    </TD>
				     <TD class="textborder">
				     
						BRO Amount<font color="#FF6666">*</font>
					</TD>
					<TD class="bwborder">
				    	<html:text property="bro_amount"   
				    			   styleClass="mytext" maxlength="8" style="width:125" onkeyup="extractNumber2(this,7,2,false); checkBroAmount();" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    </TD>
				</tr><tr>
				<TD class="bwborder" colspan=2>
				</TD>
				<TD class="bwborder" >
				<B>Budget Distribution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B></TD>
				<td colspan=3>
				<TABLE>
				<tr>
					<td class="textborder">GF&nbsp;&nbsp;</td>
					<td><html:text property="gf" style="width:50"  styleClass="mytext"  onkeyup="return fnBroamt('1')" />					
					<TD class="textborder">&nbsp;&nbsp;&nbsp;SCP&nbsp;&nbsp;				    	
					<html:text property="scp" style="width:50"  styleClass="mytext"   onkeyup="return fnBroamt('2')"/>
					<TD class="textborder">&nbsp;&nbsp;&nbsp;TSP&nbsp;&nbsp;
					<html:text property="tsp" style="width:50"  styleClass="mytext"   onkeyup="return fnBroamt('3')"/>
				</tr>
				</TABLE>
				</td> 
				<tr>
					<TD class="textborder">
				     
						Financial Year<font color="#FF6666">*</font>
					</TD>
					<TD class="bwborder">
					<html:select property="bro_financialYear" styleClass="mytext" style="width:125" onchange="return financialYearOnly(event,this)">
					<html:options collection="bro_financialYear" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</html:select>
				    </TD>
				    <TD class="textborder" colspan="2">
				     
						Re Appropriation<font color="#FF6666"></font>
						<html:select property="appflag" style="width: 60px" styleClass="noborder-text-box">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:option value="+">+</html:option>
							<html:option value="-">-</html:option>
						</html:select>
						<html:text property="bro_appAmount"   
				    			   styleClass="mytext" maxlength="9" style="width:108" onkeyup="extractNumber2(this,11,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
					</TD>
					<TD class="textborder">
				     
						Additional Amount<font color="#FF6666"></font>
					</TD>
					<TD class="bwborder">
					<html:text property="bro_addAmount"   styleClass="mytext" maxlength="9" style="width:125" onkeyup="extractNumber2(this,11,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
				    </TD>
				</tr>
				</table>
				
		
			</label>
		</fieldset>
	</td>
</tr>

<!-- BRO Details Begins Here -->
<tr>
	 		<td>
	 		  <div id="broProgTable" style="HEIGHT:100px; WIDTH:900; OVERFLOW:auto">
	 		  <table   width="100%" bgcolor="#ffffff" cellpadding="0" cellspacing="1" 
					   border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
				 	     <td class="clrborder" align="center">Programme<font color="black">*</font></td>
   				 	     <td class="clrborder" align="center">SubProgramme<font color="black">*</font></td>
					     <!--<td class="clrborder" align="center">Head Of Account<font color="black">*</font></td>-->
						 <td class="clrborder" align="center">Major Head <font color="black">*</font></td>
						 <td class="clrborder" align="center">Sub Major Head <font color="black"></font></td>
						 <td class="clrborder" align="center">Minor Head <font color="black"></font></td>
						 <td class="clrborder" align="center">Group Head <font color="black"></font></td>
						 <td class="clrborder" align="center">Sub Head <font color="black"></font></td>
						 <td class="clrborder" align="center">Detail Head <font color="black"></font></td>
						 <td class="clrborder" align="center">Sub Detail  Head <font color="black"></font></td>
					     <td class="clrborder" align="center">Budget Estimate<font color="black">*</font></td>
					     <td class="clrborder" align="center">Budget Estimate Year</td>
   					     <td class="clrborder" align="center">Select<font color="black">*</font></td>
   					     <td class="clrborder" align="center">Quarters/<br>Installments<font color="black">*</font></td>
					     <td class="clrborder" align="center">Amount Already Authorised</td>
					     <td class="clrborder" align="center">Amount Now Authorised</td>
					     <td class="clrborder" align="center">Procedure Of Drawl</td>
					     <td class="clrborder" align="center">Drawing Officer</td>
					     <td class="clrborder" align="center">Remarks</td>
					     <td class="clrborder" align="center">Action</td>
				 	  </tr>
					   
					   
					  <%count=0; %>
					  <nested:iterate id="BRO_DETAILS_LIST" name="broDetailsList"  >
				 	  <tr>
				 	  
					  <td class="bwborder" align="center">
					  <%= ++count %>
					  </td>
					  <td class="bwborder" align="center">
					<html:select name="BRO_DETAILS_LIST" style="width:200" property="programmeCode" styleClass="mycombo" indexed="true" onchange='<%= "getSubprograms("+(count-1)+")"%>'>
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="programmsList">
					<html:options collection="programmsList" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>
				
					</html:select>
				  </td> 
					<td class="bwborder" align="center">
					<html:select name="BRO_DETAILS_LIST" style="width:200" property="subprogrammeCode" styleClass="mycombo" indexed="true" >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="BRO_DETAILS_LIST" property="subProgrammesList">
		 					  <nested:optionsCollection name="BRO_DETAILS_LIST" property="subProgrammesList" label="label" value="value"/>
						</logic:present>		  
									
					</html:select>
					  </td> 
		<!--			   <td class="bwborder" align="center">
		<html:select name="BRO_DETAILS_LIST" style="width:400" property="headOfAccount" styleClass="mycombo" indexed="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="headOfAccountList">
					<html:options collection="headOfAccountList" name="labelValueBean" 
								  property="value" labelProperty="labelValue" />
					</logic:notEmpty>
				
					</html:select>
					  </td> -->
					  <td class="bwborder" align="center">
				<nested:select name="BRO_DETAILS_LIST" style="width:250px" property="majorHead" styleClass="mycombo" indexed="true" onchange='<%= "fndetails("+(count-1)+","+1+")"%>'  >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="majorHeadList">
					<html:options collection="majorHeadList" name="labelValueBean" 
								  property="value" labelProperty="labelValue" />
					</logic:notEmpty>
				
					</nested:select>
					  </td> 
					  
					 
				<td class="bwborder" align="center">
					<nested:select name="BRO_DETAILS_LIST" style="width:150PX" property="subMajorHead" styleClass="mycombo" indexed="true" onchange='<%= "fndetails("+(count-1)+","+2+")"%>' >
					<html:option value="00"><bean:message key="app.pleaseSelect" /></html:option>
					<logic:present name="BRO_DETAILS_LIST" property="submajorlist">
		 			 <nested:optionsCollection name="BRO_DETAILS_LIST" property="submajorlist" label="label" value="value"/>
					</logic:present>		  
									
					</nested:select>
					  </td> 
					<td class="bwborder" align="center">
					<nested:select name="BRO_DETAILS_LIST" style="width:150PX" property="minorHead" styleClass="mycombo" indexed="true" onchange='<%= "fndetails("+(count-1)+","+3+")"%>'>
					<html:option value="000"><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="BRO_DETAILS_LIST" property="minorHeadList">
		 					  <nested:optionsCollection name="BRO_DETAILS_LIST" property="minorHeadList" label="label" value="value"/>
						</logic:present>		  
									
					</nested:select>
					  </td> 
					  <td class="bwborder" align="center">
					<nested:select name="BRO_DETAILS_LIST" style="width:150PX" property="groupHead" styleClass="mycombo" indexed="true" onchange='<%= "fndetails("+(count-1)+","+4+")"%>'>
					<html:option value="00"><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="BRO_DETAILS_LIST" property="groupHeadList">
		 					  <nested:optionsCollection name="BRO_DETAILS_LIST" property="groupHeadList" label="label" value="value"/>
						</logic:present>		  
									
					</nested:select>
					  </td> 
					
					<td class="bwborder" align="center">
					<nested:select name="BRO_DETAILS_LIST" style="width:150PX" property="subHead" styleClass="mycombo" indexed="true" onchange='<%= "fndetails("+(count-1)+","+5+")"%>'>
					<html:option value="00"><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="BRO_DETAILS_LIST" property="subHeadList">
		 					  <nested:optionsCollection name="BRO_DETAILS_LIST" property="subHeadList" label="label" value="value"/>
						</logic:present>		  
									
					</nested:select>
					  </td> 
					  <td class="bwborder" align="center">
					<nested:select name="BRO_DETAILS_LIST" style="width:150PX" property="detailHead" styleClass="mycombo" indexed="true" onchange='<%= "fndetails("+(count-1)+","+6+")"%>'>
					<html:option value="000"><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="BRO_DETAILS_LIST" property="detailHeadList">
		 					  <nested:optionsCollection name="BRO_DETAILS_LIST" property="detailHeadList" label="label" value="value"/>
						</logic:present>		  
									
					</nested:select>
					  </td> 

					 <td class="bwborder" align="center">
					<nested:select name="BRO_DETAILS_LIST" style="width:150PX" property="subDetailHead" styleClass="mycombo" indexed="true">
					<html:option value="000"><bean:message key="app.pleaseSelect" /></html:option>
						<logic:present name="BRO_DETAILS_LIST" property="subDetailHeadList">
		 					  <nested:optionsCollection name="BRO_DETAILS_LIST" property="subDetailHeadList" label="label" value="value"/>
						</logic:present>		  
									
					</nested:select>
					  </td> 


				  
					  <td class="bwborder" align="center" >
					  <logic:equal name="BRO_DETAILS_LIST" property="budgetEstimate" value="0">
					 	  <nested:text name="BRO_DETAILS_LIST" property="budgetEstimate" styleClass="gridtext" 
						    style="width:80px" indexed="true"  onkeypress="return blockNonNumbers(this, event, true, false);" onkeyup='<%= "fnValidateBE("+(count-1)+")"%>'/>
					 </logic:equal>
					  <logic:notEqual name="BRO_DETAILS_LIST" property="budgetEstimate" value="0">
					 	  <nested:text name="BRO_DETAILS_LIST" property="budgetEstimate" styleClass="gridtext" 
						    style="width:80px" indexed="true"  onkeypress="return blockNonNumbers(this, event, true, false);" onkeyup='<%= "fnValidateBE("+(count-1)+")"%>' />
					</logic:notEqual>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="BRO_DETAILS_LIST" property="budgetEstimateYear" styleClass="gridtext" style="width:100px" maxlength="9"
						  indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	 <html:select name="BRO_DETAILS_LIST" style="width:75" property="selects" styleClass="mycombo" indexed="true" onchange='<%= "fnGetQtrs("+(count-1)+")"%>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:option value="C">Center</html:option>
							<html:option value="S">State</html:option>
						</html:select>
					</td>

					
					<td class="bwborder" align="center">
					<!-- onchange='<%= "fnGetQtrDetails("+(count-1)+")"%>' -->
					 	 <html:select name="BRO_DETAILS_LIST" style="width:95" property="quarter" styleClass="mycombo" indexed="true"  onchange='<%= "fnGetQtrDetails("+(count-1)+")"%>' onmouseover='<%= "fnGetQtrDetails("+(count-1)+")"%>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:option value="1">1</html:option>
							<html:option value="2">2</html:option>
							<html:option value="3">3</html:option>
							<html:option value="4">4</html:option>
							<html:option value="5">5</html:option>
							<html:option value="6">6</html:option>
							<html:option value="7">7</html:option>
							<html:option value="8">8</html:option>
							<html:option value="S">Supplementary</html:option>							
						</html:select>
					</td>
					<td class="bwborder" align="center">
					  
					 	  <nested:text name="BRO_DETAILS_LIST" property="amountAlreadyAuthorised" styleClass="gridtext" style="width:100px"
						  indexed="true"   onkeyup="extractNumber2(this,11,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="BRO_DETAILS_LIST" property="amountNowAuthorised" styleClass="gridtext" style="width:100px"
						  indexed="true"  onkeyup='<%= "extractNumber2(this,11,2,false); checkBudgetEstmateAndAmountNow("+(count-1)+")"%>'  onkeypress="return blockNonNumbers(this, event, true, false); "  />
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="BRO_DETAILS_LIST" property="procedureForDrawl" styleClass="gridtext" style="width:100px"
						  indexed="true"  maxlength="30" onkeypress="upperOnly()"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="BRO_DETAILS_LIST" property="drawingOfficer" styleClass="gridtext" style="width:100px"
						  indexed="true"  maxlength="30" onkeypress="upperOnly()"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="BRO_DETAILS_LIST" property="remarks" styleClass="gridtext" style="width:100px"
						  indexed="true"  maxlength="30" onkeypress="upperOnly()"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <a href="#1" onclick='deleteBRODetails(<%=count-1%>)'>Delete</a>
					  </td>
					  </tr>
					  
					  </nested:iterate>
						<%if((session.getAttribute("mode")==null)||((String)session.getAttribute("mode")).equals("data"))
						{ %>
							<%if(count==0){ %>
								<tr><td colspan="20" align="center">No Records</td></tr>
							<%} %>
						<%} %>
					  <tr><td colspan="11" align="right" title="" bgcolor="#DEE3E0" ><input type="button" class="btext" value="Add New" onclick="return addNewProgrammeForBRO(<%= count %>)"> </td></tr>
					  </table>
					  </div>
	 		       </td>
	 		      </tr>
	 				

<!-- End of BRO Details -->
<tr>
<td align="center">
<%if((session.getAttribute("mode")==null)||((String)session.getAttribute("mode")).equals("data"))
{ %>
<input type="button" class="btext" name="save" value="Update" onclick="fnSave()">&nbsp;
<input type="button" class="btext" value="Add New" onclick="fnAddNewBro()">&nbsp;
<input type="button" class="btext" value="Delete" onclick="fnDeleteBro()">&nbsp;
<%}else{ %>
<input type="button" class="btext" name="save" value="Save" onclick="fnSave()">&nbsp;
<input type="button" class="btext" value="Edit" onclick="fnEdit()">&nbsp;
<%} %>

<input type="button" class="btext" value="View" onclick="fnView()"></td>

</tr>
</table>

</td></tr></tbody></table>
</html:form>
</body>
<script language="javascript">
function checkForm()
{
	//alert("gsdfsdf ");
		
	var budgetestimate=parseInt(document.forms[0].bro_budgetEstimate.value);	
	if(document.forms[0].bro_id.value=="")
	{
		alert("BRO Id is Mandatory");
		document.forms[0].bro_id.focus();
		return false;
	}
	else if(document.forms[0].bro_reference.value=="")
	{
		alert("BRO Reference is Mandatory");
		document.forms[0].bro_reference.focus();
		return false;
	}
	else if(document.forms[0].bro_date.value=="")
	{
		alert("BRO Date is Mandatory");
		document.forms[0].bro_date.focus();
		return false;
	}
	else if(document.forms[0].bro_budgetEstimate.value=="")
	{
		alert("Budget Estimate is Mandatory");
		document.forms[0].bro_budgetEstimate.focus();
		return false;
	}
	else if(document.forms[0].bro_sanctionAmount.value=="")
	{
		alert("Sanction Amount is Mandatory");
		document.forms[0].bro_sanctionAmount.focus();
		return false;
	}
	else if(document.forms[0].bro_amount.value=="")
	{
		alert("BRO Amount is Mandatory");
		document.forms[0].bro_amount.focus();
		return false;
	}
	else if(document.forms[0].bro_financialYear.value=="")
	{
		alert("BRO Financial Year is Mandatory");
		document.forms[0].bro_financialYear.focus();
		return false;
	}
	<%
	
	if(count == 0)
	{%>
		alert("Atleast One Record is Mandatory In BRO List");
		return false;
	<%}%>
	var totalBE=parseInt(0);
	var i,totalamountnowauthorized=0;
	var broamount=document.forms[0].bro_amount.value;
	var subprogrammecode;

		var beplain=parseFloat("0.0"),bescp=parseFloat("0.0"),bets=parseFloat("0.0");
	
		var gf=document.forms[0].gf.value;
		var scp=document.forms[0].scp.value;
		var ts=document.forms[0].tsp.value;
	
	for(i=0;i<<%=count%>;i++)
	{
	 subprogrammecode=document.getElementById("BRO_DETAILS_LIST["+i+"].subprogrammeCode").value;
	if(subprogrammecode=="01"||subprogrammecode=="04"||subprogrammecode=="00"){
	  beplain+=parseFloat(isNull(document.getElementById("BRO_DETAILS_LIST["+i+"].amountNowAuthorised").value));
	 }
	 if(subprogrammecode=="02")
  	 {
	   bescp+=parseFloat(isNull(document.getElementById("BRO_DETAILS_LIST["+i+"].amountNowAuthorised").value));
		//alert("suub in 1"+subprogrammecode);
	 }//alert(subprogrammecode+"  "+bescp);
	 if(subprogrammecode=="03")
	 {
	  bets+=parseFloat(isNull(document.getElementById("BRO_DETAILS_LIST["+i+"].amountNowAuthorised").value));
		//alert("suub in 1"+subprogrammecode);
	 }
	// ||document.getElementById("BRO_DETAILS_LIST["+i+"].headOfAccount").value!=""
		if(document.getElementById("BRO_DETAILS_LIST["+i+"].programmeCode").value!=""
		
		||document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimate").value!=""
		||document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").value!=""
		||document.getElementById("BRO_DETAILS_LIST["+i+"].amountAlreadyAuthorised").value!=""
		||document.getElementById("BRO_DETAILS_LIST["+i+"].amountNowAuthorised").value!=""
		||document.getElementById("BRO_DETAILS_LIST["+i+"].procedureForDrawl").value!=""
		||document.getElementById("BRO_DETAILS_LIST["+i+"].drawingOfficer").value!=""
		||document.getElementById("BRO_DETAILS_LIST["+i+"].drawingOfficer").value!="")
		{
			var be = parseInt(document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimate").value);
			totalBE += be;
			if(document.getElementById("BRO_DETAILS_LIST["+i+"].programmeCode").value=="")
			{
				alert("Please Select Programme for BRO List with S.No "+(i+1));
				document.getElementById("BRO_DETAILS_LIST["+i+"].programmeCode").focus();
				return false;
			}
			else if(document.getElementById("BRO_DETAILS_LIST["+i+"].subprogrammeCode").value=="")
			{
				alert("Please Select Sub Programme for BRO List with S.No "+(i+1));
				document.getElementById("BRO_DETAILS_LIST["+i+"].subprogrammeCode").focus();
				return false;
			}
			/*else if(document.getElementById("BRO_DETAILS_LIST["+i+"].headOfAccount").value=="")
			{
				alert("Please Enter Head Of Account for BRO List with S.No "+(i+1));
				document.getElementById("BRO_DETAILS_LIST["+i+"].headOfAccount").focus();
				return false;
			}*/
			else if(document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimate").value=="")
			{
				alert("Please Enter BudgetEstimate for BRO List with S.No "+(i+1));
				document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimate").focus();
				return false;
			}
			else if(document.getElementById("BRO_DETAILS_LIST["+i+"].selects").value=="")
			{
				alert("Please Select Center/State for BRO List with S.No "+(i+1));
				document.getElementById("BRO_DETAILS_LIST["+i+"].selects").focus();
				return false;
			}
			else if(document.getElementById("BRO_DETAILS_LIST["+i+"].quarter").value=="")
			{
				alert("Please Select Quarter for BRO List with S.No "+(i+1));
				document.getElementById("BRO_DETAILS_LIST["+i+"].quarter").focus();
				return false;
			}
			else if(document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").value=="")
			{
				alert("please Enter BudgetEstimateYear for the record with S.No."+(i+1)+".\n Format example: 2005-2006");
				document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").focus();
				return false;
			}
			else if(document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").value.length!=9)
			{
				alert("Invalid BudgetEstimateYear format for the record with S.No."+(i+1)+".\n Format example: 2005-2006");
				document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").focus();
				return false;
			}
			else if(document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").value.length==9)
			{
				var fromYear=parseInt(document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").value.substring(0,4),10);
				var toYear=parseInt(document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").value.substring(5,9),10);
				if((toYear-fromYear)!=1)
				{								
					alert("Invalid BudgetEstimateYear format for the record with S.No."+(i+1)+".\nThe difference between fromYear and toYear should be 1\n Format example: 2005-2006");
					document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimateYear").focus();
					return false;
				}
			}
			
			totalamountnowauthorized+=parseInt(document.getElementById("BRO_DETAILS_LIST["+i+"].amountNowAuthorised").value);

			
		}	
		
			
	}
		//	alert(broamount+" "+totalamountnowauthorized);
			/*if(broamount<totalamountnowauthorized)
			{
					alert(" AmountNowAuthorized SUM Exceed BRO Amount");
					return false;
			}
			else if(totalBE<totalamountnowauthorized)
			{
			 alert(" Total Budget Amount Now Authorized Exceeds Current Budget Estimate");
			 return false;
			}
			else if(beplain>gf){
			alert(" Amount Now Authorized  GF  Must Be Less Than  Budget Distribution GF ");
			return false;
			}
			else if(bescp>scp)
			{
			alert(" Amount Now Authorized  SCP  Must Be Less Than  Budget Distribution SCP ");
			return false;
			}
			else if(bets>ts)
			{
			alert(" Amount Now Authorized  TS Must Be Less Than  Budget Distribution TSP ");
			return false;
			}*/
	
	

	
		
		
	i--;
//	if(totalBE != document.forms[0].bro_budgetEstimate.value)
	//	{
	//		alert("The Total Amount is must be equal with be");
		//	document.getElementById("BRO_DETAILS_LIST["+i+"].budgetEstimate").focus();
			//return false;
		//}
	return true;
}

function initFunc()
{
	//alert("in it:");
<%if(request.getParameter("bro_reference") != null)
{
%>
		//alert("in it:1");
document.forms[0].bro_reference.value = "<%=request.getParameter("bro_reference")%>";
<%}%>
<%if(count==0){%>
document.getElementById("broProgTable").style.height=72;
<%}else{%>
document.getElementById("broProgTable").style.height=<%=((count*30)+60)%>;
<%}%>
var broamount=parseFloat(document.forms[0].bro_amount.value);
	//alert("in it:2");

}

</script>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

