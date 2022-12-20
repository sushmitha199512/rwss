
<%@ include file="/commons/rws_header1.jsp" %>
<%///System.out.println("in Colllllllllllection"); 
//System.out.println("hhhhhhhhhhhhhhhh:"+request.getParameter("getcheck"));%>
<html:javascript formName="waterSampleForm" /> 

<%

java.util.ArrayList wqlist = new java.util.ArrayList();

wqlist = (java.util.ArrayList)request.getAttribute("wqlist");

if(wqlist==null || wqlist.size()<1)
{ 
	wqlist = new java.util.ArrayList(18);
	for(int i=0;i<18;i++)
	{
		wqlist.add(i,"N");
	}
	
}
%>

<SCRIPT LANGUAGE="JavaScript">

 function checkDiv()
{
	 if(document.forms[0].contamin.value=="YES")
	{
		document.getElementById('submission').display='none';
	}
	else if(document.forms[0].contamin.value=="NO")
	{
			document.getElementById('submission').display='block';
	}
	
}
function checkforward(){
if(document.forms[0].forwarded.value=="YES"){


if(document.forms[0].ftklab[0].checked==true){

// alert(document.forms[0].forwardDate.value);
if(document.forms[0].forwardDate.value.length<10 && document.forms[0].ftkTestDate.value.length>8){

//alert("in this loop");
}
else if(document.forms[0].forwardDate.value.length>8 && document.forms[0].forwarded.value=="YES")
{
var sourceTypeCode=document.forms[0].forwardedsrcType.value;
var sourceCode=document.forms[0].forwardedsrcCode.value;
var ftktestid=document.forms[0].forwardedftkid.value;
var mcode=document.forms[0].forwardedmcode.value;
var pcode=document.forms[0].forwardedpcode.value;
var hcode=document.forms[0].forwardedhcode.value;
alert("Forwarded to Lab");
document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=forwardtolab&ftklab=lab&sourceTypeCode="+sourceTypeCode+"&sourceCode="+sourceCode+"&ftktestid="+ftktestid+"&mandalCode="+mcode+"&panchayatCode="+pcode+"&habCode="+hcode;
document.forms[0].submit();
}
}
} 
}

function checkforward1(S) {

	 if(document.getElementById("fdate").style.display=='none') 
                 {
                     document.getElementById("fdate").style.display = "";
                  }
	else if(document.getElementById("fdate").style.display=='') 
                 {
                     document.getElementById("fdate").style.display = "none";
                  }
    if(document.getElementById("fcal").style.display=='none') 
                 {
                     document.getElementById("fcal").style.display = "";
                  }
	else if(document.getElementById("fcal").style.display=='') 
                 {
                     document.getElementById("fcal").style.display = "none";
                  }
                 
    var ele = document.getElementById("forwarddate");
		if(ele.style.display == "none") {
    		ele.style.display = "";
    		}
    		else if(ele.style.display == "") {
    		ele.style.display = "none";
    		}
      
	}
/*function check()
{
if(document.forms[0].ftklab[0].checked==false && document.forms[0].ftklab[1].checked==false){
document.getElementById('mode1').disabled = false;

}
else if(document.forms[0].ftklab[1].checked==true){


if(document.forms[0].circleOfficeCode.value == "")
{
	 document.getElementById('mode1').disabled = false;
}
}
else if(document.forms[0].circleOfficeCode.value == "" || document.forms[0].mandalCode.value == "" || document.forms[0].panchayatCode.value == "" || document.forms[0].habCode.value == "" || document.forms[0].sourceType.value == "" || document.forms[0].sourceCode.value == "" || document.forms[0].contamin.options[document.forms[0].contamin.options.selectedIndex].text!="YES"){

document.getElementById('mode1').disabled = false;
                 
} else if(document.forms[0].contamin.options[document.forms[0].contamin.options.selectedIndex].text=="YES"){

	document.getElementById('mode1').disabled = false;}
}*/
function valdate(){
   // alert("#######"); 
var flag="false";
		var c=document.forms[0].ftkTestDate.value;				
		var y=parseInt(c.substring(6,10));
		var d=parseInt(c.substring(0,2));
		var m=(c.substring(3,5));
				//alert("1");
		var a=document.forms[0].sysdate.value;
		var y2=parseInt(a.substring(6,10));
		var d2=parseInt(a.substring(0,2));
		var m2=(a.substring(3,5));
	// alert("2");
		var date1 = new Date(y, m, d); 
		
		
		var date3=new Date(y2,m2,d2);
		if(date3<date1)
		{
		 alert("Test Date must be less than or equal to Current date");		
	     return flag;
		}
		/*var b=document.forms[0].forwardDate.value;
		
		if(document.forms[0].forwardDate.value!=""){
		var y1=parseInt(b.substring(6,10));
		var d1=parseInt(b.substring(0,2));
		var m1=(b.substring(3,5));
		var date2=new Date(y1,m1,d1);
		alert(date2);
				alert(date3);
		if(date3<date2)
		{
	    	alert("Forward Date must be less than or equal to Current date");		
		    return flag;
		 }	
		else if(date2<date1)	{
		alert("Forward Date must be less than or equal to Test date");		
		return flag;
		}
		else {flag="true";
		return flag;}
		}*/
					
}
//
/*  
var flag="false";
		var c=document.forms[0].sampCollectDate.value;	
		alert("data"+c);			
		var y=parseInt(c.substring(6,10));
		var d=parseInt(c.substring(0,2));
		var m=(c.substring(3,5));
				//alert("1");
				
		var a=document.forms[0].sysdate.value;
		alert("sysdate:"+a);
		var y2=parseInt(a.substring(6,10));
		var d2=parseInt(a.substring(0,2));
		var m2=(a.substring(3,5));
	// alert("2");
	
		var date1 = new Date(y, m, d); 
		
		
		var date3=new Date(y2,m2,d2);
		alert("date1:"+date1);
		alert("date3:"+date3);
		if(date3<date1)
		{
		 alert("Sample Collect Date must be less than or equal to Current date");		
	     return flag;
		}
		}*/
		



