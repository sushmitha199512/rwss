
<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetForm" />


<SCRIPT LANGUAGE="JavaScript">
<!--
/*function getData()
{  	
   	   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=data";
	   document.forms[0].submit();
}*/
function validateAsset()
{
	if(document.forms[0].circleOfficeCode.value==""){
     alert("Circle is required");
	 return false;
    } 
	else if(document.forms[0].divisionOfficeCode.value==""){
     alert("Division is required");
	 	 return false;
    } 
	else if(document.forms[0].subdivisionOfficeCode.value==""){
     alert("Sub Division is required");
	 	 return false;
    } 
	else if(document.forms[0].mandal.value==""){
     alert("Mandal is required");
	 	 return false;
    } 
	else if(document.forms[0].habCode.value==""){
     alert("Hab Code is required");
	 	 return false;
    } 
	else if(document.forms[0].assetTypeCode.value==""){
     alert("Asset Type is required");
	 	 return false;
    }
	else if(document.forms[0].assetName.value==""){
     alert("Asset Name is required");
	 	 return false;
    }
	else if(document.forms[0].location.value==""){
     alert("Location is required");
	 	 return false;
    }
	else if(document.forms[0].assetStatus.value==""){
     alert("Asset Status is required");
	 	 return false;
    }
	else if(document.forms[0].dateofCreation.value==""){
     alert("Date of Creation is required");
	 	 return false;
    }
	else if(document.forms[0].assetCost.value==""){
     alert("Asset Cost is required");
	 	 return false;
    }
	else
			 return true;


}
function linkagealert()
{
	var assetTypeCode = assetForm.assetTypeCode.value;
	if(assetTypeCode=='01' || assetTypeCode == '02' || assetTypeCode == '03')
	{
		//alert("ssss");
		assetForm.totPopBenfit.onmouseover = function () {Tip('Please Select Habitation Linkage',TITLE,'')}
		//assetForm.totPopBenfit.onclick = function () {Tip('Please Select Habitation Linkage',TITLE,'')}
		assetForm.totPopBenfit.onmouseout = function () {UnTip()}
	}
}
function checkDefunct()
{
	var assetStatus = assetForm.assetStatus.value;
	var assetTypeCode = assetForm.assetTypeCode.value;
//	alert(assetTypeCode);
	if(assetTypeCode=='01' || assetTypeCode == '02' || assetTypeCode == '03')
	{
		if(assetStatus == '2')
		{
			document.getElementById('defunct').style.display='block';
		}
		else
		{
			assetForm.defunctReasons.value='';
			document.getElementById('defunct').style.display='none';
		}
		assetForm.totPopBenfit.readOnly=true;
	}
}
function  backForm()
{
document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data";
document.forms[0].submit();
return true;
}

function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}

function getMissingSchemeCodes()
{
var assetTypeCode=assetForm.assetTypeCode.value;
var habCode=assetForm.habCode.value;

var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
url="switch.do?prefix=/masters&page=/Asset.do&mode=opMissingCodes&assetTypeCode="+assetTypeCode+"&habCode="+habCode;
//window.open(url,"","width=600,height=400,left=100,top=100,status=yes,scrollbars=1");
var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
newWindow = window.open(url, "_New", properties);
	
}
function funcAssetTypeCodeChanged()
{
// alert(document.forms[0].assetTypeCode.value);
 //document.forms[0].totPopBenfit.readonly = true;
 document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=assetTypeCodeChanged";
 document.forms[0].submit();
}
function getData(comp)
{
   	   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=data&component="+comp;
	   document.forms[0].submit();
} 
function getHabDirData(that)
{
	

	var field = that.name;
	
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/masters&page=/Asset.do"
			+ "&mode=circles";
	else
	if(field == 'circleOfficeCode')
	 		url = "switch.do?prefix=/masters&page=/Asset.do"
			+ "&mode=divisions";
	else
	if(field == 'divisionOfficeCode')	
			url = "switch.do?prefix=/masters&page=/Asset.do"
			+ "&mode=subdivisions";	
	else
	if(field == 'subdivisionOfficeCode')	
			url = "switch.do?prefix=/masters&page=/Asset.do"
			+ "&mode=mandals";	
	frm.action = url;
	frm.submit();

}

function getCompData(opType)
{
if(opType=="prhabs")
{
		var checkedValue=getCheckedValue(document.forms[0].elements['opType']);

		if(checkedValue=="Add New")
		document.forms[0].reset.disabled=false;
		else if(checkedValue=="Modify")
		document.forms[0].reset.disabled=true;

		var pumpCode="";
		var url="switch.do?prefix=/masters&page=/Asset.do&mode="+opType
		 
		   document.forms[0].action=url;
		   document.forms[0].submit();
}
else
{
	if(assetForm.habCode.value=="")
	{
     alert("Hab Code is required");
    } 
	else
	{
		var checkedValue=getCheckedValue(document.forms[0].elements['opType']);

		if(checkedValue=="Add New")
		document.forms[0].reset.disabled=false;
		else if(checkedValue=="Modify")
		document.forms[0].reset.disabled=true;

		var pumpCode="";
		var url="switch.do?prefix=/masters&page=/Asset.do&mode="+opType
		 
		   document.forms[0].action=url;
		   document.forms[0].submit();
	}
}
}
function check()
{
	var checkedValue=getCheckedValue(document.forms[0].elements['opType']);
	if(checkedValue=="Add New")
	document.forms[0].reset.disabled=false;
	else if(checkedValue=="Modify")
	document.forms[0].reset.disabled=true;
	
  if(!(assetForm.assetTypeCode.value=='01' || assetForm.assetTypeCode.value=='02' || assetForm.assetTypeCode.value=='03'))
  {
     document.forms[0].hablnk.disabled='true';
  }
 } 

 function checkStartYear()
 {
   if(assetForm.endYear.value!=""){
     assetForm.endYear.value="";
      return true; 
   }  
 }  
 
 function checkEndYear()
 {
	var endyr =assetForm.dateofCreation.value;
	endyr = endyr.substr(6,4);
    if(assetForm.startYear.value=="")
    {
     alert("Please Enter Start Year");
     assetForm.endYear.value="";
   }  
   else if(parseInt(endyr)<parseInt(assetForm.startYear.value))
   {
        alert("End Year Must be Either Equal to start year or greater than start year"); 
        assetForm.dateofCreation.value="";
		dateofCreation.getFocus();
        return false;
   }
   else
   {
        return true;   
   }
  }      
 
