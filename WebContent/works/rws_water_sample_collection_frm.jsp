<%@ include file="/commons/rws_header1.jsp" %>
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
	var sourceTypeCode=document.forms[0].forwardedsurcType.value;
	var sourceCode=document.forms[0].forwardedsurcCode.value;
	var ftktestid=document.forms[0].forwardedftkid.value;
	var mcode=document.forms[0].forwardedmcode.value;
	var pcode=document.forms[0].forwardedpcode.value;
	var hcode=document.forms[0].forwardedhcode.value;
	//alert(sourceTypeCode);
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

	function valdate(){
	  
			var flag="false";
			var c=document.forms[0].ftkTestDate.value;				
			var y=parseInt(c.substring(6,10));
			var d=parseInt(c.substring(0,2));
			var m=(c.substring(3,5));
			var a=document.forms[0].sysdate.value;
			var y2=parseInt(a.substring(6,10));
			var d2=parseInt(a.substring(0,2));
			var m2=(a.substring(3,5));
			var date1 = new Date(y, m, d); 
			var date3=new Date(y2,m2,d2);
			if(date3<date1)
			{
			 alert("Test Date must be less than or equal to Current date");		
			 return flag;
			}
							
	   }


	function ftkchk()
	{
		
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

function ftksave(that)
  {  
	  //alert("hai i am in save");
	  var flagg="false"; 
	  var subflag="false"; 
	 // that.disabled=true;
		  
		
          
		 if(document.forms[0].circleOfficeCode.value=="")
		 {
			 alert("Circle is Required");
			   return false;
		 }
	
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
		
		  	  
			  if(document.forms[0].ttype[0].checked==true)
			  { 
				   	 //alert("ftkkkkk");
			  
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
				  
			  subflag = "true";
				
			}//ftk
			else if(document.forms[0].ttype[1].checked==true)
			  {  
                 //alert("fthhhhh...."+document.forms[0].ttype[1].value);
               
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
              	   subflag = "true";
			   }//fth

			   else if(document.forms[0].ttype[0].checked==true && document.forms[0].ttype[1].checked==true)
			  {  
                 //alert("FTKKKK AND fthhhhh");
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
                  subflag = "true";
			   }//ftk and fth
			   else
			   {
				   alert("Please Select any of the Test");
				   subflag = "false";
				   return;
			   }

			   if(subflag=="true")
			   {    //alert("save");
			        
					document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=Save";
					document.forms[0].submit();
			        
					
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

	function getsourcecheck()
     {

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
	else if(document.forms[0].divisionOfficeCode.value=="")
   { 
     alert("Division is required");
     return false;
     }
  else if(document.forms[0].subdivisionOfficeCode.value=="")
   { 
     alert("SubDivision is required");
     return false;
     }

     else{  
      document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=View";
	  document.forms[0].submit();
	  }
}
function ftkupdate(){
  // alert("1");
//alert(document.forms[0].contamin.value);
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


}//end of showAssets
function showSources()
{

		var circleOfficeCode=document.forms[0].circleOfficeCode.value;
		var mandalCode=document.forms[0].mandalCode.value;
		var panchayatCode = document.forms[0].panchayatCode.value;
		var habCode = document.forms[0].habCode.value;
		var ftklab="ftk";
		var width = 850;
		var height = 550;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));


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
	
			if(document.forms[0].circleOfficeCode.options!=undefined)
				{
				var  printString = 
			"District:"+document.forms[0].circleOfficeCode.options[document.forms[0].circleOfficeCode.selectedIndex].text
				+" Mandal:"+document.forms[0].mandalCode.options[document.forms[0].mandalCode.selectedIndex].text
					+" Panchayat:"+document.forms[0].panchayatCode.options[document.forms[0].panchayatCode.selectedIndex].text
					+" Habitation:"+document.forms[0].habCode.options[document.forms[0].habCode.selectedIndex].text; 
				}
				else
				{
					var printString="District:"+document.forms[0].circleOfficeName.value +" Mandal:"+document.forms[0].mandalCode.options[document.forms[0].mandalCode.selectedIndex].text
					+" Panchayat:"+document.forms[0].panchayatCode.options[document.forms[0].panchayatCode.selectedIndex].text
					+" Habitation:"+document.forms[0].habCode.options[document.forms[0].habCode.selectedIndex].text; 
				}
				
				  var url = "switch.do?prefix=/wquality&page=/rws_select_sources_frm.jsp?&habCode="+habCode+"&ftklab="+ftklab+"&printString="+printString;
				  var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
								   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
								   + "resizable=yes,status=yes";
						newWindow = window.open(url, "_New", properties);
						newWindow.focus();
			}

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
	//if(document.forms[0].ftklab[0].checked==true)
   // {
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data&ftklab=ftk&getcheck="+getcheck;
	document.forms[0].submit();
	//}
	//else if(document.forms[0].ftklab[1].checked==true)
  // {
//	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data&ftklab=lab&getcheck="+getcheck;
//	document.forms[0].submit();
//	}
//	else if(document.forms[0].ftklab[0].checked==false && document.forms[0].ftklab[1].checked==false){

//	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data";
//	document.forms[0].submit();
	
	//}
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

function mydisplayfun(S)
{  //alert("hai");
  
  if(document.forms[0].ttype[0].checked==true)
	{
	  //alert("hai999999");
	  document.getElementById('15').disabled=true;
     }
   if(document.forms[0].ttype[1].checked==true)
	{
	  document.getElementById('1').disabled=true;
	  document.getElementById('2').disabled=true;
	  document.getElementById('3').disabled=true;      
      document.getElementById('4').disabled=true;
	  document.getElementById('5').disabled=true;
	  document.getElementById('6').disabled=true;
      document.getElementById('7').disabled=true;
	  document.getElementById('8').disabled=true;
	  document.getElementById('9').disabled=true;
      document.getElementById('10').disabled=true;
	  document.getElementById('11').disabled=true;
	  document.getElementById('12').disabled=true;
      document.getElementById('13').disabled=true;
      document.getElementById('14').disabled=true;
	  document.getElementById('15').disabled=false;
	}
    if(document.forms[0].ttype[0].checked==true && document.forms[0].ttype[1].checked==true)
	{
	  document.getElementById('1').disabled=false;
	  document.getElementById('2').disabled=false;
	  document.getElementById('3').disabled=false;      
      document.getElementById('4').disabled=false;
	  document.getElementById('5').disabled=false;
	  document.getElementById('6').disabled=false;
      document.getElementById('7').disabled=false;
	  document.getElementById('8').disabled=false;
	  document.getElementById('9').disabled=false;
      document.getElementById('10').disabled=false;
	  document.getElementById('11').disabled=false;
	  document.getElementById('12').disabled=false;
      document.getElementById('13').disabled=false;
      document.getElementById('14').disabled=false;
	  document.getElementById('15').disabled=false;
	}
    if(document.forms[0].ttype[0].checked==false && document.forms[0].ttype[1].checked==false)
	{
	  document.getElementById('1').disabled=true;
	  document.getElementById('2').disabled=true;
	  document.getElementById('3').disabled=true;      
      document.getElementById('4').disabled=true;
	  document.getElementById('5').disabled=true;
	  document.getElementById('6').disabled=true;
      document.getElementById('7').disabled=true;
	  document.getElementById('8').disabled=true;
	  document.getElementById('9').disabled=true;
      document.getElementById('10').disabled=true;
	  document.getElementById('11').disabled=true;
	  document.getElementById('12').disabled=true;
      document.getElementById('13').disabled=true;
      document.getElementById('14').disabled=true;
	  document.getElementById('15').disabled=true;
	}
}


function mydisplayfun1(S)
{
	//alert("helloyyyy"+document.forms[0].che[0].checked+document.forms[0].che[1].checked);
	
	if(!document.forms[0].che[0].checked && !document.forms[0].che[1].checked && !document.forms[0].che[2].checked && !document.forms[0].che[3].checked && !document.forms[0].che[4].checked &&  !document.forms[0].phy.checked && !document.forms[0].oth[0].checked && !document.forms[0].oth[1].checked && !document.forms[0].oth[2].checked && !document.forms[0].oth[3].checked && !document.forms[0].oth[4].checked && !document.forms[0].oth[5].checked && !document.forms[0].oth[6].checked && !document.forms[0].oth[7].checked && !document.forms[0].bat.checked)
	{   
		
		document.forms[0].contamin.value="N";
		
		 document.getElementById('forwardtolab').disabled=true;
			
	}
	else
	{   //alert("helloyyyy");
		document.forms[0].contamin.value="Y";
		 document.getElementById('forwardtolab').disabled=false;	
	}

}


</SCRIPT><%@ include file="/commons/rws_header2.jsp" %>
<body onload = "checkforward();">
<html:form action="/WaterSample.do">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="FTK Entry Form" />
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
		String surccode=(String)session.getAttribute("forwardedsurcCode");
		String surctype=(String)session.getAttribute("forwardedsurcType");
		String forwardedftkid=(String)session.getAttribute("forwardedftkid");
		String forwardedmcode="",forwardedpcode="",forwardedhcode="";
		if(surccode.length()>10){
		forwardedmcode=surccode.substring(5,7);
		forwardedpcode=surccode.substring(12,14);  
		forwardedhcode=surccode.substring(0,16);
		}
        java.util.Date systemdate= new java.util.Date(System.currentTimeMillis());
		 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
	    String transdate=null;   
	  transdate=dateFormat.format(systemdate);
	 
	 %><html:hidden property="sysdate" value='<%=transdate%>'/>		
		<html:hidden property="forwarded" value='<%=forwarded%>'/>
		<html:hidden property="forwardedsurcCode" value='<%=surccode%>'/>
		<html:hidden property="forwardedsurcType" value='<%=surctype%>'/>
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
	
</table>
	</label>
	
	</fieldset>

	<fieldset>

  <legend> Habitation Details </legend>
  <label>
   <table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder"><FONT class=myfontclr>Mandal&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left >
		<html:select property="mandalCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:option value="">SELECT...</html:option>
		<logic:notEmpty name="mandals">
			<html:options collection="mandals" name="rwsLocation" property="mandalCode" labelProperty="mandalName" />
	     </logic:notEmpty>
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left >
		<html:select property="panchayatCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:option value="">SELECT...</html:option>
		<logic:notEmpty name="panchyats">
			<html:options collection="panchyats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
		 </logic:notEmpty>
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left colspan="5">
		<html:select property="habCode" styleClass="mycombo" style="width:320px" onchange="funcReset()">
		<html:option value="">SELECT...</html:option>
		<logic:notEmpty name="prhabs">
			<html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
          </logic:notEmpty>
		</html:select>
		</td>
	</tr>
	<tr><td colspan="10">&nbsp;</td></tr>
	<tr>
	<!--  ****************************************************************************************** -->
	<td colspan="10" align="center">
	<html:button property="mode" styleClass="btext" value="Select Sources" onclick="return showSources()"/>&nbsp;<!-- <input type="button" Class="btext" value="Add Sources" title="Add Source Details" style="width:140px" onclick="return addSources();" disabled/>--></td>
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
			<logic:notEmpty name="sourceCodes">
				<html:options collection="sourceCodes" name="rwsMaster"  property="sourceCode" labelProperty="sourceAndLocation" />
			</logic:notEmpty>
			</html:select>
			
			</td>
			
		</tr> 
		<tr><td colspan="10">&nbsp;</td></tr>
		  <tr><td class="bwborder"><FONT class=myfontclr>Test Date&nbsp;:<font color="#FF6666">*</FONT></td>
			<td class="bwborder" nowrap>
			<html:text property="ftkTestDate" size="9"  styleClass="mytext"  maxlength="10" readonly="true" />
			<a href="javascript: showCalendar(document.waterSampleForm.ftkTestDate);">
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
			<FONT class=myfontclr><font style="font-size:7pt">DD/MM/YYYY&nbsp;&nbsp;&nbsp;&nbsp;</font></font>
			</td> 
		       
	     <td class="textborder" colspan=5>&nbsp;&nbsp;&nbsp;
         <table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
         <tr><td class="textborder"><font color="red">Note:***&nbsp;&nbsp;&nbsp;Any of the Test Type is Compulsory.</font></td></tr>
		 <tr>
		 <td class="textborder" >
         <INPUT type="checkbox" name="ttype" value="ftk"  onClick="mydisplayfun(this);">Field Test-Chemical&nbsp;&nbsp;&nbsp;
         <INPUT type="checkbox" name="ttype" value="fth"  onClick="mydisplayfun(this);">Field Test-H2s vial
         </td>
         </tr>
         </table>
         </td>
         
       
</tr>
	 <br></br>
            
	<div id="submission" style="position:relative;overflow-y:auto;left:0;height:350;top:0;display:none">
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
			<tr>
				<td class="textborder" style="width:175px">&nbsp;</td>
				<td class="textborder" style="width:125px" >Field Test- Chemical<!-- Chemical--></td>
				<td class="textborder"  style="width:175px">Physical</td>
				<td class="textborder"  style="width:175px">Other Chemical</td>
                <td class="textborder"  style="width:255px">Field Test-H2s vial<!-- Bacteriological--></td>
			</tr>
			<tr>

	<tr>
				<td class="textborder" style="width:175px">Contamination&nbsp;Found&nbsp;with&nbsp;FTK&nbsp;:</td>
				<td><table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
						
						<%if(wqlist!=null && wqlist.get(2).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" id="1" value="Arsenic" checked onClick="mydisplayfun1(this);" >Arsenic</td>
						<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" id="1" value="Arsenic" onClick="mydisplayfun1(this);">Arsenic</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(3).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" id="2" value="Nitrate" checked onClick="mydisplayfun1(this);">Nitrate</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" id="2" value="Nitrate" onClick="mydisplayfun1(this);">Nitrate</td>
							<%} %>
						 </tr>
						<tr> 
							<%if(wqlist!=null && wqlist.get(4).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" id="3" value="Fluoride" checked onClick="mydisplayfun1(this);">Fluoride</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" id="3" value="Fluoride" onClick="mydisplayfun1(this);">Fluoride</td>
							<%}%>
							<%if(wqlist!=null && wqlist.get(5).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" id="4" value="Salinity" checked onClick="mydisplayfun1(this);">Salinity</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" id="4" value="Salinity" onClick="mydisplayfun1(this);">Salinity</td>
							<%} %>
						</tr>
						<tr><td></td>
							<%if(wqlist!=null && wqlist.get(6).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" id="5" value="Iron" checked onClick="mydisplayfun1(this);">Iron</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" id="5" value="Iron" onClick="mydisplayfun1(this);">Iron</td>
							<%} %>
							
				
			</tr>
			</table>
						<%if(wqlist!=null && wqlist.get(8).equals("Y")){ %>
						<td class="textborder" ><input type="checkbox" name="phy" id="6" value="Turbidity" checked onClick="mydisplayfun1(this);">Turbidity</td>
						<%} else{%>
						<td class="textborder" ><input type="checkbox" name="phy"  id="6" value="Turbidity" onClick="mydisplayfun1(this);">Turbidity</td>
						<%} %>
						
						<td><table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
						<%if(wqlist!=null && wqlist.get(9).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" id="7" value="Chlorides" checked onClick="mydisplayfun1(this);">Chlorides</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth" id="7" value="Chlorides" onClick="mydisplayfun1(this);">Chlorides</td>
							<%} %>
					   <%if(wqlist!=null && wqlist.get(10).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" id="8" value="Manganese" checked onClick="mydisplayfun1(this);">Manganese</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth" id="8" value="Manganese" onClick="mydisplayfun1(this);" >Manganese</td>
							<%} %>
							</tr>
							<tr>
						<%if(wqlist!=null && wqlist.get(11).equals("Y")){ %>
								<td class="textborder"><input type="checkbox" name="oth" id="9" value="Sulphates" checked onClick="mydisplayfun1(this);">Sulphates</td>
								<%} else{%>
								<td class="textborder"><input type="checkbox" name="oth" id="9" value="Sulphates" onClick="mydisplayfun1(this);">Sulphates</td>
								<%}%>
						<%if(wqlist!=null && wqlist.get(12).equals("Y")){ %>
								<td class="textborder"><input type="checkbox" name="oth" id="10" value="Copper" checked onClick="mydisplayfun1(this);">Copper</td>
								<%} else{%>
								<td class="textborder"><input type="checkbox" name="oth" id="10" value="Copper" onClick="mydisplayfun1(this);">Copper</td>
								<%} %>
								</tr>
								<tr>
						<%if(wqlist!=null && wqlist.get(13).equals("Y")){ %>
								<td class="textborder"><input type="checkbox" name="oth" id="11" value="Calcium" checked onClick="mydisplayfun1(this);">Calcium</td>
								<%} else{%>
								<td class="textborder"><input type="checkbox" name="oth" id="11" value="Calcium" onClick="mydisplayfun1(this);">Calcium</td>
									<%} %>
						 <%if(wqlist!=null && wqlist.get(14).equals("Y")){ %>
									<td class="textborder"><input type="checkbox" name="oth" id="12" value="TDS" checked onClick="mydisplayfun1(this);">TDS</td>
									<%} else{%>
									<td class="textborder"><input type="checkbox" name="oth" id="12" value="TDS" onClick="mydisplayfun1(this);">TDS</td>
									<%} %>
							
							</tr>
							<tr>
							<%if(wqlist!=null && wqlist.get(15).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" id="13" value="Magnesium" checked onClick="mydisplayfun1(this);">Magnesium</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth"  id="13" value="Magnesium" onClick="mydisplayfun1(this);">Magnesium</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(16).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" id="14" value="Hardness" checked onClick="mydisplayfun1(this);">Hardness</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth" id="14" value="Hardness" onClick="mydisplayfun1(this);">Hardness</td>
							<%} %>
							
				
			</tr>
				</table>
                   <%if(wqlist!=null && wqlist.get(7).equals("Y")){ %>
						<td class="textborder" ><input type="checkbox" name="bat" id="15" value="ColiForm" checked onClick="mydisplayfun1(this);">Microbilogical &nbsp;&nbsp;&nbsp;&nbsp;Contamination</td>
						<%} else{%>
						<td class="textborder" ><input type="checkbox" name="bat" id="15" value="ColiForm" onClick="mydisplayfun1(this);">Microbilogical &nbsp;&nbsp;&nbsp;&nbsp;Contamination</td>
						<%} %>
				</td><table><tr>
           
        
            <td class="bwborder">
             <FONT class=myfontclr>Water Contamination:<font color="#FF6666">*</font></FONT>
			<html:select property="contamin" styleClass="mycombo" style="width:150px" >
	    	<html:option value="N">NO</html:option>
	    	<html:option value="Y">YES</html:option>		   
			</html:select>
           
			</td>
			</tr>

            


           <tr>
                
				<td><INPUT type="checkbox" name="forwardtolab" id="forwardtolab" value="forwardtolab"  onClick="checkforward1(this);"><font color="#000000" face=verdana size=2><B>Forward&nbsp;for&nbsp;Lab&nbsp;Testing</B></font></td></tr>

			<td class="bwborder"><div id='fdate' style='display:none'> <FONT class=myfontclr>Forward Date&nbsp;:<font color="#FF6666">*</FONT></td>
			<td class="bwborder" >
			<html:text property="forwardDate" size="9"  style='display:none' readonly="true" styleClass="mytext" maxlength="10"/>
			
			<td><div id='fcal' style='display:none'><a href="javascript: showCalendar(document.waterSampleForm.forwardDate);" >
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
			</div></td>
			</div> 
			
			</tr></tr>
	
		</table>
		</label>
		</fieldset>
		<tr>
	<td align="center">
	<%
	
	// System.out.println("11111JSp:"+session.getAttribute("editCheck1"));
	if(session.getAttribute("editCheck1")==null)
	{ %>
	<html:button property="mode1" title="Save the Fields"  styleClass="btext" value="Save" onclick="ftksave(this);"/>
	<%}%>
	
    <!--<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" onclick="Reset();" />-->
    <html:button property="mode" title="View the Fields( Ftk testing)" styleClass="btext" value="view" onclick="ftkview();" />
<%
// System.out.println("editCheck1:"+session.getAttribute("editCheck1"));
   if(session.getAttribute("editCheck1")!=null && session.getAttribute("editCheck1").equals("Y"))
   {
   %>
     <html:button property="mode" title="Update the Fields( Ftk testing)" styleClass="btext" value="Update" onclick="ftkupdate();"/>
    <% //session.removeAttribute("editCheck1");%>
	<%}%>
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