function ftkchk()
{
	// alert(" ftkchk fun");
	var val;
	if(document.forms[0].ftklab[0].checked==false && document.forms[0].ftklab[1].checked==false)
	{
		alert("Please select lab or ftk");
		return false;
	}
	else if(document.forms[0].ftklab[0].checked==true && document.forms[0].ftkTestDate.value=="")
	{
		alert("Please select Test Date");
		return false;
	}
	else if(document.forms[0].ftklab[0].checked==true && document.forms[0].ftkTestDate.value!="")
	{
		val=valdate();
		
		if(val=="false"){return false; }
        else if(val=="true")
		{

         return val;
         
        }
	}
	else if(document.forms[0].ftklab[0].checked==true && document.forms[0].forwardtolab.checked==true)
 	{ 
		if(document.forms[0].forwardDate.value=="")
		{
			alert("Please select Forward Date");
			return false;
		}
		else
		{
			val = valdate();
		if(val=="false")
        {
           return false;
        }
		else if(val=="true")
		{
         return val;         
        }               
		}
 	}
 	

}
 function validate1()
 {
   //  alert(" in Validate 1 function");
    var flag="false"; 
     var b=document.forms[0].forwardDate.value;
		
		if(document.forms[0].forwardDate.value!=""){
		var y1=parseInt(b.substring(6,10));
		var d1=parseInt(b.substring(0,2));
		var m1=(b.substring(3,5));
		
		var date2=new Date(y1,m1,d1);
		
		var a=document.forms[0].sysdate.value;
		var y2=parseInt(a.substring(6,10));
		var d2=parseInt(a.substring(0,2));
		var m2=(a.substring(3,5));
		
		var date3=new Date(y2,m2,d2);
		
		
		var c=document.forms[0].ftkTestDate.value;				
		var y=parseInt(c.substring(6,10));
		var d=parseInt(c.substring(0,2));
		var m=(c.substring(3,5));
		
		var date1=new Date(y, m, d);
		
		// alert(" date2" +date2);
		// alert(" date3" +date3);
		
		//alert(" in validarte Sridhar"+ date1);
		if(date3<date2)
		{
	    	alert("Forward Date must be less than or equal to Current date");		
		    return flag;
		 }	
		else if(date2<date1){
		alert("Forward Date must be greater than or equal to Test date");		
		return flag;
		}
		else {flag="true";
		return flag;}
		}
 
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

 function ftksave(that){
  var flagg="false"; 
  var subflag="false"; 
  that.disabled=true;
  
 if(document.forms[0].circleOfficeCode.value=="")
 {
     alert("Circle is Required");
	   return false;
 }
 else if(document.forms[0].ftklab[0].checked==false && document.forms[0].ftklab[1].checked==false)
     {
	  alert("please Select ftk or lab");
	   return false;
	 }
else if(document.forms[0].ftklab[0].checked==true && document.forms[0].ftklab[1].checked==false) 
{
   if(document.forms[0].mandalCode.value=="")
     {
	  alert("Mandal is Required");
	   return false;
	 }
	else if(document.forms[0].panchayatCode.value=="")
	  {
	   alert("Panchayat is Required");
	    return false;
	  }
	else if(document.forms[0].habCode.value=="")
	  {
	    alert("Habitation is Required");
	    return false;
	   }
	else if(document.forms[0].sourceType.value=="")
	 {
	   alert(" Please Select sources");
	   return false;
	   }
   else if(document.forms[0].ftkTestDate.value=="")
       {
           alert(" Please Select Test Date ");
           return false;
         }
    else if(document.forms[0].ftkTestDate.value!="")
          {
           // alert(" date selection");
             val=valdate();
			if(val=="false"){return false; }
           	else if(val=="true")
		     {
		        return val;
          	 }
	     }
   if(document.forms[0].contamin.value==""){
        alert("Please select water contaminated YES or No"); 
        return false;
        } 
   
   if(document.forms[0].contamin.value=="YES")
   {
       //alert("Please select any of contaminated parameters");
      
      if(document.forms[0].ftklab[0].checked==true || document.forms[0].ftklab[1].checked==true)
      { 
              
	     if(document.forms[0].che[0].checked==true || document.forms[0].che[1].checked==true || document.forms[0].che[2].checked==true || document.forms[0].che[3].checked==true || document.forms[0].che[4].checked==true ||document.forms[0].bat.checked==true || document.forms[0].phy.checked==true || document.forms[0].oth[0].checked==true || document.forms[0].oth[1].checked==true || document.forms[0].oth[2].checked==true || document.forms[0].oth[3].checked==true || document.forms[0].oth[4].checked==true || document.forms[0].oth[5].checked==true || document.forms[0].oth[6].checked==true || document.forms[0].oth[7].checked==true)
	      {
	       // alert(document.forms[0].bat.checked==true);
           //  alert(document.forms[0].phy.checked==true);
	        
	         if(document.forms[0].forwardDate.value!="")
				 {
					flagg = validate1(); 
					// alert("after validate fun");
					// alert("1111:"+flagg);
					if(flagg=="false")
					{
						subflag = "false";
						// alert("aaaa");
						//return false;
					}
					else
					{
						// alert("bbbb");
						subflag = "true";
					}
				 }
				 else
				 {
				   
				 	 subflag = "true";
				 	 
				 }
          }
          else
          {
           
            alert("Please Select any one contamination parameter");
          	//return false;
          }
       }
   }
     else
      {
        	subflag = "true";
        	//return false;
       }
        // alert("2222:"+subflag);
       if(subflag=="true")
       {
       		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=Save";
	       	document.forms[0].submit();
	       	
       }
       
     }  
       
	  else if(document.forms[0].ftklab[1].checked==true && document.forms[0].ftklab[0].checked==false) 
	  {
	  
	     if(document.forms[0].testCode.value=="")
	     {
	      alert(" Please Select Type of Test");
	      return false;
	      }
	    else if(document.forms[0].natureOfTest.value=="")
	     {
	      alert(" Please Select Nature of Test");
	      return false;
	      }
	     else if(document.forms[0].sampCollectCode.value=="")
	     {
	      alert(" Please Select Sample Collected By ");
	      return false;
	      }
	    else if(document.forms[0].sampCollectDate.value=="")
	     {
	      alert(" Please Select Sample Collect Date and Time");
	      return false;
	      }
	      else if(document.forms[0].labCode.value=="")
	      {
	        alert(" Pleas Select Lab name");
	        return false;
	       }
	      else if(document.forms[0].sampCollectDate.value!="")
	     {
	      
  		    dt1=getDateObject(document.forms[0].sampCollectDate.value,"/");
	        dt2=getDateObject(document.forms[0].assignedOn.value,"/");
  		    //alert("date1:"+dt1);
  		    // alert("date2:"+dt2);
  		    if(dt2>=dt1){
  		    document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=Save";
	 	     document.forms[0].submit();
  		      }
           	else
		     {
		        alert("Sample Collect Date Should be less than Current date");
  		        return false;
          	 }
  		 
	      }
	    
	     else{
	         
	         document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=Save";
	 	     document.forms[0].submit();
  	       }
 } 
 }
function ftkchk1()
{

var val;
if(document.forms[0].ftklab[0].checked==true)
{
	val=ftkchk();
	if(val=="true"){
if(document.forms[0].forwardtolab.checked==true && document.forms[0].forwardDate.value==""){
         alert("Please Select Forward Date");
          } else{
	      document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=Save";
		  document.forms[0].submit();
        }
	}
	else if(val=="false"){
     return false;
	}
} else{
      document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=Save";
	  document.forms[0].submit();
}
}

function getsourcecheck(){

  if (document.forms[0].sourceCode.value=="") 
    {
    alert(" Source Code is Rquired");
    document.forms[0].contamin.value = '';
     }
     else
     {
     	getData(); 
     }
     
}
function ftkview(){

    if(document.forms[0].circleOfficeCode.value=="")
   { 
     alert("Circle is required");
     return false;
     }
     else{  
       document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=view";
	  document.forms[0].submit();
	   }
}
function labview(){
if(document.forms[0].circleOfficeCode.value=="")
   { 
     alert("Circle is required");
     return false;
     }
     else{  
      document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=View";
	  document.forms[0].submit();
	  }
}
function ftkupdate(){
  // alert("1");
alert(document.forms[0].contamin.value);
  if(document.forms[0].contamin.value=="YES")
   {
     // alert("2-YES");
    if(document.forms[0].forwardtolab.checked==false)
       {
         alert("Please select forwarded date");
          }
          else
          {
             document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=Update";
             document.forms[0].submit();
            }
	   }
	    
  else if(document.forms[0].contamin.value=="NO")
    {
      // alert(" in No Contamination of Update block");
      document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=Update";
      document.forms[0].submit();
    }
  }
  // 
function ftkcheck(){
//alert(" funtion in ftkcheck");
if(document.forms[0].circleOfficeCode.value=="")
	{
       alert("Please Select Circle ");
	   document.forms[0].ftklab[0].checked=false;
	}
	else  if(document.forms[0].divisionOfficeCode.value=="")
	{ 
	  alert(" Please Select Division ");
	   document.forms[0].ftklab[0].checked=false;
	  }
	  else if(document.forms[0].subdivisionOfficeCode.value=="")
	 { 
	  alert(" Please Select Sub Division ");
	  document.forms[0].ftklab[0].checked=false;
	 }	
else
	{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data&ftklab=ftk&mode1=formftk";
	document.forms[0].submit();
	}
	
}
function labcheck(){
 
if(document.forms[0].circleOfficeCode.value=="")
	{
       alert("Please Select Circle ");
	   document.forms[0].ftklab[1].checked=false;
	}
	else  if(document.forms[0].divisionOfficeCode.value=="")
	{ 
	   alert(" Please Select Division ");
	   document.forms[0].ftklab[1].checked=false;
	  }
	  else if(document.forms[0].subdivisionOfficeCode.value=="")
	 { 
	   alert(" Please Select Sub Division ");
	   document.forms[0].ftklab[1].checked= false;
	 }
   else 
	{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data&ftklab=lab&mode1=formlab";
	document.forms[0].submit();
 	}
	
}

/*function check1()
{
if(document.forms[0].circleOfficeCode.value == "" || document.forms[0].divisionOfficeCode.value == "" || document.forms[0].subdivisionOfficeCode.value == "" || document.forms[0].mandalCode.value == "" || document.forms[0].panchayatCode.value == "" || document.forms[0].habCode.value == "" || document.forms[0].sourceType.value == "" || document.forms[0].sourceCode.value == "" || document.forms[0].testCode.value == "" || document.forms[0].natureOfTest.value == "" || document.forms[0].sampCollectCode.value == "" || document.forms[0].sampCollectDate.value == "" || document.forms[0].sampCollectTime.value == "" || document.forms[0].labCode.value == "" )
{
	
	document.getElementById('mode1').disabled = false;
}
else
{
	 document.getElementById('mode1').disabled = false;
}

}*/
function Reset() 
{   
    document.forms[0].ftklab[0].checked="false";
	document.forms[0].ftklab[1].checked="false";
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=reset";
	document.forms[0].submit();
}
function funcReset()
{
	document.forms[0].ftklab[0].disabled="true";
	document.forms[0].ftklab[1].disabled="true";
	
	getData();
}
//function added for ADDSources Button by vikas
//function addSources()

//{
	//document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=init"; 
	//document.forms[0].submit();
//}

function addSources()
{
  // alert(" in  add sources");
    var circleOfficeCode=document.forms[0].circleOfficeCode.value;
	var mandalCode=document.forms[0].mandalCode.value;
	var panchayatCode = document.forms[0].panchayatCode.value;
	var habCode = document.forms[0].habCode.value;
	var width = 850;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var val="yes";
 
if(document.forms[0].panchayatCode.value != "")
{
	if(document.forms[0].habCode.value!="")
	{

		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=init&circleOfficeCode="+circleOfficeCode+"&mandal="+mandalCode+"&panchayatCode="+panchayatCode+"&habCode="+habCode+"&returnVal="+val;
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
	}
	else
	{
		alert("Habitation is Required");
	}	
}
else if(document.forms[0].mandalCode.value=="")
{
		alert("Mandal is Required");
}
else
{
		alert("Panchayat is Required");
}

// alert(" end of add sources");

}//end of showAssets
function showSources()
{
  //  alert("add sources");
	var circleOfficeCode=document.forms[0].circleOfficeCode.value;
	var mandalCode=document.forms[0].mandalCode.value;
	var panchayatCode = document.forms[0].panchayatCode.value;
	var habCode = document.forms[0].habCode.value;
	var ftklab="";
	if(document.forms[0].ftklab[0].checked==true){
	ftklab="ftk";
	} else if(document.forms[0].ftklab[1].checked==true){
		ftklab="lab";
	}
    else{
    alert("Please check the ftk or lab ");
    }
	var width = 850;
	var height = 550;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));