function showAsset()
{
	
    if(assetForm.circleOfficeCode.value==""){
     alert("Circle is required");
    } 
	else  if(assetForm.mandal.value==""){
     alert("Mandal is required");
    } 
	else if(assetForm.pumpCode.value=="")
		alert("Please select Asset Code");
	else
    { 
    url = "switch.do?prefix=/masters&page=/Asset.do&mode=hab&dcode="+assetForm.dcode.value+"&district="+assetForm.district.value+"&habCode="+assetForm.habCode.value+"&assetTypeCode="+assetForm.assetTypeCode.value+"&mandal="+assetForm.mandal.value;
	 window.open(url,"","width=600,height=400,left=100,top=100,scrollbars=1");
	}
} 

function showComponents(assetSubCompTypeCode,assetCompTypeCode)
{

//******************NOTE***************************************************//
//FOR SOURCE COMP TYPE PATH IS /SOURCE.DO
//FOR COMPTYPES OTHER THAN SOURCE PATH IS /ASSET.DO
//WHEN ADD & VIEW BUTTON IS PRESSED PATH IS ASSET.DO AND MODE IS 'HAB'
//WHEN SAVE BUTTON IS PRESSED MODE IS 'SAVE'
//WHEN VIEW BUTTON IS PRESSES MODE IS 'VIEW'
//WHEN ADD NEW RADIO BUTTON IS CLICKED MODE IS 'opAddNew'
//WHEN MODIFY RADIO BUTTON IS CLICKED MODE IS 'opModify'
//WHEN HABCODE COMBO VALUE IS CHANGED MODE IS 'DATA'
//WHEN ASSET TYPE COMBO VALUE IS CHANGED MODE IS 'assetTypeCodeChanged'
//WHEN ASSET CODE COMBO VALUE IS CHANGED MODE IS ''pumpCodeChanged'
//WHEN CIRCLE COMBO VALUE IS CHANGED MODE IS 'DIVISIONS'
//WHEN DIVISION COMBO VALUE IS CHANGED MODE IS 'SUBDIVISIONS'
//WHEN SUBDIVISION COMBO VALUE IS CHANGED MODE IS 'MANDALS'
//WHEN MANDAL COMBO VALUE IS CHANGED MODE IS 'PRHABS'
/////////IN THE SUBCOMPONENTS GRID/////////////////////////////////////////
//FOR SOURCE-PUMPSETS(SUBCOMPTYPE) AND PIPELINE(COMPTYPE) MODE IS 'PUMPSET'
//FOR HEADWORKS,RESERVOIRS,OTHERS-COMPTYPE MODE IS 'PARAMS'
///////////////////////////////////////////////////////////////////////////
//************************************************************************//
var habCodeInForm=assetForm.habCode.value;
if(habCodeInForm!="")
{
//alert("in showComponents()");
	  	  var assetTypeCode=assetForm.assetTypeCode.value;
    	  var habCode=assetForm.habCode.value;
      	  var coc = "<%=request.getParameter("coc")%>";
		  var habcode = "<%=request.getParameter("habCode")%>";		
	   	  var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		  var doc="<%=request.getParameter("doc")%>";
		  var sdoc="<%=request.getParameter("sdoc")%>";
		  var district="<%=request.getParameter("district")%>";
		  var mandal ="<%=request.getParameter("mandal")%>";
		  var vcode ="<%=request.getParameter("vcode")%>";
		  var pcode ="<%=request.getParameter("pcode")%>";
		  var pumpCode=assetForm.pumpCode.value;
		 

 var WindowObjectReference=null;
     if((assetTypeCode=="01" || assetTypeCode=="02" || assetTypeCode=="03") && assetCompTypeCode=="01" && assetSubCompTypeCode=="001")
    {
    	  //alert("pump code is "+pumpCode);
  		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
		url ="switch.do?prefix=/masters&page=/Source.do&assetTypeCode="+assetTypeCode+"&mode=data&pumpCode="+pumpCode+"&subCompCode=1&sourceTypeCode=1&subSourceTypeCode=1&assetCode="+assetForm.assetCode.value+"&sourceFrm=assetEntryFrm&coc="+coc+"&doc="+doc+"&sdoc="+sdoc+"&district="+coc+"&mandal="+mandal+"&habCode="+habcode+"&pcode="+pumpCode+"&vcode="+vcode;
		//alert(url);
		 WindowObjectReference = window.open(url,"_new","width=710,height=450,left=230,top=250,scrollbars=1,status=yes");
		 WindowObjectReference.focus();
		//document.forms[0].submit();
    }
    else if((assetTypeCode=="01" || assetTypeCode=="02" || assetTypeCode=="03") && assetCompTypeCode=="01" && assetSubCompTypeCode=="002")
    {
    	  //alert("hab code is "+habcode);
  		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
		url ="switch.do?prefix=/masters&page=/Source.do&mode=data&coc="+coc+"&doc="+doc+"&sdoc="+sdoc+"&district="+coc+"&mandal="+mandal+"&habCode="+habcode+"&pcode="+pumpCode+"&vcode="+vcode+"&pumpCode="+pumpCode+"&subCompCode=2&sourceTypeCode=2&subSourceTypeCode=2&assetCode="+assetForm.assetCode.value+"&sourceFrm=assetEntryFrm&assetTypeCode="+assetTypeCode;
		WindowObjectReference = window.open(url,"_new","width=710,height=450,left=230,top=250,scrollbars=1");
		WindowObjectReference.focus();
		//document.forms[0].submit();
    }
    /*else if(assetTypeCode=="01" && assetCompTypeCode=="01" && assetSubCompTypeCode=="003")
    {
  		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
		url ="switch.do?prefix=/masters&page=/Source.do?mode=data&coc="+coc+"&doc="+doc+"&sdoc="+sdoc+"&district="+coc+"&mandal="+mandal+"&habCode="+habCode+"&pcode="+pumpCode+"&vcode="+vcode+"&pumpCode="+pumpCode+"&sourceTypeCode=2&subSourceTypeCode=3";
		 window.open(url,"","width=710,height=450,left=230,top=250,scrollbars=1");
		//document.forms[0].submit();
    }*/
    else if(assetTypeCode=="01" && assetCompTypeCode=="01" && assetSubCompTypeCode=="004")
    {
  		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
		url ="switch.do?prefix=/masters&page=/Source.do?mode=data&coc="+coc+"&doc="+doc+"&sdoc="+sdoc+"&district="+coc+"&mandal="+mandal+"&habCode="+habCode+"&pcode="+pumpCode+"&vcode="+vcode+"&pumpCode="+pumpCode+"&sourceTypeCode=2&subSourceTypeCode=4";
		 WindowObjectReference = window.open(url,"_new","width=710,height=450,left=230,top=250,scrollbars=1");
		WindowObjectReference.focus();
		//document.forms[0].submit();
    }
    else if(assetTypeCode=="01" && assetCompTypeCode=="01" && assetSubCompTypeCode=="005")
    {
		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
		url ="switch.do?prefix=/masters&page=/Source.do?mode=data&coc="+coc+"&doc="+doc+"&sdoc="+sdoc+"&district="+coc+"&mandal="+mandal+"&habCode="+habCode+"&pcode="+pumpCode+"&vcode="+vcode+"&pumpCode="+pumpCode+"&sourceTypeCode=2&subSourceTypeCode=5";
		 WindowObjectReference = window.open(url,"_new","width=710,height=450,left=230,top=250,scrollbars=1");
		WindowObjectReference.focus();
		//document.forms[0].submit();
    }
	else if((assetTypeCode=="01" || assetTypeCode=="02" || assetTypeCode=="03") && assetCompTypeCode=="01" && assetSubCompTypeCode=="003")
	  {  
	  	
	  	url = "switch.do?prefix=/masters&page=/Asset.do&mode=pumpset&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value;
		 WindowObjectReference=window.open(url,"_new","width=950,height=450,left=80,top=100,scrollbars=1,status=yes");
	  	WindowObjectReference.focus();
	  }
	  else if((assetTypeCode=="01" || assetTypeCode=="02" || assetTypeCode=="03") && assetCompTypeCode=="06" && assetSubCompTypeCode=="001")
	  {  
	  	
	  	url = "switch.do?prefix=/masters&page=/Asset.do&mode=pumpset&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value;
		 WindowObjectReference=window.open(url,"_new","width=950,height=450,left=80,top=100,scrollbars=1,status=yes");
	  	WindowObjectReference.focus();
	  }
	/*
	else if((assetTypeCode=="01"||assetTypeCode=="02"||assetTypeCode=="03") && assetCompTypeCode=="01" && assetSubCompTypeCode=="009")
	 {  //alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
		 url = "switch.do?prefix=/masters&page=/Asset.do&mode=pumpset&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value;
		 WindowObjectReference = window.open(url,"_new","width=950,height=450,left=80,top=100,scrollbars=1,status=yes");
	  	WindowObjectReference.focus();
	  }
	 */
  /*  else if(assetTypeCode=="01" && assetCompTypeCode=="03" && assetSubCompTypeCode=="003")
    {	//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
        // url = "switch.do?prefix=/masters&page=/RWS_PWS_PM.html";
		// window.open(url,"","width=670,height=330,left=230,top=100,scrollbars=1");
		url = "switch.do?prefix=/masters&page=/Asset.do&mode=pumpset&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value;
		 window.open(url,"","width=850,height=180,left=40,top=250,scrollbars=1");
    }*/
     //**********FOR PIPELINE**************//
     else if((assetTypeCode=="03" || assetTypeCode=="02" || assetTypeCode=="01" ) && assetCompTypeCode=="03" )
   {	//alert("in pipeline");
   		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
        // url = "switch.do?prefix=/masters&page=/cpws_pumpingmains.html";
		// window.open(url,"","width=610,height=350,left=230,top=250,scrollbars=1");
		url = "switch.do?prefix=/masters&page=/Asset.do&mode=pumpset&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value;
		 WindowObjectReference = window.open(url,"_new","width=950,height=220,left=40,top=100,scrollbars=1,status=yes");
    	WindowObjectReference.focus();
    }
    //***************FOR OTHERS****************/
     else if((assetTypeCode=="01"||assetTypeCode=="02"||assetTypeCode=="03") && assetCompTypeCode=="05" && assetSubCompTypeCode=="001")
    {	//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
        // url = "switch.do?prefix=/masters&page=/cpws_pumpdetails.html";
		// window.open(url,"","width=650,height=270,left=230,top=250,scrollbars=1");
	 	 //alert("aaa");
	 	 url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value;
		 WindowObjectReference = window.open(url,"_new","width=950,height=250,left=40,top=100,scrollbars=1,status=yes");
    	WindowObjectReference.focus();
    }
    //*******************FOR CHLORINATION*************//
    else if((assetTypeCode=="01"||assetTypeCode=="02"||assetTypeCode=="03") && assetCompTypeCode=="05" && assetSubCompTypeCode=="002")
    {	//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
        // url = "switch.do?prefix=/masters&page=/cpws_pumpdetails.html";
		// window.open(url,"","width=650,height=270,left=230,top=250,scrollbars=1");
	 	 //alert("aaa");
	 	 url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value;
		 WindowObjectReference = window.open(url,"_new","width=950,height=250,left=40,top=100,scrollbars=1,status=yes");
    	WindowObjectReference.focus();
    }
    //**************FOR RESERVOIRS***************//
    else if(assetTypeCode=="04" && assetCompTypeCode=="01" && assetSubCompTypeCode=="001")
    {	//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
     //  url = "switch.do?prefix=/masters&page=/cpws_pumpdetails.html";
		// window.open(url,"","width=650,height=270,left=230,top=250,scrollbars=1");
		//code modified by pranavi
	 	 url = "switch.do?prefix=/masters&page=/Asset.do&mode=pumpset&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value+"&location="+document.forms[0].location.value;
		 WindowObjectReference = window.open(url,"_new","width=950,height=360,left=40,top=100,scrollbars=1");
    	WindowObjectReference.focus();
    }
    //*************FOR ASSET TYPES OTHER THAN CPWS,MPWS,CPWS,HANDPUMPS
     else if((assetTypeCode=="05"||assetTypeCode=="06"||assetTypeCode=="07"||assetTypeCode=="08") && assetCompTypeCode=="01" && assetSubCompTypeCode=="001")
	  {  //alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
	         //code modified by pranavi
			 url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value+"&dcode="+assetForm.dcode.value+"&mandal="+mandal+"&district="+assetForm.district.value+"&location="+document.forms[0].location.value;
			 //alert(url);
			 WindowObjectReference = window.open(url,"_new","width=950,height=250,left=40,top=250,scrollbars=1,status=yes");
		
			WindowObjectReference.focus();
		}
		
     /*else if(assetTypeCode=="03" && assetCompTypeCode=="01" && assetSubCompTypeCode=="001")
    {
   		//alert("sadiqali");
		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);	   
		url ="switch.do?prefix=/masters&page=/Source.do?mode=data&coc="+coc+"&doc="+doc+"&sdoc="+sdoc+"&district="+coc+"&mandal="+mandal+"&habCode="+habCode+"&pcode="+pumpCode+"&vcode="+vcode+"&sourceTypeCode=1&subSourceTypeCode=1";
		 window.open(url,"","width=710,height=450,left=230,top=250,scrollbars=1");
		//document.forms[0].submit();
    }*/
     /*else if(assetTypeCode=="03" && assetCompTypeCode=="01" && assetSubCompTypeCode=="002")
    {
   		//alert("sadiqali");
		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);	   
		url ="switch.do?prefix=/masters&page=/Source.do?mode=data&coc="+coc+"&doc="+doc+"&sdoc="+sdoc+"&district="+coc+"&mandal="+mandal+"&habCode="+habCode+"&pcode="+pumpCode+"&vcode="+vcode+"&sourceTypeCode=1&subSourceTypeCode=2";
		 window.open(url,"","width=710,height=450,left=230,top=250,scrollbars=1");
		//document.forms[0].submit();
    }*/
     /*else if(assetTypeCode=="03" && assetCompTypeCode=="01" && assetSubCompTypeCode=="003")
    {
   		//alert("sadiqali");
		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);	   
		url ="switch.do?prefix=/masters&page=/Source.do?mode=data&coc="+coc+"&doc="+doc+"&sdoc="+sdoc+"&district="+coc+"&mandal="+mandal+"&habCode="+habCode+"&pcode="+pumpCode+"&vcode="+vcode+"&sourceTypeCode=2&subSourceTypeCode=3";
		 window.open(url,"","width=710,height=450,left=230,top=250,scrollbars=1");
		//document.forms[0].submit();
    }*/
      /*
      else if(assetTypeCode=="03" && assetCompTypeCode=="01" && assetSubCompTypeCode=="004")
    {
   		//alert("sadiqali");
		//alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);	   
		url ="switch.do?prefix=/masters&page=/Source.do?mode=data&coc="+coc+"&doc="+doc+"&sdoc="+sdoc+"&district="+coc+"&mandal="+mandal+"&habCode="+habCode+"&pcode="+pumpCode+"&vcode="+vcode+"&sourceTypeCode=2&subSourceTypeCode=4";
		 WindowObjectReference = window.open(url,"_new","width=710,height=450,left=230,top=250,scrollbars=1");
		//document.forms[0].submit();
    	WindowObjectReference.focus();
    }
    */
    
	
   /* else if((assetTypeCode=="01" || assetTypeCode=="04" )&& assetCompTypeCode=="01" && assetSubCompTypeCode=="001")
	  {  //alert("assetTypeCode=" +assetTypeCode+" assetCompTypecode="+assetCompTypeCode+"assetSubCompTypeCode="+assetSubCompTypeCode);
		 url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value;
		 window.open(url,"","width=950,height=330,left=80,top=100,scrollbars=1");
	  }*/
	 
      else {
     
	     if(assetSubCompTypeCode=="" ){
			 alert("Please Select Asset Sub Component");
	 			}
	  	  //************************FOR HEADWORKS AND RESERVIORS************//
	  	  else{
			   //alert("^^^^^^^^^^^");
			   //alert("assetCode=" +assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value+"&dcode="+assetForm.dcode.value+"&mandal="+mandal+"&district="+assetForm.district.value);
	  	   	 url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value+"&dcode="+assetForm.dcode.value+"&mandal="+mandal+"&district="+assetForm.district.value;
			 WindowObjectReference =  window.open(url,"_new","width=950,height=250,left=40,top=250,scrollbars=1,status=yes");
			WindowObjectReference.focus();
			//window.open(url,"mywindow","width=400,height=200,toolbar=yes,location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,copyhistory=yes,resizable=yes");
	  } 
    }
    }else{
    alert("Please Select HabCode");
    }
   }
 function viewfun()
 {
  var message="";
  if(assetForm.circleOfficeCode.value=="")
     message=message+"Circle is required\n";
  if(assetForm.divisionOfficeCode.value=="")
     message=message+"Division is required\n";
  if(assetForm.subdivisionOfficeCode.value=="")
     message=message+"Sub Division is required\n";
  if(assetForm.mandal.value=="")
     message=message+"Mandal is required\n";
  if(message=="")
     return true;     
   else{
    alert(message);
    return false;
   } 
}
//-->
</SCRIPT>

