<%String userid  = ""; %>
<style>
#black
{
	text-decoration: underline;
	color: black;
}
</style>


<script language="JavaScript">
<!--
var isHabitationStatusChangeAllowed=false;
function funcCalcTotWaterSupply()
{
var totWaterSupply=0;
if(document.forms[0].hpSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].hpSupply.value);

if(document.forms[0].pwsSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].pwsSupply.value);

if(document.forms[0].cpwsSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].cpwsSupply.value);

if(document.forms[0].mpwsSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].mpwsSupply.value);

if(document.forms[0].othersSafeSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].othersSafeSupply.value);

document.forms[0].totalWaterSupplySafeOnly.value=totWaterSupply;

}
function funcCalcTotWaterSupply1()
{
var totWaterSupply=0;

if(document.forms[0].pwsUnsafeSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].pwsUnsafeSupply.value);

if(document.forms[0].mpwsUnsafeSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].mpwsUnsafeSupply.value);

if(document.forms[0].dpSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].dpSupply.value);

if(document.forms[0].owsSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].owsSupply.value);

if(document.forms[0].pondsSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].pondsSupply.value);

if(document.forms[0].shpSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].shpSupply.value);

if(document.forms[0].othersSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].othersSupply.value);

document.forms[0].totalWaterSupplyUnsafe.value=totWaterSupply;

}
function funcCalcTotWaterSupply2()
{
var totWaterSupply=0;
//safe
if(document.forms[0].hpSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].hpSupply.value);

if(document.forms[0].pwsSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].pwsSupply.value);

if(document.forms[0].cpwsSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].cpwsSupply.value);

if(document.forms[0].mpwsSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].mpwsSupply.value);

if(document.forms[0].othersSafeSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].othersSafeSupply.value);

//unsafe
if(document.forms[0].pwsUnsafeSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].pwsUnsafeSupply.value);

if(document.forms[0].mpwsUnsafeSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].mpwsUnsafeSupply.value);

if(document.forms[0].dpSupply.value!="")
totWaterSupply=totWaterSupply+parseInt(document.forms[0].dpSupply.value);

document.forms[0].totalWaterSupplySafe.value=totWaterSupply;

}
function doBlink() {
  // Blink, Blink, Blink...
  var blink = document.all.tags("BLINK")
  for (var i=0; i < blink.length; i++)
    blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : "" 
}

function startBlink() {
  // Make sure it is IE4
  if (document.all)
    setInterval("doBlink()",140);
}
function validateInput()
  {
   var m=Math.max(document.forms[0].existSource.value,document.forms[0].safeSource.value);
   if(document.forms[0].existSource.value!=document.forms[0].safeSource.value)
   {
   if (m==document.forms[0].safeSource.value)
  	{
	alert("SafeSources should be less than ExistSources");
	document.forms[0].safeSource.value=safe_from_database;
	}
   }
  }
  
window.onload = startBlink;

<%

java.util.Date today = new java.util.Date();
int jFreezedYear=0;
try{
//java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd-MMM-yy hh:mm:ss a");
java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy");
int currentYear = Integer.parseInt(sdf1.format(today));
nic.watersoft.commons.Debug.println("current year is "+currentYear);
sdf1 = new java.text.SimpleDateFormat("mm");
int currentMonth = Integer.parseInt(sdf1.format(today));
sdf1 = new java.text.SimpleDateFormat("dd");
int currentDay = Integer.parseInt(sdf1.format(today));
java.util.Calendar c1 = java.util.Calendar.getInstance(); 
java.util.Calendar c2 = java.util.Calendar.getInstance(); 
c1.set(currentYear, currentMonth , currentDay); 
c2.set(currentYear, 3 , 31);
//System.out.println("checking if");
if(c1.before(c2))
{
//Debug.println("current year is "+currentYear+" current month is "+currentMonth+" current Day "+currentMonth);
jFreezedYear=currentYear-2;
//System.out.println("in if");
}
else
{
//System.out.println("current year is "+currentYear+" current month is "+currentMonth+" current Day "+currentMonth);
//System.out.println("in else");
jFreezedYear=currentYear-1;
}}catch(Exception e){
//System.out.println("exception in jsp is "+e);
}
//System.out.println("Freezed Year in rws_HabStatusEntry_frm.jsp is "+jFreezedYear);