// sridhar
if(document.forms[0].mandalCode.value=="")
{
	  alert("Mandal Required");
}
else if(document.forms[0].panchayatCode.value == "")
{
	 alert("Panchayat Required"); 
}
else if(document.forms[0].habCode.value=="")
	{
      alert("Habitation is Required");
	}
	else
	{
		var printString = 
	"District:"+document.forms[0].circleOfficeCode.options[document.forms[0].circleOfficeCode.selectedIndex].text
		+" Mandal:"+document.forms[0].mandalCode.options[document.forms[0].mandalCode.selectedIndex].text
			+" Panchayat:"+document.forms[0].panchayatCode.options[document.forms[0].panchayatCode.selectedIndex].text
			+" Habitation:"+document.forms[0].habCode.options[document.forms[0].habCode.selectedIndex].text;
//		alert(printString);
	//	document.forms[0].printString.value = printString;
       var url = "switch.do?prefix=/wquality&page=/rws_select_sources_frm.jsp?&habCode="+habCode+"&ftklab="+ftklab+"&printString="+printString;
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
	}

/*
if(document.forms[0].panchayatCode.value != "")
{
	if(document.forms[0].habCode.value!="")
	{
		 var url = "switch.do?prefix=/wquality&page=/WaterSample.do&mode=viewSources&circleOfficeCode="+circleOfficeCode+"&mandalCode="+mandalCode+"&panchayatCode="+panchayatCode+"&habCode="+habCode+"&ftklab="+ftklab;
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
	}
	else
	{
		alert("Habitation is Required");
	}
}
else
{
	if(document.forms[0].mandalCode.value!="")
	{
		 var url = "switch.do?prefix=/wquality&page=/WaterSample.do&mode=viewSources&circleOfficeCode="+circleOfficeCode+"&mandalCode="+mandalCode+"&ftklab="+ftklab;
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
	}
	else
	{
		alert("Mandal Required");
	}
}*/

}
function viewFtkSources(){

	var circleOfficeCode=document.forms[0].circleOfficeCode.value;
	var mandalCode=document.forms[0].mandalCode.value;
	var panchayatCode = document.forms[0].panchayatCode.value;
	var habCode = document.forms[0].habCode.value;
	var ftklab="";
	if(document.forms[0].ftklab[1].checked==true){
		ftklab="lab";
	}
    else{
    alert("Please check the ftk or lab ");
    }
	var width = 650;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));