<%@ include file="/commons/rws_header2.jsp" %>

<body id="docBody" onload="check();checkDefunct();linkagealert()">
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>

<html:form action="Asset.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Asset Entry Form" />
	<jsp:param name="TWidth" value="800"/>
	<jsp:param name="contextHelpUrl" value="/pred/help/assethelp.doc" />
</jsp:include>

<table align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1" style="border-collapse:collapse;" width="764" >	
<tr>
	<td class="mycborder">
		<fieldset>
		<legend><bean:message key="legend.rwsOffices"/></legend>
		<label>
		
	<table border=0 width="830">
	<tr>
		<td class="textborder"><bean:message key="app.headoffice" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder" >
		<logic:equal name="RWS_USER" property="headOfficeCode" value="0">
			<html:select property="headOfficeCode" style="width:140px"   onchange="javascript: getHabDirData(this)"	 styleClass="mycombo">
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<html:options collection="headOffices" name="labelValueBean" property="value" labelProperty="label" />
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
				<html:text property="headOfficeName" style="width:140px"  styleClass="mytext" name="RWS_USER" readonly="true"/>
				<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual>
		</td>
		<td class="textborder">
			<bean:message key="app.circle" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode"   style="width:140px" onchange="javascript: getHabDirData(this)" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="mytext" style="width:140px" name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
	</tr>
	<tr>
		<td class="textborder"><bean:message key="app.division" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder">
		<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:select property="divisionOfficeCode"  onchange="javascript: getHabDirData(this)" styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:text property="divisionOfficeName" styleClass="mytext" style="width:140px" name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		<td class="textborder">
		<bean:message key="app.subdivision" />
		<span class="mandatory">*</span>
		</td>
		<td class="textborder">
		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subdivisionOfficeCode" styleClass="combo"  onchange="javascript: getHabDirData(this)">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" styleClass="mytext" style="width:140px" name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
	</tr>
	
	</table>
	</label>
	</fieldset>
			
	<fieldset>
	<legend >Habitation Details</legend>
	<label>
	<table border=0 width="100%">
	<tr>
		<td><div id="load"></div><td>
	</tr>
		<tr>
			 
		 	<td class="textborder"  >
		 	<bean:message key="app.district" /><font color="#FF6666">*</font></td>
             <td class="textborder" >
         	<html:text property="district" style="width:140px" value="<%=(String)session.getAttribute(\"distName\")%>" styleClass="mytext"  readonly="true" />
           	<html:hidden property="dcode" />
           	</td>
			<td class="textborder" >
				<bean:message key="app.mandal" /><font color="#FF6666">*</font>
			</td>
			<td class="bwborder" >
				<html:select property="mandal" styleClass="mycombo" style="width:140px" onchange="javascript:getCompData('prhabs')" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
				</html:select>
			</td>
			
			<TD class="textborder">
				<bean:message key="app.habCode" /><font color="#FF6666">*</font>
			</TD>
		    <TD colspan=3 class="bwborder">
		    	<html:select property="habCode" styleClass="mycombo" style="width:280px"  onchange="javascript:getData('habitationChanged')">
				<html:option value="">SELECT...</html:option>
				<html:options collection="prhabs" name="rwsLocationBean" property="habCode" labelProperty="habName" />
				</html:select>
				
			</TD>
		</tr>
		</table>
	</label>
			</fieldset>
			<fieldset>
			<legend  >Asset Details</legend>
			<label>
			<table  border=0  width="100%">
				<tr>
					<TD class="textborder"  nowrap>
					
						<bean:message key="app.assetTypeCode" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
					    <html:select property="assetTypeCode" styleClass="mycombo" 
					    			 style="width:123px" onchange="javascript:funcAssetTypeCodeChanged()">
						<html:option value="">SELECT...</html:option>
						<html:options collection="assetTypes" name="commonLists" 
									  property="value" labelProperty="label" />
						</html:select>
						
					</TD>
					
					 <bean:define id="selectedOpType" property="opType" name="assetForm"/>
					<logic:notEmpty name="opType">
				      	 			  
 					<TD class="textborder"  nowrap>
						Type<font color="#FF6666">*</font>
					</TD>
					<TD class="bwborder">
					    <input type="radio" name="opType"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getCompData('opAddNew')" value="Add New" /><font size="1" face="verdana"><b>&nbsp;Add New</b></font> &nbsp;&nbsp;
 				        <input type="radio" name="opType"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getCompData('opModify')" value="Modify" /><font size="1" face="verdana"><b>&nbsp;Modify</b></font> 				        
		             </TD> 
		            </logic:notEmpty>   
		               <script type="text/javascript">
					   
					   var i;
        			   var opType = '<bean:write name="selectedOpType"/>';
           			   if(opType=="")
           			    i=1;
           			   else
           			    for(i=1;i<=document.forms[0].elements.length;i++)
           			    {
           			    	if(document.forms[0].elements[i])
           			    	{
							     if(document.forms[0].elements[i].name!=null) 
							     {
	           			             if(document.forms[0].elements[i].name=="opType")
	           			             {
	           			               if(document.forms[0].elements[i].value==opType)
	           			                 document.forms[0].elements[i].checked=true;
	           			              }
	           			         }
           			         } 
           			          
					   }
					   
					 </script>
		               
		               
					  <!--  <TD class="textborder">
						<bean:message key="app.assetCode" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
			    	<html:text property="assetCode" value=""
		    			   styleClass="mytext" maxlength="14" readonly="true"/>
				    </TD>
				    
				     -->
				     <input type="hidden" name="assetCode"  value="<%=(String)session.getAttribute("assetCode")%>"  >
				     
				    <TD class="textborder" nowrap >
				   
					
					Asset Code<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    
				     <c:if test="${selectedOpType==''}">
				     <html:select property="pumpCode" styleClass="mycombo" 
					    			 style="width:80px" onchange="javascript:getData('pumpCodeChanged')">
						<html:option value="">SELECT...</html:option>
						<html:options collection="schemeCodes" name="commonLists" 
									  property="value" labelProperty="label" />
						</html:select>
					</c:if>	
				     <c:if test="${selectedOpType=='notSelected'}">
				    <%//System.out.println("in modify"); %>
				   
					 	<html:select property="pumpCode" styleClass="mycombo" 
					    			 style="width:80px" onchange="javascript:getData('pumpCodeChanged')">
						<html:option value="">SELECT...</html:option>
						<html:options collection="schemeCodes" name="commonLists" 
									  property="label" labelProperty="label" />
						</html:select>
						
					</c:if>
				    <c:if test="${selectedOpType=='Modify'}">
				    <%//System.out.println("in modify"); %>
				 
					 <html:select property="pumpCode" styleClass="mycombo" 
					    			 style="width:80px" onchange="javascript:getData('pumpCodeChanged')">
						<html:option value="">SELECT...</html:option>
						<html:options collection="schemeCodes" name="commonLists" 
									  property="label" labelProperty="label" />
						</html:select>
						
					</c:if>
					 <c:if test="${selectedOpType=='Add New'}">
					 <%//System.out.println("in add new"); %>
					
					 <html:text property="pumpCode"  
				    			   styleClass="mytext" maxlength="3" style="width:80px" readonly="true"
				     />
					<!-- <a href="#1" onclick="getMissingSchemeCodes()">Missing Codes</a> -->
					<input type="button" title="Click to select Missed Code" class="btext" value="..." onclick="getMissingSchemeCodes()"> 
					</c:if>
					</TD>		    
					
				</tr>
				 
				<tr>
				 
						
					<TD class="textborder" nowrap >
						<bean:message key="app.assetName" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				   
				    	<html:text property="assetName"  
				    			   styleClass="mytext" maxlength="25" style="width:210px" onkeypress="upperOnly()"/>
				    </TD>
				     <TD class="textborder">
				     
						<bean:message key="app.location" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="location"   
				    			   styleClass="mytext" maxlength="25" onkeypress="upperOnly()"/>
				    </TD>
					 <TD class="textborder" colspan="2">Asset Status<font color="#FF6666">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
						 	<html:select property="assetStatus" styleClass="mycombo" style="width:110px" onchange="checkDefunct()">
							<html:option value="">SELECT...</html:option>
							<%if(request.getParameter("assetTypeCode")!=null && (request.getParameter("assetTypeCode").equals("03") || request.getParameter("assetTypeCode").equals("01"))){ %>
								<html:option value="1">WORKING</html:option>
								<html:option value="2">DEFUNCT</html:option>
							<%}else
							{ %>
							<html:option value="1">WORKING</html:option>
							<html:option value="2">NOT WORKING</html:option>
							<html:option value="3">DRIED</html:option>
							<html:option value="4">SEASONAL</html:option>
							<html:option value="5">CONDEMED</html:option>
							<%} %>
							</html:select>
							<div id="defunct" style="display:none">
								Reasons&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<html:select property="defunctReasons" styleClass="mycombo" style="width:110px">
								<html:option value="">SELECT...</html:option>
								<html:option value="1">Source Failure</html:option>
								<html:option value="2">Power Failure</html:option>
								<html:option value="3">Others</html:option>
								</html:select>
							</div>
						</td>	
					
				</tr>
				<tr>
					<TD class="textborder">
						<bean:message key="app.startYear" /><font color="#FF6666"></font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="startYear" styleClass="mytext"   maxlength="4" style="width:60px" /><!-- onkeypress="return decimalsOnly(event)" onblur="return checkStartYear()" -->
				    </TD>
					
					<TD class="textborder"   >
						<bean:message key="app.dateofCreation" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="dateofCreation"   
				    			   styleClass="mytext" style="width:80px" readonly="true"  />
						<a href="javascript: showCalendar(document.assetForm.dateofCreation);" ><IMG SRC="<rws:context page='/images/calendar.gif'/>" 
						   width="20" border="0" height="17" align="absmiddle"></a>
					</TD>
					<TD class="textborder"  >
						<bean:message key="app.assetCost" />(Rs. in Lakhs)<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="assetCost" styleClass="mytext"   maxlength="10" style="width:70px" onkeypress="return decimalsOnly(event)"  />&nbsp;
				    </TD>
				    
				   
				</tr>
				<tr>
				<td class="textborder" colspan=2 nowrap>
					<fieldset>
					<legend >Habitation Linkage</legend>
					<label>
					<table  width="90%" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse">
						<tr>
						<td class="textborder">
							Habitations &nbsp;<input type="button" name="hablnk" value="Add/Remove" style="width:100px;height:20px" onclick="showAsset()">
						</td>
						</tr>
					</table>
					</td>
				 <TD class="textborder">
						<bean:message key="app.habbenfit" />
					</TD>
				    <TD class="bwborder">
						<html:text property="totHabs" styleClass="mytext"   maxlength="10" style="width:60px" onkeypress="return decimalsOnly(event)" readonly="true"/>
					</TD> 
				 <TD class="textborder">
						<bean:message key="app.popbenfit" />
					</TD>
				    <TD class="bwborder">
						<html:text property="totPopBenfit" styleClass="mytext"   maxlength="10" style="width:60px" onkeypress="return decimalsOnly(event)"  onmouseover="linkagealert()"/>
					</TD> 
								
					<!-- <TD class="textborder">
						<bean:message key="app.endYear" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
						<html:text property="endYear" styleClass="mytext"   maxlength="4" style="width:60px" onkeypress="return decimalsOnly(event)" onblur="return checkEndYear()" />
					</TD> -->
					
					<tr> 
 					<tD colspan=8>
					
				
				<c:if test="${selectedOpType=='Modify' or selectedOpType=='Add New'}" >

				<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
				 <logic:present name="assetCompTypes" scope="session">	
				<tbody>

				<tr>
			    <td  bgcolor="#8A9FCD">
		        <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Asset Components</font>
				</td>
				</tr>
				</tbody>
				</logic:present>
				
			 <logic:present name="assetCompTypes" scope="session">
			<tr><td>
			<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
			<thead class="gridHeader">
			 <tr bgcolor="#8A9FCD" >
			 <c:forEach items="${assetCompTypes}" var="item" varStatus="status">
		    <th colspan=2> 
		    
		    
        	 <font size="1" face="verdana" color="black"><b>&nbsp;<c:out value='${item.label}' /></b></font>
			</th> 
			 </c:forEach>
		    </tr>
		   </thead>
		   <tr>
		    <c:forEach items="${assetCompTypes}" var="item" varStatus="status">
		    <td align="center" width="20%"><font size="1" face="verdana" color="black"><b>Name</b></font></td>
		    <td align="center" width="10%"><font size="1" face="verdana" color="black"><b>No</b></font></td>
		    </c:forEach>
		    </tr>
    
	    <tr>
    	 <logic:present name="sources" scope="session">
	     <%//System.out.println("ff"); %>
    	 <td colspan=2 valign="top">
	     <table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
		 <c:forEach items="${assetCompTypes}" var="item" varStatus="status">
	     <c:set var="compName" value="${item.label}"/>
         <c:if test="${compName == 'SOURCE'}">
            <c:set var="assetCompTypeCode" value="${item.value}"/>
        </c:if>
      </c:forEach>  
     <input type="hidden" name="assetCompTypeCode" value="<c:out value='${assetCompTypeCode}' />">
	  <c:forEach items="${sources}" var="item" varStatus="status">
      <tr>
       <td width="23%"> 
       <input type="hidden" name="assetSubCompTypeCode" value="<c:out value='${item.value}' />">
       <a href="#1" id="black" onclick="javascript:showComponents('<c:out value='${item.value}' />','<c:out value='${assetCompTypeCode}' />')" ><font size="1" face="verdana" color="black"><b>&nbsp;<c:out value='${item.label}' /></b></font></a>
       </td>
       <td width="10%"><input type="text" name="sourceCount" class="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)" value="<c:out value="${item.count}"/> " ></td>
      </tr> 
      </c:forEach>
      
     
     </table>
      </td>
       </logic:present> 
       
     <logic:present name="headWorks" scope="session">  
     <td colspan=2 valign="top"> 
     <table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	  <c:forEach items="${assetCompTypes}" var="item" varStatus="status">
	     <c:set var="compName" value="${item.label}"/>
         <c:if test="${compName == 'HEADWORKS'}">
          <c:set var="assetCompTypeCode" value="${item.value}"/>
        </c:if>
      </c:forEach>  
      <input type="hidden" name="assetCompTypeCode" value="<c:out value='${assetCompTypeCode}' />">
     <tbody>
      <c:forEach items="${headWorks}" var="item" varStatus="status">
      <tr>
       <td width="23%">
               <input type="hidden" name="assetSubCompTypeCode" value="<c:out value='${item.value}' />">
       <a href="#1" id="black" onclick="javascript:showComponents('<c:out value='${item.value}' />','<c:out value='${assetCompTypeCode}' />')" ><font size="1" face="verdana" color="black"><b>&nbsp;<c:out value='${item.label}' /></b></font></a>
       </td>
       <td width="10%"><input type="text" name="headworksCount" class="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)" value="<c:out value="${item.count}"/> " ></td>
      </tr> 
      </c:forEach>
     </tbody>
    
     </table>
     </td>
      </logic:present> 
      <logic:present name="pipeLine" scope="session">
      <td colspan=2 valign="top">
     <table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	  <c:forEach items="${assetCompTypes}" var="item" varStatus="status">
	     <c:set var="compName" value="${item.label}"/>
         <c:if test="${compName == 'PIPELINE'}">
          <c:set var="assetCompTypeCode" value="${item.value}"/>
        </c:if>
      </c:forEach>  
    
            <input type="hidden" name="assetCompTypeCode" value="<c:out value='${assetCompTypeCode}' />">
      <c:forEach items="${pipeLine}" var="item" varStatus="status">
      <tr>
       <td width="23%">
               <input type="hidden" name="assetSubCompTypeCode" value="<c:out value='${item.value}' />">
       <a href="#1" id="black" onclick="javascript:showComponents('<c:out value='${item.value}' />','<c:out value='${assetCompTypeCode}' />')" ><font size="1" face="verdana" color="black"><b>&nbsp;<c:out value='${item.label}' /></b></font></a>
       </td>
       <td width="10%"><input type="text" name="pipelineCount" class="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)" value="<c:out value="${item.count}"/> " ></td>
      </tr> 
      </c:forEach>
      
   
     </table>
      </td>
        </logic:present> 
     <logic:present name="resorvior" scope="session">
     <td colspan=2 valign="top">
     <table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	 
      <c:forEach items="${assetCompTypes}" var="item" varStatus="status">
	     <c:set var="compName" value="${item.label}"/>
         <c:if test="${compName == 'RESERVOIRS' || compName == 'SR. RESERVOIRS'}">
          <c:set var="assetCompTypeCode" value="${item.value}"/>
        </c:if>
      </c:forEach>  
            <input type="hidden" name="assetCompTypeCode" value="<c:out value='${assetCompTypeCode}' />">
      <c:forEach items="${resorvior}" var="item" varStatus="status">
      <tr>
       <td width="23%">
              <input type="hidden" name="assetSubCompTypeCode" value="<c:out value='${item.value}' />">
       <a href="#1" id="black" onclick="javascript:showComponents('<c:out value='${item.value}' />','<c:out value='${assetCompTypeCode}' />')" ><font size="1" face="verdana" color="black"><b>&nbsp;<c:out value='${item.label}' /></b></font></a>
       </td>
       <td width="10%"><input type="text" name="reservoirCount" class="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)" value="<c:out value="${item.count}"/> " ></td>
      </tr> 
      </c:forEach>
      
    
     </table>
      </td>
       </logic:present> 
     <logic:present name="pumpsets" scope="session">
     <td colspan=2 valign="top">
     <table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	  <c:forEach items="${assetCompTypes}" var="item" varStatus="status">
	     <c:set var="compName" value="${item.label}"/>
	      <c:if test="${compName == 'OTHERS'}">
          <c:set var="assetCompTypeCode" value="${item.value}"/>
        </c:if>
      </c:forEach>  
             <input type="hidden" name="assetCompTypeCode" value="<c:out value='${assetCompTypeCode}' />">
   
      <c:forEach items="${pumpsets}" var="item" varStatus="status">
      <tr>
       <td width="23%">
       <input type="hidden" name="assetSubCompTypeCode" value="<c:out value='${item.value}' />">
       <a href="#1" id="black" onclick="javascript:showComponents('<c:out value='${item.value}' />','<c:out value='${assetCompTypeCode}' />')" ><font size="1" face="verdana" color="black"><b>&nbsp;<c:out value='${item.label}' /></b></font></a>
       </td>
       <td width="10%"><input type="text" name="pumpsetCount" class="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)" value="<c:out value="${item.count}"/> " ></td>
      </tr> 
      </c:forEach>
      

     </table>
      </td>
     </logic:present>      
	 <%
		String typeOfAsset = request.getParameter("assetTypeCode");
		if(typeOfAsset.equals("01") || typeOfAsset.equals("02") || typeOfAsset.equals("03"))
		{
	 %>
     <logic:present name="pumping" scope="session">
     <td colspan=2 valign="top">
     <table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	  <c:forEach items="${assetCompTypes}" var="item" varStatus="status">
	     <c:set var="compName" value="${item.label}"/>
	      <c:if test="${compName == 'PUMPING'}">
          <c:set var="assetCompTypeCode" value="${item.value}"/>
        </c:if>
      </c:forEach>  
             <input type="hidden" name="assetCompTypeCode" value="<c:out value='${assetCompTypeCode}' />">
   
      <c:forEach items="${pumping}" var="item" varStatus="status">
      <tr>
       <td width="23%">
       <input type="hidden" name="assetSubCompTypeCode" value="<c:out value='${item.value}' />">
       <a href="#1" id="black" onclick="javascript:showComponents('<c:out value='${item.value}' />','<c:out value='${assetCompTypeCode}' />')" ><font size="1" face="verdana" color="black"><b>&nbsp;<c:out value='${item.label}' /></b></font></a>
       </td>
       <td width="10%"><input type="text" name="pumpsetCount" class="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)" value="<c:out value="${item.count}"/> " ></td>
      </tr> 
      </c:forEach>
      

     </table>
      </td>
     </logic:present> 
	 <%}%>
           </tr> 
      
      </table>
			</td>
			</tr>
     	 </logic:present>
			</table>
	</c:if>
		    </td>
			</tr>
			  </td>
 				</tr>
 		
					</label>
					</fieldset>
					</td>
				
				</tr>
			</table>
			</label>
			</fieldset>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
		<%-- %>
			<% 
			  String returnVal=(String)session.getAttribute("returnVal");
			  //System.out.println("return Value"+returnVal);
			if(returnVal!=null && returnVal.equals("yes"))
			{%>
			  <html:submit property="mode" title="Add an Asset" styleClass="btext" value="Save Source"  />
<!-- 		  <input type="button" Class="btext" value="Back" title="Water Sample Collection Form" style="width:80px" onclick="return backForm();"/> -->
			<%}else 
			  {%> <%} %>--%>
			  <!-- <html:submit property="mode" title="Save an Asset" styleClass="btext" value="Save" onclick="return validateAssetForm(assetForm)" /> -->
			  <html:submit property="mode" title="Save an Asset" styleClass="btext" value="Save" onclick="return validateAsset()" />
			  <html:reset property="reset" title="Clear all the Fields" styleClass="btext" value="Reset" />
			  <html:submit property="mode" title="View the Assets" styleClass="btext" value="View" onclick="return viewfun()" />
			</td>
		</tr>
	</table>
	
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="800" />
</jsp:include>
<br>
<logic:notEmpty property="assetHabs" name="assetForm"> 
<% int count=1; %>	
	<nested:iterate id="ASSETHAB_LIST" property="assetHabs">
     	<%count=count+1; %>
    </nested:iterate>