%>
//var freezedYear=<%=jFreezedYear%>;
var freezedYear=2006;
function isValid()
{
	if(document.getElementById('slip').style.display=='none')
	{
		document.forms[0].SlipDivStatus.value = '0';
	}
	else
	{
		document.forms[0].SlipDivStatus.value = '1';
		if(document.forms[0].slipReasonCode.value=="")
		{
			alert("Please Select Reason for Slippage");
			return false;
		}
	}
	
	//window.opener.location.reload(true);
		if(document.getElementById('covnc').style.display=='none')
		{
			document.forms[0].ncSourceType.value =  '';
		}
	if(isFreezed())
	{
		alert("Habitation Status is freezed for the year "+freezedYear);
		return false;
	}
	
	else if(validateHabStatusForm(habStatusForm))
	{
		document.forms[0].status.disabled=false;
		if(document.forms[0].censusYear.value=="")
		{
			alert("Please Select Census Year");
			return false;
		}
		if(document.forms[0].habType.value=="")
		{
			alert("Please Select Habitation Type");
			return false;
		}
		if(document.forms[0].habSubType.value=="")
		{
			alert("Please Select Habitation SubType");
			return false;
		}
        if(document.forms[0].status.value=="")
		{
			alert("Please Select Current Coverage Status");
			return false;
		}
	/*	if(document.forms[0].lpcdCooking.value=="")
		{
			alert("Please Enter Safe LPCD of Drinking & Cooking Value");
			return false;
		}
		if((parseFloat(document.forms[0].levelOfWaterSupply.value))<=(parseFloat(document.forms[0].lpcdCooking.value)))
		{
			alert("Safe LPCD of Drinking & Cooking Value Should Not Exceed Actual LPCD Value");
			document.forms[0].lpcdCooking.focus();
			document.forms[0].lpcdCooking.value = '';
			document.forms[0].lpcdCooking.focus();
			return false;
		} */
		if(document.getElementById('conti').style.display=='none')
		{
			document.forms[0].flouride.value = '0.0';
			document.forms[0].brakish.value = '0.0';
			document.forms[0].iron.value = '0.0';
			document.forms[0].aresenic.value = '0.0';
			document.forms[0].nitrate.value = '0.0';
		}
		if(document.forms[0].netPop.value==0)
			document.forms[0].levelOfWaterSupply.value="";
		//if(isNaN(document.forms[0].levelOfWaterSupply))
		//	document.forms[0].levelOfWaterSupply.value="";
		if(document.forms[0].levelOfWaterSupply.value=='?')
			document.forms[0].levelOfWaterSupply.value="";
		var checkCount = 0;
		var checkValue1 = 0;		
		var checkValue2 = 0;		
		var checkValue3 = 0;		
		var checkValue4 = 0;		
		var checkValue5 = 0;										
		if(document.forms[0].status.value=='NSS')
		{
			if(document.forms[0].contTypes1.checked == false && document.forms[0].contTypes2.checked == false && document.forms[0].contTypes3.checked == false && document.forms[0].contTypes4.checked == false && document.forms[0].contTypes5.checked == false)
			{
				alert("Please Select Contamination Type for NSS Habitation");
				return false;
			}
			if(document.forms[0].contTypes1.checked == true)checkCount=checkCount+1;
			if(document.forms[0].contTypes2.checked == true)checkCount=checkCount+1;
			if(document.forms[0].contTypes3.checked == true)checkCount=checkCount+1;
			if(document.forms[0].contTypes4.checked == true)checkCount=checkCount+1;
			if(document.forms[0].contTypes5.checked == true)checkCount=checkCount+1;
			if(checkCount>1)
			{
				alert("Please Select One Contamination Type Only");
				return false;
			}
			else if(checkCount==1)
			{
				checkValue1 = document.forms[0].flouride.value;
				checkValue2 = document.forms[0].brakish.value;
				checkValue3 = document.forms[0].iron.value;
				checkValue4 = document.forms[0].aresenic.value;
				checkValue5 = document.forms[0].nitrate.value;
				if(parseFloat(checkValue1)>0)
				{
					if(!document.forms[0].contTypes1.checked)
					{
						alert("Flouride Contains : "+checkValue1+" (PPM)");
						if(!confirm("Do you want to update the contamination type"))
						{
							document.forms[0].contTypes1.checked = true;
							document.forms[0].contTypes2.checked = false;
							document.forms[0].contTypes3.checked = false;
							document.forms[0].contTypes4.checked = false;
							document.forms[0].contTypes5.checked = false;
							return false;
						}
						else
						{
							return true;
						}
					}
					else
					{
						return true;
					}
				}
				if(parseFloat(checkValue2)>0)
				{
					if(!document.forms[0].contTypes2.checked)
					{
						alert("Brakish Contains : "+checkValue2+" (PPM)");
						if(!confirm("Do you want to update the contamination type"))
						{
							document.forms[0].contTypes1.checked = false;
							document.forms[0].contTypes2.checked = true;
							document.forms[0].contTypes3.checked = false;
							document.forms[0].contTypes4.checked = false;
							document.forms[0].contTypes5.checked = false;
							return false;
						}
						else
						{
							return true;
						}
					}
					else
					{
						return true;
					}
				}
				if(parseFloat(checkValue3)>0)
				{
					if(!document.forms[0].contTypes3.checked)
					{
						alert("Iron Contains : "+checkValue3+" (PPM)");
						if(!confirm("Do you want to update the contamination type"))
						{
							document.forms[0].contTypes1.checked = false;
							document.forms[0].contTypes2.checked = false;
							document.forms[0].contTypes3.checked = true;
							document.forms[0].contTypes4.checked = false;
							document.forms[0].contTypes5.checked = false;
							return false;
						}
						else
						{
							return true;
						}
					}
					else
					{
						return true;
					}
				}
				if(parseFloat(checkValue4)>0)
				{
					if(!document.forms[0].contTypes4.checked)
					{
						alert("Aresenic Contains : "+checkValue4+" (PPM)");
						if(!confirm("Do you want to update the contamination type"))
						{
							document.forms[0].contTypes1.checked = false;
							document.forms[0].contTypes2.checked = false;
							document.forms[0].contTypes3.checked = false;
							document.forms[0].contTypes4.checked = true;
							document.forms[0].contTypes5.checked = false;
							return false;
						}
						else
						{
							return true;
						}
					}
					else
					{
						return true;
					}
				}
				if(parseFloat(checkValue5)>0)
				{
					if(!document.forms[0].contTypes5.checked)
					{
						alert("Nitrate Contains : "+checkValue5+" (PPM)");
						if(!confirm("Do you want to update the contamination type"))
						{
							document.forms[0].contTypes1.checked = false;
							document.forms[0].contTypes2.checked = false;
							document.forms[0].contTypes3.checked = false;
							document.forms[0].contTypes4.checked = false;
							document.forms[0].contTypes5.checked = true;
							return false;
						}
						else
						{
							return true;
						}
					}
					else
					{
						return true;
					}
				}
			}
		}
		return true;
//return false;
	}
	else return false;


}
 function isFreezed()
 {
 
 var year=document.forms[0].habYear.value.substring(6,10);
 if(year>freezedYear)
 return false;
 else
 return true;
 }
 function checkEndYear()
 {
	 var thisdate = new Date();
	 var curyr = thisdate.getYear();
	
	 var habyr =habStatusForm.habYear.value;
	
	 habyr = habyr.substr(6,4);
	
  
      if(parseInt(curyr)<parseInt(habyr)){
        alert("Status Year Must be Either Equal to Current year or Less than Current year"); 
       habStatusForm.habYear.value="";
		habYear.getFocus();
        return false;
      }else
        return true;   
       
 }

