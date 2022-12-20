<%@ include file="/commons/rws_header1.jsp" %>
<%//System.out.println("in water edit jsp");
String contamin= (String)session.getAttribute("contaminvalue");
System.out.println("in edit form.jsp");
 %>
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
//rwsWQLabValidate.js




function checkMandatory(names,displaymessage)
{
	var flags = false;
	var values = document.getElementById("parameters["+ names +"].result").value;
	if(values==null || values=="")
	{
		alert("Please Enter the value for "+displaymessage);
	}
	else
	{
		flags = true;
	}
	return flags;
}
function checkMandatoryAndRanges(names, displaymessage, min, max)
{
    var flags = false;
    var values = document.getElementById("parameters[" + names + "].result").value;

    if (values == null || values == "")
    {
        alert("Please Enter the value for " + displaymessage);
    } else
    {
        if(min==max)
        {
            if (parseFloat(values) != parseFloat(max))
            {
                alert(displaymessage + " Must be equal to " + max);
                flags = false;
            } else
            {
                flags = true;
            }
        }
        else
        {
            if (parseFloat(values) < parseFloat(min))
            {
                alert(displaymessage + " Must be greater than or equal to " + min);
                flags = false;
            } else if (parseFloat(values) > parseFloat(max))
            {
                alert(displaymessage + " Must be less than or equal to " + max);
                flags = false;
            } else
            {
                flags = true;
            }
        }
    }
    return flags;
}
function checkMandatoryAndRanges1(names,displaymessage,min,max)
{
	var flags = false;
	var values = document.getElementById("parameters["+ names +"].result").value;	
	names = parseInt(names)-1;
	var values1 = document.getElementById("parameters["+ names +"].result").value;	
	if(values==null || values=="")
	{
		alert("Please Enter the value for "+displaymessage);
	}
	else
	{
		if(parseFloat(values1)<parseFloat(values))
		{
			alert("Total Hardness(Value:"+values+") must be less than Dissolved Solids(Value:"+values1+")");
		}
		else
		{
			flags = true;
		}
	}
	return flags;
}
function checkMandatoryAndRanges2(names,displaymessage,max)
{
	var flags = false;
	var values = document.getElementById("parameters["+ names +"].result").value;	
	if(parseFloat(max)<parseFloat(values))
	{
		alert(displaymessage+"(Value:"+values+") must be less than Totalhardness(Value:"+max+")");
	}
	else
	{
		flags = true;
	}
	return flags;
}
function checkMandatoryAndRanges3(names,displaymessage,min,max)
{
	var flags = false;
	var values = document.getElementById("parameters["+ names +"].result").value;	
	if(parseFloat(values)<parseFloat(min))
	{
		alert(displaymessage+" Must be greater than or equal "+min);
		flags = false;
	}
	else if(parseFloat(values)>parseFloat(max))
	{
		alert(displaymessage+" Must be less than or equal "+max);
		flags = false;
	}
	else
	{
		flags = true;
	}
	return flags;
}
function checkMandatoryAndRanges4(names,displaymessage,min,max)
{
	var flags = false;
	if(parseFloat(min)<parseFloat(max))
	{
		alert("Dissolved Solids Value should be greater than the Sum of Total Hardness & Chloride");
		flags = false;
	}
	else
	{
		flags = true;
	}
	return flags;
}
function fnAdd1(testCode)
{

 
	var flag=false;
	
	if(testCode=="1")
	{
    	if(checkMandatoryAndRanges('3','pH Ranges',6,9)==true)
    	{
    		if(checkMandatory('4','Dissolved Solids')==true)
    		{
        		if(checkMandatoryAndRanges1('5','Total Hardness')==true)
        		{
	        		if(checkMandatory('6','Alkalinity')==true)
    				{
    					if(checkMandatoryAndRanges2('7','Calcium',document.getElementById("parameters[5].result").value)==true)
    					{
        					if(checkMandatoryAndRanges2('8','Magnesium',document.getElementById("parameters[5].result").value)==true)
        					{
	        					if(checkMandatory('9','Chloride')==true)
    							{
    								if(checkMandatoryAndRanges('10','Fluoride',0,20)==true)
    								{
										/* if(checkMandatoryAndRanges('11','Sulphate',0,400)==true)
	        								   {
        								if(checkMandatoryAndRanges('12','Nitrate',0,999)==true)
        								{
	        								if(checkMandatoryAndRanges('13','Iron',0,10)==true)
	        								{
                                               */
		        								if(checkMandatoryAndRanges3('14','Manganese',0,99)==true)
		        								{
			        								if(checkMandatoryAndRanges3('15','Residual Chlorine',0,9)==true)
			        								{
				        								if(checkMandatoryAndRanges4('','',document.getElementById("parameters[4].result").value,parseFloat(document.getElementById("parameters[5].result").value)+parseFloat(document.getElementById("parameters[9].result").value))==true)
			        									{
			        										flag = true;
			        									}
				        							}
			        							}
		        							/* }
                                         }//ADDED
	        							} */
        							}
    							}
	        				}
        				}
    				}
        		}
    		}
    	}
	 }
	 else if(testCode=="2")
	{
    	if(checkMandatoryAndRanges('0','MPN Coliform Bacteria',0,1609)==true)
    	{
    		if(checkMandatoryAndRanges3('1','E-Coli',0,24)==true)
    		{
    			flag = true;
    		}
    	}
    }
	if(flag==true)
	{
		
		//var url = "switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=saveQT&testId="+testIdd;
		//document.forms[0].action=url;
		//document.forms[0].submit();
		//window.close();
      return true;
	}

return false;


}