if(document.forms[0].panchayatCode.value != "")
{
	if(document.forms[0].habCode.value!="")
	{
		 var url = "switch.do?prefix=/wquality&page=/WaterSample.do&mode=viewftkSources&ftktested=yes&circleOfficeCode="+circleOfficeCode+"&mandalCode="+mandalCode+"&panchayatCode="+panchayatCode+"&habCode="+habCode+"&ftklab="+ftklab;
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
	}
	else
	{
		alert("Habitation is Required");
	}
}
else
{
	if(document.forms[0].mandalCode.value!="")
	{
		 var url = "switch.do?prefix=/wquality&page=/WaterSample.do&mode=viewftkSources&ftktested=yes&circleOfficeCode="+circleOfficeCode+"&mandalCode="+mandalCode+"&ftklab="+ftklab;
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
	}
	else
	{
		alert("Mandal Required");
	}
}

}

function getData()
{
var getcheck='<%= request.getParameter("mode") %>';
	if(document.forms[0].ftklab[0].checked==true){
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data&ftklab=ftk&getcheck="+getcheck;
	document.forms[0].submit();
	}
	else if(document.forms[0].ftklab[1].checked==true){

	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data&ftklab=lab&getcheck="+getcheck;
	document.forms[0].submit();
	}
	else if(document.forms[0].ftklab[0].checked==false && document.forms[0].ftklab[1].checked==false){

	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data";
	document.forms[0].submit();
	
	}
}