function resetfn()

{
	alert(habStatusForm.circleOfficeCode.value);
if(habStatusForm.circleOfficeCode.value!="")
{
	
	document.forms[0].action="switch.do?prefix=/masters&page=/HabStatus.do&mode=resetForm";
	document.forms[0].submit();
	}
}
function getItem(id)
    {
        var itm = false;
        if(document.getElementById)
            itm = document.getElementById(id);
        else if(document.all)
            itm = document.all[id];
        else if(document.layers)
            itm = document.layers[id];

        return itm;
    }

    function toggleAll(dowhat)
    {
        var tags = document.getElementsByTagName('tbody');
        if(!tags)
            return false;

        for(var i = 0; i < tags.length; i++)
        {
            if(tags[i].className == 'collapse_obj')
            {
                if(dowhat == 'collapse')
                    tags[i].style.display = 'none';
                else
                    tags[i].style.display = '';
            }
        }

        return false;
    }

    function toggleItem(id)
    {   
        setValue();
        itm = getItem(id);
        if(id=="collapse_myTbody2")
          var im = "onea";
        else
           var im = "oneb";
        if(!itm)
            return false;
        if(itm.style.display == 'none'){
            itm.style.display = '';
            if (document.images[im]) {
			document.images[im].src = "../images/collapse.gif";
		    }
        }    
        else{
		      itm.style.display = 'none';
		      if (document.images[im]) {
			document.images[im].src = "../images/expand.gif";
		   }
	    }	      

        return false;
    }
