
<SCRIPT language="JavaScript">
var myWin=null;
function openWin(aURL) {
 if (!myWin || myWin.closed ) {
 myWin=window.open(aURL,'',"top=100,left=0,height="+screen.availHeight/2+",width="+screen.availWidth+",location=0,scrollbars=1,directories=0,toolbar=yes,resizable=1,status=1");
 } 
 else{
  myWin.location=aURL;
  myWin.focus();
 }
}
 function  subComponentClicked1(compname,sumcompname)
 { 
		 var ccode=document.getElementById('circleName').value;
		 var mcode=document.getElementById('mandalName').value;
		 var dName=document.getElementById('districtName').value;

		 
		var divcode=document.getElementById('divisionName').value;
		var subcode=document.getElementById('subdivName').value;
		var pcode=document.getElementById('panchayatName').value;
		var vcode=document.getElementById('villageName').value;
		var hcode=document.getElementById('habitationName').value;
		 compname="0"+compname;
		 sumcompname="0"+(sumcompname+2);
		var dname= document.forms[0].circleName.options[document.forms[0].circleName.selectedIndex].text;
		var divname= document.forms[0].divisionName.options[document.forms[0].divisionName.selectedIndex].text;
		var subname= document.forms[0].subdivName.options[document.forms[0].subdivName.selectedIndex].text;
	
		if (document.getElementById('pws').checked)
			{
			openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=01&cname='+compname+'&scname='+sumcompname+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
			}
			if (document.getElementById('mpws').checked)
			{
				openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=02&cname='+compname+'&scname='+sumcompname+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
			}
			if (document.getElementById('cpws').checked)
			{
				openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=03&cname='+compname+'&scname='+sumcompname+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
			}
		   
			if (document.getElementById('dp').checked)
			{
				openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=09&cname='+compname+'&scname='+sumcompname+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
			}
 }
 
 
 function  subComponentClicked2(compname,sumcompname)
 { 
 
var ccode=document.getElementById('circleName').value;
var mcode=document.getElementById('mandalName').value;
var dName=document.getElementById('districtName').value;
var divcode=document.getElementById('divisionName').value;
var subcode=document.getElementById('subdivName').value;
var pcode=document.getElementById('panchayatName').value;
var vcode=document.getElementById('villageName').value;
var hcode=document.getElementById('habitationName').value;

if (document.getElementById('pws').checked)
	{
		 compname="0"+compname;
		 sumcompname="0"+(sumcompname+2);
		  var dname= document.forms[0].circleName.options[document.forms[0].circleName.selectedIndex].text;
		 var divname= document.forms[0].divisionName.options[document.forms[0].divisionName.selectedIndex].text;
		 var subname= document.forms[0].subdivName.options[document.forms[0].subdivName.selectedIndex].text;
		openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=01&cname='+compname+'&scname='+sumcompname+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
		}
		if (document.getElementById('mpws').checked)
		{
		   compname="0"+compname;
		  sumcompname="0"+(sumcompname+2);	openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=02&cname='+compname+'&scname='+sumcompname+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
		}
		if (document.getElementById('cpws').checked)
		{
			compname="0"+compname;
		  sumcompname="0"+(sumcompname+2);	openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=03&cname='+compname+'&scname='+sumcompname+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
		}
	   	 if (document.getElementById('dp').checked)
		{
		  compname="0"+compname;
		  sumcompname="0"+(sumcompname+2);
		openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=09&cname='+compname+'&scname='+sumcompname+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
		}
 }


function subComponentClicked(componentName,subComponentName)
{
		  componentName="0"+componentName;
		if(subComponentName<=9)
		{
		subComponentName="00"+subComponentName;
		}
		else
		{
		subComponentName="0"+subComponentName;
		}

		var ccode=document.getElementById('circleName').value;
		var mcode=document.getElementById('mandalName').value;
		var dName=document.getElementById('districtName').value;
		var divcode=document.getElementById('divisionName').value;
		var subcode=document.getElementById('subdivName').value;
		var pcode=document.getElementById('panchayatName').value;
		var vcode=document.getElementById('villageName').value;
		var hcode=document.getElementById('habitationName').value;
		var dname= document.forms[0].circleName.options[document.forms[0].circleName.selectedIndex].text;
		var divname= document.forms[0].divisionName.options[document.forms[0].divisionName.selectedIndex].text;
		var subname= document.forms[0].subdivName.options[document.forms[0].subdivName.selectedIndex].text;


		if (document.getElementById('mpws').checked) //IF MPWS RADIO IS SELECTED
		{                           
		openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=02&cname='+componentName+'&scname='+subComponentName+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
		}
		if (document.getElementById('cpws').checked) //IF CPWS RADIO IS SELECTED
			{
			openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=03&cname='+componentName+'&scname='+subComponentName+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
			}
			if (document.getElementById('pws').checked) //IF PWS RADIO IS SELECTED
			{
			openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=01&cname='+componentName+'&scname='+subComponentName+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
			
			}

		if (document.getElementById('handPump').checked) // IF HANDPUMP IS SELECTED
		 {  
			openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=04&cname='+componentName+'&scname='+subComponentName+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
				
		  }			
		if (document.getElementById('shallowHandPumps').checked) //IF SHALLOW HANDPUMPS RADIO IS SELECTED
		 {                 
			openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=05&cname='+componentName+'&scname='+subComponentName+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
		  }
		if (document.getElementById('openWells').checked) //IF OPEN WELLS RADIO IS SELECTED
		 {                        
		openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=06&cname='+componentName+'&scname='+subComponentName+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);                   
		 }
		if (document.getElementById('ponds').checked) //IF PONDS RADIO IS SELECTED
		 {   
			openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=07&cname='+componentName+'&scname='+subComponentName+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);  					  
		}	
		//IF DIRECT PUMPING RADIO IS SELECTED
		if (document.getElementById('dp').checked)
		{
		openWin('/pred/reports/DpDrilldown.do?mode=dpump&assetType=09&cname='+componentName+'&scname='+subComponentName+'&ccode='+ccode+'&divcode='+divcode+'&subcode='+subcode+'&mcode='+mcode+'&dname='+dname+'&divname='+divname+'&subname='+subname+'&pcode='+pcode+'&vcode='+vcode+'&habcode='+hcode);
		}
}
 </SCRIPT>