function getSourceCodes()
{
	if(document.forms[0].mandalCode.value!="")
	{
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data&ftklab=ftk";
		document.forms[0].submit();
	}
	else 
	{
		document.forms[0].sourceType.value="";
		alert("Please Select Mandal");
	}
}

function getSourceLocation()
{
	if(document.forms[0].habCode.value!="")
	{
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data&ftklab=ftk";
		document.forms[0].submit();
	}
	else 
	{
		document.forms[0].sourceType.value="";
		alert("Please Select Habitation");
	}
 }
function fnYrcreation()
{
		var mydate=new Date();
	  	alert(mydate);
	  	if(document.forms[0].sampCollectDate.value >= mydate) 
	  	{
	  		alert("Date must be less than or equal to current date");
	  		document.forms[0].sampCollectDate.value='';
		    document.forms[0].sampCollectDate.focus();	  		
	  	}
	}


//-->

</SCRIPT><%@ include file="/commons/rws_header2.jsp" %>
<body onload = "checkforward();">
<html:form action="/WaterSample.do">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Sample Collection" />
	<jsp:param name="TWidth" value="770" />
	<jsp:param name="contextHelpUrl" value="./help/WaterQuality.doc" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="810" border=1 style="border-collapse:collapse;" >
<tr>
<td  >
<fieldset>
<legend> Office Details </legend>
<label>
<table cellpadding="0" cellspacing="0" border="0"  width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
<tr>
<td class="bwborder"><FONT class=myfontclr>Head Office&nbsp;:</FONT></td>
	<td class="bwborder">
		<html:text property="headOfficeName" name="RWS_USER" readonly="true"/>
		<html:hidden property="headOfficeCode" name="RWS_USER"/>
		<%String forwarded = (String)session.getAttribute("forwarded");
		String srccode=(String)session.getAttribute("forwardedsrcCode");
		String srctype=(String)session.getAttribute("forwardedsrcType");
		String forwardedftkid=(String)session.getAttribute("forwardedftkid");
		String forwardedmcode="",forwardedpcode="",forwardedhcode="";
		if(srccode.length()>10){
		forwardedmcode=srccode.substring(5,7);
		forwardedpcode=srccode.substring(12,14);  
		forwardedhcode=srccode.substring(0,16);
		}
        java.util.Date systemdate= new java.util.Date(System.currentTimeMillis());
		 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
	    String transdate=null;   
	  transdate=dateFormat.format(systemdate);
	 
	 %><html:hidden property="sysdate" value='<%=transdate%>'/>		
		<html:hidden property="forwarded" value='<%=forwarded%>'/>
		<html:hidden property="forwardedsrcCode" value='<%=srccode%>'/>
		<html:hidden property="forwardedsrcType" value='<%=srctype%>'/>
		<html:hidden property="forwardedftkid" value='<%=forwardedftkid%>'/>		
		<html:hidden property="forwardedmcode" value='<%=forwardedmcode%>'/>
		<html:hidden property="forwardedpcode" value='<%=forwardedpcode%>'/>
		<html:hidden property="forwardedhcode" value='<%=forwardedhcode%>'/>
		</td>
	 
	<td class="bwborder"><FONT class=myfontclr>Circle&nbsp;<font color="#FF6666">*</font>:</FONT></td>
	<td class="bwborder">
		<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
		<html:select property="circleOfficeCode" onchange="getData()" styleClass="combo">
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="circles">
			<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>			  
		</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
		<html:text property="circleOfficeName" name="RWS_USER" readonly="true" styleClass="text"/>
		<html:hidden property="circleOfficeCode" name="RWS_USER" />
		</logic:notEqual>
	 </td>
	 
	    <td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
		<td class="bwborder">
		 <logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
		 <html:select property="divisionOfficeCode" onchange="getData()" styleClass="combo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
				<html:text property="divisionOfficeName" name="RWS_USER" readonly="true"/>
				<html:hidden property="divisionOfficeCode" name="RWS_USER" />
			</logic:notEqual>
			</td>
		
   </tr>
   
   <tr>
	<td class="bwborder"><FONT class=myfontclr>Sub Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
	<td class="bwborder">
	 <logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subdivisionOfficeCode" onchange="getData()" styleClass="combo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
	
	 <td>Type Of test :</td> 
   <%System.out.println("request.getParameter: "+request.getParameter("ftklab"));
   %>
   <td class="bwborder">
   <html:radio property="ftklab" value="ftk" onclick="ftkcheck()">FTK</html:radio>
   <html:radio property="ftklab" value="lab" onclick="labcheck()">Lab Testing</html:radio>
   </td>
   
  

<% //System.out.println("ftklab"+request.getParameter("ftklab"));
String ftklabval=request.getParameter("ftklab");