function fnGetComponentDetails(component)
{

	var typeOfAssetCode = "00";
	if(component == 'HAND PUMPS')
		typeOfAssetCode = "04";
	else
	if(component == 'PWS')
		typeOfAssetCode = "01";
	else		
	if(component == 'CPWS')
		typeOfAssetCode = "03";
   else
   	if(component == 'MPWS')
		typeOfAssetCode = "02";			
   else
   	if(component == 'Extension of Scheme')
		typeOfAssetCode = "05";			
   else	
	  if(component == 'PONDS')
		typeOfAssetCode = "07";			
	 else if(component =='DW Tanks')
		typeOfAssetCode = "07";				
     else  if(component =='SHALLOW HAND PUMPS')
     	typeOfAssetCode = "05";	
     else  if(component =='OPEN WELLS')
     	typeOfAssetCode = "06";		
	else
		typeOfAssetCode = "00";

	if(typeOfAssetCode == '00')
		alert("No details available.");
	else			
	{
		var habCode = document.getElementById("habCode").value;	
		var url = "switch.do?prefix=/masters&page=/ShowComponentDetails.do"
			+ "&typeOfAssetCode="+typeOfAssetCode+"&habCode="+habCode;
			
		var properties = "width=760,height=400,left=120,top=70,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   	   + "scrollbars=yes,copyhistory=no,resizable=yes";
		window.open(url,"", properties);
	}
}
function getHabDirData1()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/HabData.do";
	document.forms[0].submit();
}
function getHabDirData(that)
{
	var field = that.name;
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/masters&page=/HabData.do"
			+ "&mode=circles";
	else
	/*
	if(field == 'circleOfficeCode')
	 		url = "switch.do?prefix=/masters&page=/HabData.do"
			+ "&mode=divisions";*/
	if(field == 'circleOfficeCode')
	 		url = "switch.do?prefix=/masters&page=/HabData.do"
			+ "&mode=mandals";
	else
	if(field == 'divisionOfficeCode')	
			url = "switch.do?prefix=/masters&page=/HabData.do"
			+ "&mode=subdivisions";	
	else
	if(field == 'subdivisionOfficeCode')	
			url = "switch.do?prefix=/masters&page=/HabData.do"
			+ "&mode=mandals";	
	frm.action = url;
	frm.submit();

}
function viewfun()
{
  var message="";
  if(habStatusForm.circleOfficeCode.value=="")
     message=message+"Circle is required\n";
  /*
  if(habStatusForm.divisionOfficeCode.value=="")
     message=message+"Division is required\n";
  if(habStatusForm.subdivisionOfficeCode.value=="")
     message=message+"Sub Division is required\n";
     */
  if(habStatusForm.mandal.value=="")
     message=message+"Mandal is required\n";
 
   if(message=="")
     return true;     
   else{
    alert(message);
    return false;
   } 
}
 function getData()
  {
  for(i=1;i<=document.forms[0].elements.length;i++)
   {
       if(document.forms[0].elements[i].name=="contType")
         if(document.forms[0].elements[i].checked)
         {
               document.getElementById('perc').style.display='block'
         }
             
   }
 }