function checkRanges3(names, displaymessage, min, max)
{
    var flags = true;
    var values = document.getElementById("parameters[" + names + "].result").value;
    if(values!=null && values!="")
    {
        if (parseFloat(values) < parseFloat(min))
        {
            alert(displaymessage + " Must be greater than or equal " + min);
            flags = false;
        } 
        if (parseFloat(values) > parseFloat(max))
        {
            alert(displaymessage + " Must be less than or equal " + max);
            flags = false;
        } 
    }
    return flags;
}

function fnAdd2(testCode)
{
    var flag = false;
    if (testCode == "1")
    {
                if (checkMandatoryAndRanges('3', 'pH Ranges', 0, 9) == true)
                {
                    if (checkMandatoryAndRanges('4', 'Dissolved Solids',0,15000) == true)
                    {
                        if (checkMandatoryAndRanges('6', 'Alkalinity',0,600) == true)
                        {
                            if (checkMandatoryAndRanges('5', 'Total Hardness',0,1000) == true)
                            {
                                if (checkRanges3('7', 'Calcium',0,200) == true)
                                {
                                    if (checkRanges3('8', 'Magnesium', 0,200) == true)
                                   {
                                        if (checkMandatoryAndRanges('9', 'Chloride',0,1000) == true)
                                        {
                                            if (checkMandatoryAndRanges('10', 'Fluoride', 0, 9) == true)
                                            {
                                                if (checkRanges3('12', 'Nitrate', 0, 200) == true)
                                                {
                                                    if (checkRanges3('11', 'Sulphate', 0, 200) == true)
                                                    {
                                                        if (checkRanges3('13', 'Iron', 0, 5) == true)
                                                        {
                                                            if (checkMandatoryAndRanges4('', '', document.getElementById("parameters[4].result").value, parseFloat(document.getElementById("parameters[5].result").value) + parseFloat(document.getElementById("parameters[9].result").value)) == true)
                                                            {
                                                                flag = true;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
    } else if (testCode == "2")
    {
        if (checkMandatoryAndRanges('0', 'MPN Coliform Bacteria', 0, 1609) == true)
        {
            if (checkMandatoryAndRanges3('1', 'E-Coli', 0, 24) == true)
            {
                flag = true;
            }
        }
    }
    if (flag == true)
    {
        return true;
    }
    return false;
}


function ValidNumber(value) {
	
value=value-1;
var minValue=parseFloat(document.getElementById("parameters["+value+"].minPerVal").value);
//alert(minValue);

var maxValue=parseFloat(document.getElementById("parameters["+value+"].maxPerVal").value);
//alert(maxValue);
if(!isNaN(document.getElementById("parameters["+value+"].result").value)){
var resultValue=parseFloat(document.getElementById("parameters["+value+"].result").value);

	
//alert(resultValue);
if(resultValue!=""){
  if(resultValue<minValue || resultValue>maxValue ){
	  
	  alert("Please re-check the reported value, as it is above/below the permissible range.");
  }
}
	
	
	return true;
}else{
document.getElementById("parameters["+value+"].result").value="";
//document.getElementById("parameters["+value-1+"].result").focus;
   alert("Invalid Number");
  return false;
}
   
}



      function ValidNumber1(value){  

  if(!isNaN(document.getElementById("parameters["+value+"].result").value))
	{
    	 alert("inivalid number");
		  return false;
	}else{
		return true;
}




         if(document.getElementById("parameters["+value+"].result").value==""){return true;}
       // var regEx = /^\d{1,2}\.\d{1,2}$/;  
        //var regEx = /^\d{3}\.\d{3}$/;  
         var regEx="/[0-9]{3}\.[0-9]{2}$/";
        bValid = document.getElementById("parameters["+value+"].result").value.match(regEx);  

        if(!bValid){  
alert('incorrect format');
document.getElementById("parameters["+value+"].result").value="";
document.getElementById("parameters["+value+"].result").focus;
          return false;           
        }  
        else return true;  
      }  




            function IsNumeric(input) {
		    return /^-?(0|[1-9]\d*|(?=\.))(\.\d+)?$/.test(input);
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
alert("Forwarded to Lab");
document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=forwardtolab&ftklab=lab&sourceTypeCode="+sourceTypeCode+"&sourceCode="+sourceCode+"&ftktestid="+ftktestid+"&mandalCode="+mcode+"&panchayatCode="+pcode+"&habCode="+hcode;
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
   // alert(" in Validate 1 function");
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
		
		//alert(" date2" +date2);
		// alert(" date3" +date3);
		
		//alert(" in validarte Sridhar"+ date1);
		if(date3<date2)
		{
	    	alert("Forward Date must be less than or equal to Current date");		
		    return flag;
		 }	
		else if(date2<date1){
		alert("Forward Date must be less than or equal to Test date");		
		return flag;
		}
		else {flag="true";
		return flag;}
		}
 
 }
 
function ftksave(){
	
  var flagg="false"; 
  var subflag="false"; 
 // alert("1:"+document.forms[0].ftklab.value);

 if(document.forms[0].circleOfficeCode.value=="")
 {
     alert("Circle is Required");
	   return false;
 }

else if(document.forms[0].ftklab.value=="ftk") 
{
	alert("ftk");

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
      // alert("Please select any of contaminated parameters");
      
      if(document.forms[0].ftklab.value!="")
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
    	   if(fnAdd2(1)){
       		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=update&ftklab="+document.forms[0].ftklab.value;
	       	document.forms[0].submit();
    	   }
       }
       
     }  
       
	  else if(document.forms[0].ftklab.value=="lab") 
	  {
		//  alert("lab");

	     /* if(document.forms[0].testCode.value=="")
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
	     else{ */
	    	 if(fnAdd2(1)){
	          document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=update";
	 	     document.forms[0].submit();
	    	 }
  	      // }
 } 
 }

function ftkview(){

   if(document.forms[0].circleOfficeCode.value=="")
   { 
     alert("Circle is required");
     return false;
     }
     else{  
      document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=view";
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
	      document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=View";
		  document.forms[0].submit();
	  }
}
function ftkupdate(){
//  alert("1");
alert(document.forms[0].contamin.value);
  if(document.forms[0].contamin.value=="YES")
   {
   //  alert("2-YES");
            document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=update";
             document.forms[0].submit();
           
	   }
	    
  else if(document.forms[0].contamin.value=="NO")
    {
      // alert(" in No Contamination of Update block");
      document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=update";
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
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&ftklab=ftk&mode1=formftk";
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
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&ftklab=lab&mode1=formlab";
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
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=reset";
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
  //alert(" in  add sources");
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

alert(" end of add sources");

}//end of showAssets
function showSources()
{
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

function getData()
{

  
if(document.forms[0].ftklab[0].checked==true){
  // alert("1"+document.forms[0].contamin.value);
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=dataedit&ftklab=ftk";
	document.forms[0].submit();
	}
	else if(document.forms[0].ftklab[1].checked==true){

	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=dataedit&ftklab=lab";
	document.forms[0].submit();
	}
	else if(document.forms[0].ftklab[0].checked==false && document.forms[0].ftklab[1].checked==false){

	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=dataedit";
	document.forms[0].submit();
	
	}
}
function getData1()
{
	var newCon = document.forms[0].contamin.value;
	var oldCon = '<%=contamin%>';
	if(document.forms[0].ftklab.value=="ftk"){
		//alert("in ftk");
		//alert("1"+document.forms[0].contamin.value);
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=dataedit&ftklab=ftk";
		document.forms[0].submit();
	}
	else if(document.forms[0].ftklab.value=="Lab"){
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=dataedit&ftklab=lab";
		document.forms[0].submit();
	}
}
function getSourceCodes()
{
	if(document.forms[0].mandalCode.value!="")
	{
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&ftklab=ftk";
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
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&ftklab=ftk";
		document.forms[0].submit();
	}
	else 
	{
		document.forms[0].sourceType.value="";
		alert("Please Select Habitation");
	}
 }



//-->

</SCRIPT><%@ include file="/commons/rws_header2.jsp" %>
<body onload = "checkforward();">
<html:form action="/WaterSample.do">
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>	
 	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
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
		String srccode=(String)session.getAttribute("forwardedsurcCode");
		String srctype=(String)session.getAttribute("forwardedsurcType");
		String forwardedftkid=(String)session.getAttribute("forwardedftkid");
		String forwardedmcode="",forwardedpcode="",forwardedhcode="";


			
        String circleOfficename=(String)session.getAttribute("circleOfficeName");
		String divOfficename=(String)session.getAttribute("divisionOfficeName");
		String subDivOfficename=(String)session.getAttribute("subDivisionOfficeName");


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
		<html:hidden property="forwardedsurcCode" value='<%=srccode%>'/>
		<html:hidden property="forwardedsurcType" value='<%=srctype%>'/>
		<html:hidden property="forwardedftkid" value='<%=forwardedftkid%>'/>		
		<html:hidden property="forwardedmcode" value='<%=forwardedmcode%>'/>
		<html:hidden property="forwardedpcode" value='<%=forwardedpcode%>'/>
		<html:hidden property="forwardedhcode" value='<%=forwardedhcode%>'/>
		</td>
	 
	<td class="bwborder"><FONT class=myfontclr>Circle&nbsp;<font color="#FF6666">*</font>:</FONT></td>
	<td class="bwborder">
		<html:text property="circleOfficeName"  readonly="true" styleClass="mytext" />
		<html:hidden property="circleOfficeCode"/>
	 </td>
	 
    <td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
	<td class="bwborder">
			<html:text property="divisionOfficeName"  readonly="true" styleClass="mytext"/>
			<html:hidden property="divisionOfficeCode"  />
	</td>
		
   </tr>
     <tr>
	<td class="bwborder"><FONT class=myfontclr>Sub Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
	<td class="bwborder">
			<html:text property="subDivisionOfficeName"  readonly="true" styleClass="mytext"/>
			<html:hidden property="subdivisionOfficeCode"  />
	</td>
	
 <td class="bwborder"><FONT class=myfontclr>Type Of test</font></td> 	
<%
String ftklabval=request.getParameter("ftklab");

if(ftklabval!=null && ftklabval.equals("ftk")){%>	
 <td><input type="radio" name="ftklab" value="ftk"  checked><font color="#000000" face=verdana size=2 >Ftk</td>
  <%} else if(ftklabval!=null && ftklabval.equals("lab")){%>
 <td><input type="radio" name="ftklab" value="lab"  checked><font color="#000000" face=verdana size=2 >Lab Testing</td>
  <%}
if(ftklabval!=null && ftklabval.equals("ftk")){%>
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
			<html:text property="mandalName"  readonly="true"  styleClass="mytext"/>
			<html:hidden property="mandalCode"  />
		</td>
	
		<td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666"></font></FONT></td>
		<td align=left >
			<html:text property="panchayatName"  readonly="true"  styleClass="mytext"/>
			<html:hidden property="panchayatCode"  />
		</td>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666"></font></FONT></td>
		<td align=left >
			<html:text property="habName"  readonly="true"  styleClass="mytext"/>
			<html:hidden property="habCode"  />
		</td>
	</tr>
	<tr><td colspan="10">&nbsp;</td></tr>
	<tr>
	<!--  ****************************************************************************************** -->
	<td colspan="10" align="center"><html:button property="mode" styleClass="btext" value="Select Sources" onclick="return showSources()" disabled="true"/>&nbsp;<input type="button" Class="btext" value="Add Sources" title="Add Source Details" style="width:140px" onclick="return addSources();"  disabled="true"/></td>
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
			<html:select property="sourceType" styleClass="mycombo" style="width:200px" onchange="getSourceCodes()" disabled="true">
			<html:option value="">SELECT...</html:option>
<logic:present name="sources1">
				
			<html:options collection="sources1" name="rwsMaster"  property="sourceCode" labelProperty="codeName" />

</logic:present>
			</html:select>
			<html:hidden property="sourceType"/>		

			</td>
			

			<td class="bwborder"><FONT class=myfontclr>Source&nbsp;:<font color="#FF6666">*</font></FONT></td>
			
			<td class="bwborder" colspan="3">
			<html:select property="sourceCode" styleClass="mycombo" style="width:400px" onchange="getSourceLocation()" disabled="true">
			<html:option value="">SELECT...</html:option>
			<logic:present name="sourceCodes">
			<html:options collection="sourceCodes" name="rwsMaster"  property="sourceCode" labelProperty="sourceAndLocation" />
			</logic:present> 
			</html:select>
			<html:hidden property="sourceCode"/>			
			</td>
			

			<!-- 
			<td class="bwborder"><FONT class=myfontclr>Location&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder"><html:text property="location"  size="12" readonly="true" styleClass="mytext" style="width:133px"/></td>
			  -->
			
			
		</tr>
		<tr><td colspan="10">&nbsp;</td></tr>
		  <tr><td class="bwborder"><FONT class=myfontclr>Test Date&nbsp;:<font color="#FF6666">*</FONT></td>
			
			<td class="bwborder" nowrap>
			
			<html:text property="ftkTestDate" size="9"  styleClass="mytext" maxlength="10" readonly="true"/>
			<a href="javascript: showCalendar(document.waterSampleForm.ftkTestDate);">
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
			<FONT class=myfontclr><font style="font-size:7pt">DD/MM/YYYY&nbsp;&nbsp;&nbsp;&nbsp;</font></font>
			</td> 
			</tr>
	
            <tr>
          <td class="bwborder" colspan=2><FONT class=myfontclr>Water Contaminated Yes or No:<font color="#FF6666">*</font></FONT></td>
			
			<td class="bwborder" colspan=2>
			<html:select property="contamin" styleClass="mycombo" style="width:150px" onchange="getData1();">
			<html:option value="">SELECT...</html:option>
			<html:option value="YES">YES</html:option>
			<html:option value="NO">NO</html:option>
			</html:select>
			</td></tr>
			 
			
       <%//String contam=(String)request.getParameter("contamin");
       //String mode=request.getParameter("mode");
       //System.out.println(request.getParameter("contamin"));
      

     // System.out.println("contaminvalue@@@@:"+session.getAttribute("contaminvalue"));
     
       
       
        if(contamin!=null && contamin.equals("YES"))
      { 
     //  System.out.println("in contamintation yes");
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
						<td ></td>
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
						<tr><td></td> 
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
				<td class="textborder" style="width:175px" ><input type="checkbox" name="bat" value="ColiForm" checked>ColiForm</td>
				<%} else{%>
				<td class="textborder" style="width:175px" ><input type="checkbox" name="bat" value="ColiForm">ColiForm</td>
				<%} %>
				<%if(wqlist!=null && wqlist.get(8).equals("Y")){ %>
				<td class="textborder" style="width:175px" ><input type="checkbox" name="phy" value="Turbidity" checked>Turbidity</td>
				<%} else{%>
				<td class="textborder" style="width:175px" ><input type="checkbox" name="phy" value="Turbidity">Turbidity</td>
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
                
				<td >
				
				<INPUT type="checkbox" name="forwardtolab" value="forwardtolab" checked><font color="#000000" face=verdana size=2><B>Forward&nbsp;for&nbsp;Lab&nbsp;Testing</B></font></td></tr>

			<td class="bwborder"><div id='fdate' style='block'> <FONT class=myfontclr>Forward Date&nbsp;:<font color="#FF6666">*</FONT></td>
			<td class="bwborder" >
			<html:text property="forwardDate" size="9"  style='display:block' readonly="true" styleClass="mytext" maxlength="10"/>
			
			<td><div id='fcal' style='display:block'><a href="javascript: showCalendar(document.waterSampleForm.forwardDate);" >
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
			</div></td>
			</div> 
			
			</tr></tr>
	<%}}else if(ftklabval!=null && ftklabval.equals("lab")){ 
			//System.out.println("in else loop");
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
			<html:text property="mandalName"  readonly="true"  styleClass="mytext"/>
			<html:hidden property="mandalCode"  />
		</td>
	
		<td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666"></font></FONT></td>
		<td align=left >
			<html:text property="panchayatName"  readonly="true"  styleClass="mytext"/>
			<html:hidden property="panchayatCode"  />
		</td>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666"></font></FONT></td>
		<td align=left >
			<html:text property="habName"  readonly="true"  styleClass="mytext"/>
			<html:hidden property="habCode"  />
		</td>
	</tr>
	</label>
	</fieldset>
	<tr><td colspan="10">&nbsp;</td></tr>
	<tr>
	<!-- ******************************************************************************************************** -->
	<td colspan="9" align="center">
	<html:button property="mode" styleClass="btext" value="Select Sources" onclick="return showSources()" disabled="true" />&nbsp;
	<input type="button" Class="btext" value="Ftk Tested Sources" title="Ftk Tested Sources" style="width:140px" onclick="return viewFtkSources();" disabled/>&nbsp;
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
			<html:select property="testCode" styleClass="mycombo" style="width:123px" disabled="true">
			<html:option value="">SELECT...</html:option>
			<html:options collection="watertests" name="rwsMaster"  property="testCode" labelProperty="testName" />
			</html:select>
			</td>
			<html:hidden property="testCode"/>
			
			<td class="bwborder"><FONT class=myfontclr>Nature of Test&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder">
			<html:select property="natureOfTest" styleClass="mycombo" style="width:130px" disabled="true">
			<html:option value="">SELECT...</html:option>
			<html:option value="1">ROUTINE</html:option>
			<html:option value="2">SEASONAL</html:option>
			<html:option value="3">QUARTERLY</html:option>
			<html:option value="4">DISEASE OUTBREAK</html:option>
			</html:select>
			</td>
			
			<td class="bwborder"><FONT class=myfontclr>Sample Collected By&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder">
			<html:select property="sampCollectCode" styleClass="mycombo" style="width:133px" disabled="true">
			<html:option value="">SELECT...</html:option>
			<html:options collection="desgns" name="rwsMaster"  property="desgnCode" labelProperty="desgnAcr" />
			
			</html:select>
			</td>
			 
			</tr>
		<tr>	
			
			<td class="bwborder"><FONT class=myfontclr>Collection Date<br>and Time&nbsp;:<font color="#FF6666">*</FONT></td>
			<td class="bwborder" nowrap>
			<html:text property="sampCollectDate" size="9"  styleClass="mytext" maxlength="10" disabled="true"/>
			<html:text property="sampCollectTime" size="4" styleClass="mytext" maxlength="5" disabled="true"/>
			<%--<a href="javascript: showCalendar(document.waterSampleForm.sampCollectDate);">
			 <img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a> --%><br>
			<FONT class=myfontclr><font style="font-size:7pt">DD/MM/YYYY&nbsp;&nbsp;&nbsp;&nbsp;HH:MM</font></font>
			</td>
			
		
			<td class="bwborder"><FONT class=myfontclr>Assigned On&nbsp;:</FONT></td>
			<td class="bwborder"><html:text property="assignedOn" value="<%=sdf.format(new java.util.Date())%>" size="12" disabled="true" readonly="true" styleClass="mytext"/></td>
		
			<% 
			java.util.ArrayList col = new java.util.ArrayList();
			col = (java.util.ArrayList)session.getAttribute("wqlabs");
			//System.out.println("col size:"+col.size());
			 %>
			<td class="bwborder"><FONT class=myfontclr>Lab Assigned To<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder" colspan="5"><html:select property="labCode" styleClass="mycombo" style="width:133px" disabled="true">
			<html:option value="">SELECT...</html:option>
			<logic:present name="wqlabs">
			<html:options collection="wqlabs" name="rwsMaster"  property="labCode" labelProperty="location" />
			</logic:present>
			</html:select>
			</td>
		</tr>
		
		
		<%} %>
		</table>
		</label> 
		</fieldset>
		
		<fieldset>             
		<legend > Water Quality Parameters</legend>
		<label>
		
<div style="height:220px; overflow:auto"> 
<table  bordercolor= "#8A9FCD" width="99%" style="border-collapse:collapse;"  >
<tr bgcolor="green"  >
					<td align=center ><b><font color="white">Sno</font></b></td>
					<td align=center ><b><font color="white">Parameter Name</font></b></td>
					<td align=center ><b><font color="white">Min Per Val</font></b></td>
					<td align=center ><b><font color="white">Max Per Val</font></b></td>
					<td align=center ><b><font color="white">Undesired Effect</font></b></td>
					<td align=center ><b><font color="white">Result</font></b></td>
				</tr>
				<%
				  int val = -1,count1=1;
				  %>
				
			<logic:iterate id="parameters" name="parameters">
				<tr align="left" bgcolor="lightblue" >
					<td  class="bwborder"><%=count1++%></td>
					
					<td  class="bwborder" >
						<nested:hidden name="parameters" property="testPCode" 
									   indexed="true"/> 
         
						<bean:write name="parameters" property="testPName"  />
<%-- <% if(count1-1==4 || count1-1==5 || count1-1==6 || count1-1==7 || count1-1==10 || count1-1==11 || count1-1==13 || count1-1==14 || count1-1==12 ){ %> --%>

<% if(count1-1==4 || count1-1==5 || count1-1==6 || count1-1==7 || count1-1==10 || count1-1==11 ){ %>
			<font color="red"><b>*</b></font>
<%} %>
					</td>
					<td  class="bwborder" align=center>
					<bean:write name="parameters" property="minPerVal"></bean:write>
						<nested:hidden name="parameters" property="minPerVal" indexed="true"  />
					</td>
					<td  class="bwborder" align=center>
					<bean:write name="parameters" property="maxPerVal"  />
					<nested:hidden name="parameters" property="maxPerVal" indexed="true"  />
					</td>
					<td  class="bwborder" align=left width="200px">
						<bean:write name="parameters" property="undesirableEffect" />
					</td>
					<%
					val = val + 3; 
					
					%>
					<td class="bwborder" align=center>
					<nested:text name="parameters" property="result" styleClass="mytbltext" style="width:70px" indexed="true" maxlength="9" />
					</td>
				</tr>
		
				</logic:iterate>

</table>
</div>
</label>
</fieldset>
</tr>
		
	<tr><td class="bwborder"><FONT class=myfontclr>Recomendations:</FONT>&nbsp;&nbsp;&nbsp;&nbsp;<html:textarea property="recommendations" style="width:133px">
</html:textarea></td></tr>
		<html:hidden property="recommendations"/>	
		
		
	<tr>
	<td align="center">
	<%
	//System.out.println("wswwwwwwwwwwwwww:"+session.getAttribute("editCheck1"));
	if(session.getAttribute("editCheck1")==null){%>
	<html:button property="mode1" title="Save the Fields"  styleClass="btext" value="Update" onclick="ftksave();"/>
	<%}%>
	
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" onclick="Reset();" />
    <%if(ftklabval!=null && ftklabval.equals("lab")){%>
   
    <%}else if(ftklabval!=null && ftklabval.equals("ftk")){ 
   //System.out.println("edit yes or no value"+session.getAttribute("editCheck1"));
    %>
  
   <%if(session.getAttribute("editCheck1")!=null && session.getAttribute("editCheck1").equals("Y")){%>
     <html:button property="mode" title="Update the Fields( Ftk testing)" styleClass="btext" value="Update" onclick="ftksave();"/>
    <% session.removeAttribute("editCheck1");%>
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