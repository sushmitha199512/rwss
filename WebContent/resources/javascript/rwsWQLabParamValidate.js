// rwsWQLabValidate.js



function checkMandatoryAndRanges(names,displaymessage,min,max)
{
	
	
	var flags = false;
	var values = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;	

	if(values==null || values=="")
	{
		alert("Please Enter the value for "+displaymessage);
	}
	else
	{
		
		if(parseFloat(values)<parseFloat(min))
		{
		
			
			alert(displaymessage+" Must be greater than or equal to "+min);
			flags = false;
		}
		else if(parseFloat(values)>parseFloat(max))
		{
			alert(displaymessage+" Must be less than or equal to "+max);
			flags = false;
		}
		else
		{
			flags = true;
		}
	}
	return flags;
}

function checkMandatoryAndRanges1(names,displaymessage,min,max)
{
	var flags = false;
	var values = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;	
	
	names = parseInt(names)-1;
	var values1 = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;	
	
	
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

function checkMandatoryAndRanges4(names,displaymessage,min,max)
{
	//alert("names**range4*"+names);
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


function checkMandatory(names,displaymessage)
{
	//alert("names**desolved*"+names);
	var flags = false;
	
	var values = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;
	//alert("values****"+values);
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


function checkMandatory1(names,displaymessage)
{
	//alert("names**alkanity*"+names);
	var flags = false;
	
	var values = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;
	//alert("values*alkanity***"+values);
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


function fnAdd1(testCode)
{
//	alert("testCode"+testCode);
 
	var flag=false;
	
	if(testCode=="1")
	{
		
	//	alert("1111111111111");
    	if(checkMandatoryAndRanges('0','pH Ranges',6,9)==true)
    	{
    		if(checkMandatory('1','Dissolved Solids')==true)
    		{
    			if(checkMandatoryAndRanges1('2','Total Hardness')==true)
        		{
    				if(checkMandatory1('3','Alkalinity')==true)
    				{
    					if(checkMandatory('4','Chloride')==true)
						{
							if(checkMandatoryAndRanges('5','Fluoride',0,20)==true)
							{
								/*if(checkMandatoryAndRanges('6','Sulphate',0,400)==true)
								   {
							if(checkMandatoryAndRanges('7','Nitrate',0,999)==true)
							{
								if(checkMandatoryAndRanges('8','Iron',0,10)==true)
								{*/
									if(checkMandatoryAndRanges4('','',document.getElementById("TESTPARAM_LIST[1].result").value,parseFloat(document.getElementById("TESTPARAM_LIST[2].result").value)+parseFloat(document.getElementById("TESTPARAM_LIST[4].result").value))==true)
									{
										flag = true;
									}
									
							/*	}
							}
							}*/
								
							}
						}
    				
    				}
    				
        		}
    		
    		}
    		
    	}
	 }
	 else if(testCode=="2")
	{
		 
			//alert("testCode elsr"+testCode);
			 
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
		//var testIdd = '<%=testId%>';
		//var url = "switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=saveQT&testId="+testIdd;
		//document.forms[0].action=url;
		//document.forms[0].submit();
		//window.close();
      return true;
	}

return false;


}


function ValidNumber(value) {
	
value=value-1;
var minValue=parseFloat(document.getElementById("TESTPARAM_LIST["+value+"].minPerVal").value);
//alert("minValue"+minValue);

var maxValue=parseFloat(document.getElementById("TESTPARAM_LIST["+value+"].maxPerVal").value);

//alert("maxValue"+maxValue);
if(!isNaN(document.getElementById("TESTPARAM_LIST["+value+"].result").value)){
var resultValue=parseFloat(document.getElementById("TESTPARAM_LIST["+value+"].result").value);

	
//alert(resultValue);
if(resultValue!=""){
  if(resultValue<minValue || resultValue>maxValue ){
	  
	  alert("Please re-check the reported value, as it is above/below the permissible range.");
  }
}
	
	
	return true;
}else{
document.getElementById("TESTPARAM_LIST["+value+"].result").value="";
//document.getElementById("TESTPARAM_LIST["+value-1+"].result").focus;
   alert("Invalid Number");
  return false;
}
   
}



      function ValidNumber1(value){  

  if(!isNaN(document.getElementById("TESTPARAM_LIST["+value+"].result").value))
	{
    	 alert("inivalid number");
		  return false;
	}else{
		return true;
}




         if(document.getElementById("TESTPARAM_LIST["+value+"].result").value==""){return true;}
       // var regEx = /^\d{1,2}\.\d{1,2}$/;  
        //var regEx = /^\d{3}\.\d{3}$/;  
         var regEx="/[0-9]{3}\.[0-9]{2}$/";
        bValid = document.getElementById("TESTPARAM_LIST["+value+"].result").value.match(regEx);  

        if(!bValid){  
alert('incorrect format');
document.getElementById("TESTPARAM_LIST["+value+"].result").value="";
document.getElementById("TESTPARAM_LIST["+value+"].result").focus;
          return false;           
        }  
        else return true;  
      }  




            function IsNumeric(input) {
		    return /^-?(0|[1-9]\d*|(?=\.))(\.\d+)?$/.test(input);
			}


     