function setValue()
{
var coverage_stauts_database1=0;
var coverage_stauts_form=0;
coverage_stauts_database=document.forms[0].prevYrStatus.value;
 if(habStatusForm.qualityAffected)
 {
	  if(habStatusForm.status.value=="NSS")
	  {
	      habStatusForm.qualityAffected.value = "Y"
	      document.getElementById('conti').style.display='block'
	     
	  }
	  else{
	      habStatusForm.qualityAffected.value = "N";
	     document.getElementById('conti').style.display='none'
	   }
  }
 if(habStatusForm.status.value!="FC")
	{
	
	  document.getElementById('FCcover').style.display='block'
 }
 else
	{
	
	  document.getElementById('FCcover').style.display='none'
	  
	}

//Code to Display Slippage Coverage Form elements
if(coverage_stauts_database=='FC')
  coverage_stauts_database1=1;
if(coverage_stauts_database=='PC4')
  coverage_stauts_database1=2;
if(coverage_stauts_database=='PC3')
  coverage_stauts_database1=3;
if(coverage_stauts_database=='PC2')
  coverage_stauts_database1=4;
if(coverage_stauts_database=='PC1')
  coverage_stauts_database1=5;
if(coverage_stauts_database=='NC')
  coverage_stauts_database1=6;
if(coverage_stauts_database=='NSS')
  coverage_stauts_database1=7;
  
  
if(document.forms[0].status.value=='FC')
  coverage_stauts_form=1;
if(document.forms[0].status.value=='PC4')
  coverage_stauts_form=2;
if(document.forms[0].status.value=='PC3')
  coverage_stauts_form=3;
if(document.forms[0].status.value=='PC2')
  coverage_stauts_form=4;
if(document.forms[0].status.value=='PC1')
  coverage_stauts_form=5;
if(document.forms[0].status.value=='NC')
  coverage_stauts_form=6;
if(document.forms[0].status.value=='NSS')
  coverage_stauts_form=7;  
if(coverage_stauts_database1!=0)
{
	if(coverage_stauts_database1 != coverage_stauts_form)
	{
		if(coverage_stauts_database1 < coverage_stauts_form)
			{
			document.getElementById('slip').style.display='block';
			}
		else
			{
			 document.getElementById('slip').style.display='none';
			}
	}
	else
	{
		document.getElementById('slip').style.display='none';
	}
}
else
{
	document.getElementById('slip').style.display='none';
}
}


function fnCalculatePCPDTotal()
{
	var pcpdDrinking = parseFloat(habStatusForm.pcpdDrink.value);
	var pcpdOthers = parseFloat(habStatusForm.pcpdOthers.value);
	
	if(isNaN(pcpdDrinking))
		pcpdDrinking = 0;
	if(isNaN(pcpdOthers))
		pcpdOthers = 0;
	var pcpdTotal = parseFloat(pcpdDrinking) + parseFloat(pcpdOthers);
	habStatusForm.pcpdTotal.value = pcpdTotal.toFixed(2);
}