if(ftklabval!=null && ftklabval.equals("lab")){
String special = (String)request.getAttribute("special");
if(special == null)special = "";
%>
</table>
</label>
</fieldset>

<fieldset>

<legend  > Habitation Details </legend>
<label>

<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder"><FONT class=myfontclr>Mandal&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left >
		<html:select property="mandalCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="mandals" name="rwsLocation" property="mandalCode" labelProperty="mandalName" />
		</html:select>
		</td>
	<%
	if(special.equals("special"))
	{//System.out.println("in special not null");
	%>
		<td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left>
		<html:select property="panchayatCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:options collection="panchyats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left colspan="5">
		<html:select property="habCode" styleClass="mycombo" style="width:320px" onchange="funcReset()">
		<html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
		</html:select>
		</td>
	</tr>
	<%}
	else if(special.equals(""))
	{ 

%>

		<td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left >
		<html:select property="panchayatCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="panchyats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left colspan="5">
		<html:select property="habCode" styleClass="mycombo" style="width:320px" onchange="funcReset()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
		</html:select>
		</td>
	</tr>
	<%}}

if(ftklabval!=null && ftklabval.equals("ftk")){
%>
</table>
	</label>
	
	</fieldset>

	<fieldset>
	<%

	String special = (String)request.getAttribute("special");
    if(special == null)special = "";

	%>
  <legend  > Habitation Details </legend>
  <label>
   <table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder"><FONT class=myfontclr>Mandal&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left >
		<html:select property="mandalCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="mandals" name="rwsLocation" property="mandalCode" labelProperty="mandalName" />
		</html:select>
		</td>
	<%
	if(special.equals("special"))
	{
	%>
		<td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left >
		<html:select property="panchayatCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:options collection="panchyats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left colspan="5">
		<html:select property="habCode" styleClass="mycombo" style="width:320px" onchange="funcReset()">
		<html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
		</html:select>
		</td>
	</tr>
	<%}
	else if(special.equals(""))
	{ 
%>

		<td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left >
		<html:select property="panchayatCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="panchyats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left colspan="5">
		<html:select property="habCode" styleClass="mycombo" style="width:320px" onchange="funcReset()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
		</html:select>
		</td>
	</tr>
	<%}%>
	<tr><td colspan="10">&nbsp;</td></tr>
	<tr>
	<!--  ****************************************************************************************** -->
	<td colspan="10" align="center"><html:button property="mode" styleClass="btext" value="Select Sources" onclick="return showSources()"/>&nbsp;<input type="button" Class="btext" value="Add Sources" title="Add Source Details" style="width:140px" onclick="return addSources();" disabled/></td>
	</tr>
	</table>
	</label>
	</fieldset>
		<fieldset>
		<legend > Sample Collection Details </legend>
		<label>
		<table width="100%" cellspacing="4" cellpadding="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;"  >
		<tr>
		</tr>
		<tr>
			<td class="bwborder" nowrap><FONT class=myfontclr>Source Type&nbsp;:<font color="#FF6666">*</font></FONT></td>
			
			<td class="bwborder">
			<html:hidden property="testId"/>
			<html:hidden property="ftktestid"/>
			<html:select property="sourceType" styleClass="mycombo" style="width:200px" onchange="getSourceCodes()">
			<html:option value="">SELECT...</html:option>
 <logic:present name="sources1">
	
			<html:options collection="sources1" name="rwsMaster"  property="sourceCode" labelProperty="codeName" />

 </logic:present>
			</html:select>
			</td>
			

			<td class="bwborder"><FONT class=myfontclr>Source&nbsp;:<font color="#FF6666">*</font></FONT></td>
			
			<td class="bwborder" colspan="3">
			<html:select property="sourceCode" styleClass="mycombo" style="width:400px" onchange="getSourceLocation()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sourceCodes" name="rwsMaster"  property="sourceCode" labelProperty="sourceAndLocation" />
			</html:select>
			
			</td>
			

			<!-- 
			<td class="bwborder"><FONT class=myfontclr>Location&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder"><html:text property="location"  size="12" readonly="true" styleClass="mytext" style="width:133px"/></td>
			  -->
			
			
		</tr> 
		<tr><td colspan="10">&nbsp;</td></tr>
		  <tr><td class="bwborder"><FONT class=myfontclr>Test Date&nbsp;:<font color="#FF6666">*</FONT></td>
			
			<td class="bwborder" nowrap>
			
			<html:text property="ftkTestDate" size="9"  styleClass="mytext"  maxlength="10" readonly="true" />
			<a href="javascript: showCalendar(document.waterSampleForm.ftkTestDate);">
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
			<FONT class=myfontclr><font style="font-size:7pt">DD/MM/YYYY&nbsp;&nbsp;&nbsp;&nbsp;</font></font>
			</td> 
			</tr>
	
            <tr>
              
                
              <td class="bwborder" colspan=2><FONT class=myfontclr>Water Contaminated Yes or No:<font color="#FF6666">*</font></FONT></td>
			
			<td class="bwborder" colspan=2>
			<html:select property="contamin" styleClass="mycombo" style="width:150px" onchange="getsourcecheck();">
			<html:option value="">SELECT...</html:option>
			<html:option value="YES">YES</html:option>
			<html:option value="NO">NO</html:option>
			</html:select>
			</td>
			
			</tr>
			 
			
       <%
           
      if(request.getParameter("contamin")!=null && request.getParameter("contamin").equals("YES"))
      {
           %>   
             
	<div id="submission" style="position:relative;overflow-y:auto;left:0;height:350;top:0;display:none">
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
			<tr>
				<td class="textborder" style="width:175px">&nbsp;</td>
				<td class="textborder" style="width:125px" >Chemical</td>
				<td class="textborder"  style="width:255px">Bacteriological</td>
				<td class="textborder"  style="width:175px">Physical</td>
				<td class="textborder"  style="width:175px">Other Chemical</td>
			</tr>
			<tr>

	<tr>
				<td class="textborder" style="width:175px">Contamination&nbsp;Found&nbsp;with&nbsp;FTK&nbsp;:</td>
				<td><table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
						
						<%if(wqlist!=null && wqlist.get(2).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Arsenic" checked >Arsenic</td>
						<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Arsenic">Arsenic</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(3).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Nitrate" checked>Nitrate</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Nitrate">Nitrate</td>
							<%} %>
						 </tr>
						<tr> 
							<%if(wqlist!=null && wqlist.get(4).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Fluoride" checked>Fluoride</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Fluoride">Fluoride</td>
							<%}%>
							<%if(wqlist!=null && wqlist.get(5).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Salinity" checked>Salinity</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Salinity">Salinity</td>
							<%} %>
						</tr>
						<tr><td></td>
							<%if(wqlist!=null && wqlist.get(6).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Iron" checked>Iron</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Iron">Iron</td>
							<%} %>
							
				
			</tr>
			</table> <%if(wqlist!=null && wqlist.get(7).equals("Y")){ %>
				<td class="textborder" ><input type="checkbox" name="bat" value="ColiForm" checked>Microbilogical &nbsp;&nbsp;&nbsp;&nbsp;Contamination</td>
				<%} else{%>
				<td class="textborder" ><input type="checkbox" name="bat" value="ColiForm">Microbilogical &nbsp;&nbsp;&nbsp;&nbsp;Contamination</td>
				<%} %>
				<%if(wqlist!=null && wqlist.get(8).equals("Y")){ %>
				<td class="textborder" ><input type="checkbox" name="phy" value="Turbidity" checked>Turbidity</td>
				<%} else{%>
				<td class="textborder" ><input type="checkbox" name="phy" value="Turbidity">Turbidity</td>
				<%} %>
				<td><table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
				<%if(wqlist!=null && wqlist.get(9).equals("Y")){ %>
					<td class="textborder"><input type="checkbox" name="oth" value="Chlorides" checked>Chlorides</td>
					<%} else{%>
					<td class="textborder"><input type="checkbox" name="oth" value="Chlorides">Chlorides</td>
					<%} %>
			   <%if(wqlist!=null && wqlist.get(10).equals("Y")){ %>
					<td class="textborder"><input type="checkbox" name="oth" value="Manganese" checked>Manganese</td>
					<%} else{%>
					<td class="textborder"><input type="checkbox" name="oth" value="Manganese">Manganese</td>
					<%} %>
					</tr>
					<tr>
					<%if(wqlist!=null && wqlist.get(11).equals("Y")){ %>
						<td class="textborder"><input type="checkbox" name="oth" value="Sulphates" checked>Sulphates</td>
						<%} else{%>
						<td class="textborder"><input type="checkbox" name="oth" value="Sulphates">Sulphates</td>
						<%}%>
					<%if(wqlist!=null && wqlist.get(12).equals("Y")){ %>
						<td class="textborder"><input type="checkbox" name="oth" value="Copper" checked>Copper</td>
						<%} else{%>
					    <td class="textborder"><input type="checkbox" name="oth" value="Copper">Copper</td>
						<%} %>
						</tr>
						<tr>
					<%if(wqlist!=null && wqlist.get(13).equals("Y")){ %>
						<td class="textborder"><input type="checkbox" name="oth" value="Calcium" checked>Calcium</td>
						<%} else{%>
						<td class="textborder"><input type="checkbox" name="oth" value="Calcium">Calcium</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(14).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" value="TDS" checked>TDS</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth" value="TDS">TDS</td>
							<%} %>
							
					</tr>
			<tr>
							<%if(wqlist!=null && wqlist.get(15).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" value="Magnesium" checked>Magnesium</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth" value="Magnesium">Magnesium</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(16).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" value="Hardness" checked>Hardness</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth" value="Hardness">Hardness</td>
							<%} %>
							
				
			</tr>
				</table>
				</td><table><tr>
                
				<td ><INPUT type="checkbox" name="forwardtolab" value="forwardtolab"  onClick="checkforward1(this);"><font color="#000000" face=verdana size=2><B>Forward&nbsp;for&nbsp;Lab&nbsp;Testing</B></font></td></tr>

			<td class="bwborder"><div id='fdate' style='display:none'> <FONT class=myfontclr>Forward Date&nbsp;:<font color="#FF6666">*</FONT></td>
			<td class="bwborder" >
			<html:text property="forwardDate" size="9"  style='display:none' readonly="true" styleClass="mytext" maxlength="10"/>
			
			<td><div id='fcal' style='display:none'><a href="javascript: showCalendar(document.waterSampleForm.forwardDate);" >
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
			</div></td>
			</div> 
			
			</tr></tr>
	<%//}
	}
	}else if(ftklabval!=null && ftklabval.equals("lab")){
			//System.out.println("in else loop");
			%> 
			     
	<tr><td colspan="10">&nbsp;</td></tr>
	<tr>
	<!-- ******************************************************************************************************** -->
	<td colspan="9" align="center">
	<html:button property="mode" styleClass="btext" value="Select Sources" onclick="return showSources()"/>&nbsp;
	<input type="button" Class="btext" value="Ftk Tested Sources" title="Ftk Tested Sources" style="width:140px" onclick="return viewFtkSources();"/>&nbsp;
	<input type="button" Class="btext" value=" Add Sources" title="Add Sources in Lab testing" style="width:140px" onclick="return addSources();" disabled/></td>  
	</tr>
	</table>
	</label>
	</fieldset>
		<fieldset>             
		<legend > Sample Collection Details</legend>
		<label>
		<table width="100%" cellspacing="4" cellpadding="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;"  >
		<tr>
		</tr>
		<tr>
			<td class="bwborder" nowrap><FONT class=myfontclr>Source Type&nbsp;:<font color="#FF6666">*</font></FONT></td>
			
			<td class="bwborder">
			<html:hidden property="testId"/>
			<html:hidden property="ftktestid"/>
			<html:select property="sourceType" styleClass="mycombo" style="width:200px" disabled="true">
			<html:option value="">SELECT...</html:option>

	
			<html:options collection="sources1" name="rwsMaster"  property="sourceCode" labelProperty="codeName" />


			</html:select>
			</td>
			<html:hidden property="sourceType" />
			<html:hidden property="sourceCode" />
			

			<td class="bwborder"><FONT class=myfontclr>Source&nbsp;:<font color="#FF6666">*</font></FONT></td>
			
			<td class="bwborder" colspan="3">
			<html:select property="sourceCode" styleClass="mycombo" style="width:400px" disabled="true">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sourceCodes" name="rwsMaster"  property="sourceCode" labelProperty="sourceAndLocation" />
			</html:select>
			
			</td>
			
			
			<tr>
			<td class="bwborder"><FONT class=myfontclr>Type of Test&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder">
			<html:select property="testCode" styleClass="mycombo" style="width:123px">
			<html:option value="">SELECT...</html:option>
			<html:options collection="watertests" name="rwsMaster"  property="testCode" labelProperty="testName" />
			</html:select>
			</td>
			
			<td class="bwborder"><FONT class=myfontclr>Nature of Test&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder">
			<html:select property="natureOfTest" styleClass="mycombo" style="width:130px">
			<html:option value="">SELECT...</html:option>
			<html:option value="1">ROUTINE</html:option>
			<html:option value="2">SEASONAL</html:option>
			<html:option value="3">QUARTERLY</html:option>
			<html:option value="4">DISEASE OUTBREAK</html:option>
			</html:select>
			</td>
			
			<td class="bwborder"><FONT class=myfontclr>Sample Collected By&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder">
			<html:select property="sampCollectCode" styleClass="mycombo" style="width:133px">
			<html:option value="">SELECT...</html:option>
			<html:options collection="desgns" name="rwsMaster"  property="desgnCode" labelProperty="desgnAcr" />
			
			</html:select>
			</td>
			 
			</tr>
		<tr>	
			
			<td class="bwborder"><FONT class=myfontclr>Collection Date<br>and Time&nbsp;:<font color="#FF6666">*</FONT></td>
			<td class="bwborder" nowrap>
			<html:text property="sampCollectDate" size="9"  styleClass="mytext" maxlength="10" readonly="true" />
			<html:text property="sampCollectTime" size="4" styleClass="mytext" maxlength="5" readonly="true"/>
			<a href="javascript: showCalendar(document.waterSampleForm.sampCollectDate);">
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
			<FONT class=myfontclr><font style="font-size:7pt">DD/MM/YYYY&nbsp;&nbsp;&nbsp;&nbsp;HH:MM</font></font>
			</td>
			
		
			<td class="bwborder"><FONT class=myfontclr>Assigned On&nbsp;:</FONT></td>
			<td class="bwborder"><html:text property="assignedOn" value="<%=sdf.format(new java.util.Date())%>" size="12" readonly="true" styleClass="mytext"/></td>
		
			<% 
			java.util.ArrayList col = new java.util.ArrayList();
			col = (java.util.ArrayList)session.getAttribute("wqlabs");
			//System.out.println("col size:"+col.size());
			 %>
			<td class="bwborder"><FONT class=myfontclr>Lab Assigned To<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder" colspan="5"><html:select property="labCode" styleClass="mycombo" style="width:133px">
			<html:option value="">SELECT...</html:option>
			<html:options collection="wqlabs" name="rwsMaster"  property="labCode" labelProperty="location" />
			</html:select>
			</td>
		</tr>
		<%} %>
		</table>
		</label>
		</fieldset>
		<tr>
	<td align="center">
	<%
	
	// System.out.println("11111JSp:"+session.getAttribute("editCheck1"));
	if(session.getAttribute("editCheck1")==null){%>
	<html:button property="mode1" title="Save the Fields"  styleClass="btext" value="Save" onclick="ftksave(this);"/>
	<%}%>
	
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" onclick="Reset();" />
    <%if(ftklabval!=null && ftklabval.equals("lab")){%>
    <html:button property="mode" title="View the Fields(Lab testing)" styleClass="btext" value="View" onclick="labview();"/>
    <%}else if(ftklabval!=null && ftklabval.equals("ftk")){ 
   // System.out.println("edit yes or no value"+session.getAttribute("editCheck1"));
    %>
     <html:button property="mode" title="View the Fields( Ftk testing)" styleClass="btext" value="view" onclick="ftkview();" />
<%
System.out.println("editCheck1:"+session.getAttribute("editCheck1"));
   if(session.getAttribute("editCheck1")!=null && session.getAttribute("editCheck1").equals("Y")){%>
     <html:button property="mode" title="Update the Fields( Ftk testing)" styleClass="btext" value="Update" onclick="ftkupdate();"/>
    <% //session.removeAttribute("editCheck1");%>
	<%}} %>
	<bean:define id="userId" name="RWS_USER" property="userId" />
	<html:hidden property="preparedBy" value="<%=(String)userId%>"/>
	<html:hidden property="preparedOn" value="<%=sdf.format(new java.util.Date())%>"/>
	

	<% 
	session.setAttribute("water","water");
	session.getAttribute("water");
	//session.gettAttribute(water1);
	
	//out.println(session.getAttribute("water1"));
	%>

	</td>
	</tr>
	</table>
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="770"/>
</jsp:include>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>