<table width="580" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
<td colspan=2 align=left><b>Habatitaions in Asset</b>
</td>
</tr>
<tr bgcolor="#8A9FCD">
	<th colspan="2" align="left">
		Total No. of Habitations:&nbsp;<%= (count-1)%> 
	</th>
</tr>
 <tr bgcolor="#8A9FCD">
	<td class="textborder" align=center>
	 <bean:message key="app.panchCode" /></td>
	<td class="textborder" align=center>
	 <bean:message key="app.panchName" /></td>
	</tr>
</thead>
<tbody class="gridText">
 <% count=1; %>	
	<nested:iterate id="ASSETHAB_LIST" property="assetHabs">
   <tr class="row<%=count%2%>">
 	<%count=count+1; %>
	<td  class=bwborder align=center>
	<bean:write name="ASSETHAB_LIST" property="habCode" />
	</td>
	<td  class=bwborder align=left>
	<bean:write name="ASSETHAB_LIST" property="habName" />
	</td>
	</tr>
	</nested:iterate>
</tbody>
</table>
</logic:notEmpty>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%
if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
	// System.out.println("water sample ");
	 String water=(String)session.getAttribute("water");
	// System.out.println("water sample "+water +" "+(water!=null) +" "+water.equals("water"));
	 
	 //String returnVal=(String)session.getAttribute("returnVal");
	 if(water!=null && water.equals("water"))
	 {
	// System.out.println("setsession values null ");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	window.close();
	</script>
<%  }
 else
 {
 %>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	</script>
<%
 }
 }
				
%>