function findTotal(pop)
{
	if(pop == "totPop")	
	{
		var censusPop = parseInt(habStatusForm.censusPop.value);
		var censusSc = parseInt(habStatusForm.censusSc.value);
		var censusSt = parseInt(habStatusForm.censusSt.value);
		
		if(isNaN(censusPop))
			censusPop = 0;
		if(isNaN(censusSc))
			censusSc = 0;		
		if(isNaN(censusSt))
			censusSt = 0;
					
		habStatusForm.totPop.value = parseInt(censusPop) + parseInt(censusSc) 
								   + parseInt(censusSt); 
	}
	else 
	if(pop == "netPop")	
	{
		var censusPop = parseInt(habStatusForm.censusPop.value);
		var censusSc = parseInt(habStatusForm.censusSc.value);
		var censusSt = parseInt(habStatusForm.censusSt.value);
		var floatPop = parseInt(habStatusForm.floatPop.value)
		
		if(isNaN(censusPop))
			censusPop = 0;
		if(isNaN(censusSc))
			censusSc = 0;		
		if(isNaN(censusSt))
			censusSt = 0;
		if(isNaN(floatPop))
			floatPop = 0;	
					
		habStatusForm.netPop.value = parseInt(censusPop) + parseInt(censusSc) 
								   + parseInt(censusSt) + parseInt(floatPop); 
		
	}
	else 
	if(pop == "popCvrd")	
	{
		var popCovered = parseInt(habStatusForm.popCovered.value);
		var stCovered = parseInt(habStatusForm.stCovered.value);
		var scCovered = parseInt(habStatusForm.scCovered.value);

		if(isNaN(popCovered))
			popCovered = 0;
		if(isNaN(stCovered))
			stCovered = 0;
		if(isNaN(scCovered))
			scCovered = 0;	

		habStatusForm.totPopCvrd.value = parseInt(popCovered) + parseInt(stCovered) + parseInt(scCovered); 
	}
	else 
	if(pop == "levelOfWater")	
	{
		funcCalcTotWaterSupply();funcCalcTotWaterSupply2();funcCalcTotWaterSupply1();
		var totalWaterSupplySafe = parseInt(habStatusForm.totalWaterSupplySafe.value);
		var totalWaterSupplySafeOnly = parseInt(habStatusForm.totalWaterSupplySafeOnly.value);
		var totalWaterSupplyUnsafe = parseInt(habStatusForm.totalWaterSupplyUnsafe.value);	
		
		habStatusForm.totalWaterSupplySafePlusUnsafe.value=totalWaterSupplySafe+totalWaterSupplyUnsafe;
		/*
		var totPop = parseInt(habStatusForm.totPop.value);
		var levelOfWater = totalWaterSupply / totPop;
		*/
		var netPop = parseInt(habStatusForm.netPop.value);
		//var levelOfWater = totalWaterSupply / netPop;
		
		var thisdate = new Date();
	 	var presentYear = thisdate.getYear();
	 	var censusYear=document.forms[0].censusYear.value;
	 	var levelOfWater0=totalWaterSupplySafe/(netPop*Math.pow(1.01,presentYear-censusYear));
	 	var levelOfWater=totalWaterSupplySafeOnly/(netPop*Math.pow(1.01,presentYear-censusYear));
	 	var levelOfWater1=totalWaterSupplyUnsafe/(netPop*Math.pow(1.01,presentYear-censusYear));	 	
		if(levelOfWater0=='Infinity')
			habStatusForm.levelOfWaterSupply.value = 0.0;
		if(isNaN(levelOfWater0))
		{
			habStatusForm.levelOfWaterSupply.value = 0.0;
		}
		else
		{
			habStatusForm.levelOfWaterSupply.value = levelOfWater0.toFixed(2);
		}
		if(levelOfWater=='Infinity')
			habStatusForm.levelOfWaterSupplySafeOnly.value = 0.0;
		if(isNaN(levelOfWater))
		{
			habStatusForm.levelOfWaterSupplySafeOnly.value = 0.0;
		}
		else
		{
			habStatusForm.levelOfWaterSupplySafeOnly.value = levelOfWater.toFixed(2);
		}
		if(levelOfWater1=='Infinity')levelOfWater1=0.0;
		if(isNaN(levelOfWater))
		{
			habStatusForm.unsafeLpcd.value = 0.0;
		}
		else
		{
			habStatusForm.unsafeLpcd.value = levelOfWater1.toFixed(2);
		}
		habStatusForm.totalLpcdSafePlusUnsafe.value = (parseFloat(habStatusForm.levelOfWaterSupplySafeOnly.value)+parseFloat(habStatusForm.unsafeLpcd.value)).toFixed(2);
		var cook = (levelOfWater/4).toFixed(0);
		if(cook<1 && cook>0){cook=1;}else{cook=parseInt(levelOfWater0/4);}
		habStatusForm.lpcdCooking.value=cook;
	
		var calCoverageStatus = "";
		if(levelOfWater0>0)
		{	
			if(levelOfWater0>0 && levelOfWater0<10)
			{
					calCoverageStatus = "PC1";
			}
			else if(levelOfWater0>=10 && levelOfWater0<20)
			{
					calCoverageStatus = "PC2";
			}
			else if(levelOfWater0>=20 && levelOfWater0<30)
			{
					calCoverageStatus = "PC3";
			}
			else if(levelOfWater0>=30 && levelOfWater0<40)
			{
					calCoverageStatus = "PC4";
			}
			else if(levelOfWater0>=40)
			{
					calCoverageStatus = "FC";
			}
		}
		else
		{
			var totalSuppUnsafe = parseInt(habStatusForm.totalWaterSupplyUnsafe.value);
			if(totalSuppUnsafe==0)
				calCoverageStatus = "NC";
			else  if(totalSuppUnsafe>0)
				calCoverageStatus = "NSS";
		}
		//alert(calCoverageStatus);
		habStatusForm.status.value = calCoverageStatus;
		addOption(calCoverageStatus);
		setValue();
	}

}

function getTotal(index)
{
	var plainPop = document.getElementById("HABWATERSUPPLY_LIST["+index+"].plainPop").value;
	var scPop = document.getElementById("HABWATERSUPPLY_LIST["+index+"].scPop").value;
	var stPop = document.getElementById("HABWATERSUPPLY_LIST["+index+"].stPop").value;
	document.getElementById("HABWATERSUPPLY_LIST["+index+"].totalPop").value = parseInt(plainPop)+parseInt(scPop)+parseInt(stPop);
	
	var plainPop = parseInt(habStatusForm.censusPop.value);
	var scPop = parseInt(habStatusForm.censusSc.value);
	var stPop = parseInt(habStatusForm.censusSt.value);
	
	if(isNaN(censusPop))
		censusPop = 0;
	if(isNaN(censusSc))
		censusSc = 0;		
	if(isNaN(censusSt))
		censusSt = 0;
		
}
var tot=0;
function getTotalWS(index)
{
	//var plainPop = document.getElementById("totalWaterSupply").value;
	
	var totPop = document.getElementById("HABWATERSUPPLY_LIST["+index+"].totalPop").value;
	tot=tot+parseInt(totPop);
	document.getElementById("totalWaterSupply").value=tot;

}
var safe_from_database=0;
var coverage_stauts_database=0;
function init()
{
findTotal('levelOfWater');
//CODE TO STORE THE VALUE OF NO.OF SAFE SOURCES FROM DATABASE and coverage status
safe_from_database=document.forms[0].safeSource.value;
coverage_stauts_database=document.forms[0].prevYrStatus.value;
var cuur_stat=document.forms[0].status.value;
var prev_status=document.forms[0].prevYrStatus.value;
document.getElementById('slip').style.display='none';


if(cuur_stat=='FC')
  cuur_stat=1;
if(cuur_stat=='PC4')
  cuur_stat=2;
if(cuur_stat=='PC3')
  cuur_stat=3;
if(cuur_stat=='PC2')
  cuur_stat=4;
if(cuur_stat=='PC1')
  cuur_stat=5;
if(cuur_stat=='NC')
  cuur_stat=6;
if(cuur_stat=='NSS')
  cuur_stat=7;
  
  
if(prev_status=='FC')
  prev_status=1;
if(prev_status=='PC4')
  prev_status=2;
if(prev_status=='PC3')
  prev_status=3;
if(prev_status=='PC2')
  prev_status=4;
if(prev_status=='PC1')
  prev_status=5;
if(prev_status=='NC')
  prev_status=6;
if(prev_status=='NSS')
  prev_status=7;  


		
			if(prev_status < cuur_stat)
			{
			document.getElementById('slip').style.display='block';
			}
			else
			{
			document.getElementById('slip').style.display='none';
			}
		
		
		

//CODE TO FREEZE
var ad='<%= (String)session.getAttribute("userId")%>';
// if u dont want to permit the user to modify the Coverage status
// compare the user id like this---->ad!=admin
if(ad=="")
{
		document.forms[0].status.disabled=true;
		var coverageStatus=document.forms[0].status.value;
	    if (document.all) 
		{
		    document.all['divStatus'].innerHTML = "<input type='text' name='status' value='"+coverageStatus+"' style='width:35px' readOnly > ";
		 } 
		 else if(document.getElementById("divStatus").innerHTML)
		 {
		    var couldbenetscape = document.getElementById("divStatus");
		    couldbenetscape.innerHTML = "<input type='text' name='status' value='"+coverageStatus+"' style='width:35px' readOnly > ";
		}
//END OF CODE TO FREEZE
	//document.getElementById("divStatus").innerHtml="";
	//document.getElementById("divStatus").innerHtml="<input type='text' name='status' value="+coverageStatus+" style='width:20px' readOnly  >"
	//}
}
toggleItem('collapse_myTbody2');

//if(document.forms[0].habYear.value=="")
//var d = new Date();
//var cur_year = d.getYear();
//var d1 = new Date();
//var mon = d1.getMonth();
//if(mon==1 || mon==2 || mon==3)
//{
//	cur_year=cur_year-1;
//}
//var update_year = "01/04/"+cur_year;
//document.forms[0].habYear.value=update_year;
}
function checkCookLpcd()
{
	if((parseFloat(document.forms[0].levelOfWaterSupply.value))<=(parseFloat(document.forms[0].lpcdCooking.value)))
	{
		alert("Safe LPCD of Drinking & Cooking Value Should Not Exceed Actual LPCD Value");
		document.forms[0].lpcdCooking.focus();
		document.forms[0].lpcdCooking.value = '';
		document.forms[0].lpcdCooking.focus();
	}
}
-->
</script>
<body onload="init();"></body>