<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page import="nic.watersoft.proposals.workProposals" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<html>
<head>
<script language="JavaScript" src="./resources/calendar.js"></script>
<script language="JavaScript">
function openDdwsForm()
   {
      var chkVal;
      var workStage;
		   for(var i=0;i<document.forms[0].radgroup.length;i++)
		   {
		    if(document.forms[0].radgroup[i].checked)
		    {
		     workStage=document.forms[0].radgroup[i].value;
		    }
		   }
        if(workStage=='08')
        {
        chkVal='ddwsData';
        }
     var cmbCircle=document.getElementById('cmbCircle').value;
     var div=document.getElementById('cmbDivision').value;
     var sdiv=document.getElementById('subdivisioncode').value;
	 var plan = document.getElementById('plan').value;
 	 var wrkType = document.getElementById('wrkType').value;
  	 var workCat = document.getElementById('workCat').value;
   	 var program = document.getElementById('program').value;
  	 var subprogram = document.getElementById('subprogram').value;
  	 var workId = document.getElementById('cmbWorks').value;
     
     var message='';
		  if(document.getElementById('cmbCircle').value=='')
		  {
		    if(message!='')
		    {
		    message=message+',';
		    }
		   message='Circle';
		  }
		  if(document.getElementById('cmbDivision').value=='')
		  {
		  if(message!='')
		    {
		    message=message+',';
		    }
		    message=message+'Division';
		  }
		  if(document.getElementById('workCat').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work Category';
		   }
		
		   if(document.getElementById('cmbWorks').value=='')
		   {
		   if(message!='')
		    {
		    message=message+',';
		    }
		     message=message+'Work '
		   }
     
     if(workStage=='08' && message=='')
     {
   	 	var width = 925;
		var height = 660;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		
		var url = "/pred/works/ddws.do?cmbDivision="+div+"&cmbWorks="+workId+"&workId="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle+"&circleCode="+cmbCircle+"&divCode="+div+"&subdivisioncode="+sdiv+"&plan="+plan+"&wrkType="+wrkType+"&workCat="+workCat+"&program="+program+"&subprogram="+subprogram+"&mode=details";
		var properties = "width="+width+",height="+height+",screenX="+left+",left=15,screenY="+top+",top=15,toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
		newWindow = window.open(url,"", properties);
		 
		newWindow.focus();
      }
     
     else
     {
     alert("Select "+message);
     }
   
   }
function init()
{
 document.forms[0].radgroup[0].checked=false;
 document.forms[0].radgroup[1].checked=false;
 document.forms[0].radgroup[2].checked=false;
 document.forms[0].radgroup[3].checked=false;
 document.forms[0].radgroup[4].checked=false;
 document.forms[0].radgroup[5].checked=false;
 document.forms[0].radgroup[6].checked=false;
 document.forms[0].action="/pred/worksMonitoring/workStatus.do";
 document.monitoringForm.submit();
}
 
 function checkMe()
 {
    
 	//	getAggrigateExpenditure();
 if(document.forms[0].plan[0].checked)
 {
	 if(document.forms[0].wrktype[1].checked==false)
	 {
	 document.forms[0].wrktype[0].checked=true;
	 }
 document.forms[0].wrktype[0].disabled=false;
 document.forms[0].wrktype[1].disabled=false;
 document.forms[0].wrktype[2].disabled=true;
 }
 else if(document.forms[0].plan[1].checked)
 {
 document.forms[0].wrktype[2].checked=true;
 document.forms[0].wrktype[0].disabled=true;
 document.forms[0].wrktype[1].disabled=true;
 document.forms[0].wrktype[2].disabled=false;
 
 }
 else
 {
 document.forms[0].plan[0].checked=true;
 document.forms[0].wrktype[0].checked=true;
 document.forms[0].wrktype[0].disabled=false;
 document.forms[0].wrktype[1].disabled=false;
 document.forms[0].wrktype[2].disabled=true;
 }
 }
  
function includePageWK()
{
  
   var  cmbCircle=document.getElementById('cmbCircle').value;
   var  cmbDivision=document.getElementById('cmbDivision').value;
   var  cmbWorks=document.getElementById('cmbWorks').value;
   var  radgroup=document.getElementById('radgroup').value;
   var workStage;
    for(var i=0;i<document.forms[0].radgroup.length;i++)
	{
		    if(document.forms[0].radgroup[i].checked)
		    {
		     workStage=document.forms[0].radgroup[i].value;
		    }
	}
		    
   if(workStage=='adSan')
   {
    workStage='01'
   }
   if(workStage=='techsan')
   {
    workStage='02'
   }
   var message='';
		  if(document.getElementById('cmbCircle').value=='')
		  {
		   if(message!='')
		    {
		    message=message+',';
		    }
		   message='Circle';
		  }
		  if(document.getElementById('cmbDivision').value=='')
		  {
		   	if(message!='')
		    {
		    message=message+',';
		    } 
		   message=message+'Division';
		  }
//		  if(document.getElementById('program').value=='')
	//	   {
	//	    if(message!='')
	//	    {
	//	    message=message+',';
	//	    }
	//	     message=message+'Program';
	//	   }
	//	   if(document.getElementById('subprogram').value=='')
	//	   {
	//	    if(message!='')
	//	    {
	//	    message=message+',';
	//	    }
	//	     message=message+'SubProgram';
	//	   }
		   if(document.getElementById('cmbWorks').value=='')
		   {
		   	if(message!='')
		    {
		    message=message+',';
		    }
		     message=message+'Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
		  else
		  {
     document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do?divCode="+cmbDivision+"&workStage="+workStage+"&workId="+cmbWorks+"&circleCode="+cmbCircle+"&mode=circles1&wMode=works";//for 100000
     document.forms[0].submit();
     }
    
   }
   function includePageWK1()
{

   var  cmbCircle=document.getElementById('cmbCircle').value;
   var  cmbDivision=document.getElementById('cmbDivision').value;
   var  cmbWorks=document.getElementById('cmbWorks').value;
   var  radgroup=document.getElementById('radgroup').value;
   var workStage;
    for(var i=0;i<document.forms[0].radgroup.length;i++)
	{
		    if(document.forms[0].radgroup[i].checked)
		    {
		     workStage=document.forms[0].radgroup[i].value;
		    }
	}
		    
   if(workStage=='adSan')
   {
    workStage='01'
   }
   if(workStage=='techsan')
   {
    workStage='02'
   }
    var message='';
		  if(document.getElementById('cmbCircle').value=='')
		  {
		  	if(message!='')
		    {
		    message=message+',';
		    }
		   message='Circle';
		  }
		  if(document.getElementById('cmbDivision').value=='')
		  {
		  	if(message!='')
		    {
		    message=message+',';
		    }
		   message=message+'Division';
		  }
//		  if(document.getElementById('program').value=='')
	//	   {
	//	   	if(message!='')
	//	    {
	//	    message=message+',';
	//	    }
     //       message=message+'Program';
	//	   }
	//	   if(document.getElementById('subprogram').value=='')
	//	   {
	//	    if(message!='')
	//	    {
	//	    message=message+',';
	//	    }
	//	     message=message+'SubProgram';
	//	   }
		   if(document.getElementById('cmbWorks').value=='')
		   {
		   	if(message!='')
		    {
		    message=message+',';
		    }
		     message=message+'Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
   else
   {
   //document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do?divCode="+cmbDivision+"&workStage="+workStage+"&workId="+cmbWorks+"&circleCode="+cmbCircle+"&mode=circles&wMode=works";
    document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do?divCode="+cmbDivision+"&workStage="+workStage+"&workId="+cmbWorks+"&circleCode="+cmbCircle+"&wMode=works";//added for district login
     document.forms[0].submit();
   }
  }
var newWindow;
function getFormSprad()
{
document.monitoringForm.revflag.value="1";
document.monitoringForm.submit();
}
function getFormSpradForSourceIdentification()
{
	if(strictlyNumeralsOnlyTest())
	{
		if(document.forms[0].sitehab.value!="" && document.forms[0].subcompType.value!="" && document.forms[0].schemeCode.value!="" && document.forms[0].slNo.value!="")
		{
			if(document.forms[0].schemeCode.value.length==3 && document.forms[0].slNo.value.length==3 && document.forms[0].slNo.value!="000")
			{
				document.monitoringForm.revflag.value="1";
				document.monitoringForm.submit();
			}
			else if(document.forms[0].schemeCode.value.length>3)
			{
				alert("Scheme Code should be of length 3");
			}
			else if(document.forms[0].slNo.value.length>3)
			{
				alert("Sl No. should be of length 3");
			}
			else if(document.forms[0].slNo.value=="000")
			{
				alert("Sl No. should not be 000");
			}
		}
	}
}
function getFormSpradForSourceIdentification2()
{            //alert("in this func");
		if(document.forms[0].sitehab.value!="" && document.forms[0].subcompType.value!="" && document.forms[0].schemeCode.value!="" && document.forms[0].slNo.value!="")
		{
			if(document.forms[0].schemeCode.value.length==3 && document.forms[0].slNo.value.length==3  && document.forms[0].slNo.value!="000")
			{
				document.monitoringForm.revflag.value="1";
				document.monitoringForm.submit();
			}
			else if(document.forms[0].slNo.value=="000")
			{
				alert("Sl No. should not be 000");
			}
		}

}

function strictlyNumeralsOnlyTest(evt)
{
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
    if (charCode < 48 || charCode > 57)
	{
        return false;
    }
	return true;
}
function fngetForm(elem)
{

document.monitoringForm.revflag.value="";
var index = elem.name.substr(5,1);
document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?index="+index;
document.monitoringForm.submit();
}
function getForm()
{
	var message='';
	if(document.getElementById('cmbCircle').value=='')
	{
	   message='Circle';
	}
    if(document.getElementById('cmbDivision').value=='')
	{
		message=message+' Division';
	}
	if(document.getElementById('cmbWorks').value=='')
	{
	   message=message+'  Work '
	}
	if(message!='')
	{
	  alert("Select "+message);
	}
	else
	{
		document.forms[0].action="/pred/worksMonitoring/workStatus.do?mode=data";
		document.monitoringForm.submit();
	}
}
function getFormmandal()
{
	document.forms[0].action="/pred/worksMonitoring/workStatus.do?mode=mandals";
	document.monitoringForm.submit();
}
function getFormSource(){
document.forms[0].action="/pred/worksMonitoring/workStatus.do?mode=source";
document.monitoringForm.submit();
}
function getFormSrctype(){
    // alert("in function");
	var message='';
	if(document.getElementById('cmbCircle').value=='')
	{
	   message='Circle';
	}
    if(document.getElementById('cmbDivision').value=='')
	{
		message=message+' Division';
	}
	if(document.getElementById('cmbWorks').value=='')
	{
	   message=message+'  Work '
	}
	if(message!='')
	{
	  alert("Select "+message);
	}
	else
	{	
		if(document.forms[0].spradgroup[0].checked || document.forms[0].spradgroup[1].checked);
		{
		  	if(document.forms[0].sitehab.value == "")
			{
				alert("Select Source Habitation");
			}
			else if(document.forms[0].subcompType.value == "")
			{
				alert("Select Source Type");		
			}
			else
			{    
				document.forms[0].action="/pred/worksMonitoring/workStatus.do?mode=srctype";
				document.monitoringForm.submit();
			}
			
		}
	}
}
function getForm1()
{
	var ccode = document.getElementById('cmbCircle').value;
	var dcode = document.getElementById('cmbDivision').value;
	var sdcode = document.getElementById('subdivisioncode').value;
	var hcode = document.forms[0].sitehab.value;
	if(document.forms[0].sitehab.value == "")
	{
		alert("Select Source Habitation");
	}
	else if(document.forms[0].subcompType.value == "")
	{
		alert("Select SubComponent Type");		
	}
	else
	{
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		
		var url = "switch.do?prefix=/masters&page=/Asset.do&mode=init&circleOfficeCode="+ccode+"&divisionOfficeCode="+dcode+"&subdivisionOfficeCode="+sdcode+"&from=workstatus";
		alert(url);
		var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
		 
			newWindow = window.open(url,"", properties);
		 
			newWindow.focus();
	}
}
function getSourceIdentificationForm()
{
	var message='';
		  if(document.getElementById('cmbCircle').value=='')
		  {
		   message='Circle';
		  }
		  if(document.getElementById('cmbDivision').value=='')
		  {
		   message=message+' Division';
		  }
//		  if(document.getElementById('program').value=='')
//		   {
	//	     message=message+'  Program';
//		   }
//		   if(document.getElementById('subprogram').value=='')
//		   {
//		     message=message+'  SubProgram';
	//	   }
		   if(document.getElementById('cmbWorks').value=='')
		   {
		     message=message+'  Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
		  else
		  {
document.forms[0].action="/pred/worksMonitoring/workStatus.do?mode=data&spradgroup=data";
document.monitoringForm.submit();
}

}
function getNewSourceCode()
{
 
var hab=document.getElementById('siteHab').value;
 
var subComp=document.getElementById('subcompType').value;
var scheme=document.getElementById('schemeCode').value;
var message=" ";
 
if(hab=='')
{
 message=message+'Habitation and ';
 
}
if(subComp=='')
{  
message=message+'Sub Component and ';
}
if(scheme=='')
{  
message=message+'Scheme Code ';
}
 
if(message.length<=1)
{
document.forms[0].action="/pred/worksMonitoring/workStatus.do?mode=data";
document.monitoringForm.submit();
}
else
{
alert('Select '+message);
}
}
function getWorkExpForm()
{
var message='';
		  if(document.getElementById('cmbCircle').value=='')
		  {
		   message='Circle';
		  }
		  if(document.getElementById('cmbDivision').value=='')
		  {
		   message=message+' Division';
		  }
//		  if(document.getElementById('program').value=='')
//		   {
//		     message=message+'  Program';
//		   }
//		   if(document.getElementById('subprogram').value=='')
//		   {
//		     message=message+'  SubProgram';
//		   }
		   if(document.getElementById('cmbWorks').value=='')
		   {
		     message=message+'  Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
		  else
		  {
document.forms[0].action="/pred/worksMonitoring/workStatus.do?workStage=Wexp&mode=data";
document.monitoringForm.submit();
}
}
function getContMgtForm()
{
var message='';
		  if(document.getElementById('cmbCircle').value=='')
		  {
		   message='Circle';
		  }
		  if(document.getElementById('cmbDivision').value=='')
		  {
		   message=message+' Division';
		  }
//		  if(document.getElementById('program').value=='')
//		   {
//		     message=message+'  Program';
//		   }
//		   if(document.getElementById('subprogram').value=='')
//		   {
//		     message=message+'  SubProgram';
//		   }
		   if(document.getElementById('cmbWorks').value=='')
		   {
		     message=message+'  Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
		  else
		  {
document.forms[0].action="/pred/works/WorkStatus.do?workStage=04&conMode=data&mode=circles1&circleCode="+document.forms[0].cmbCircle.value+"&divCode="+document.forms[0].cmbDivision.value+"&workId="+document.forms[0].cmbWorks.value+"&scheme="+document.forms[0].schemeName.value;//added for 100000
//document.forms[0].action="/pred/works/WorkStatus.do?workStage=04&conMode=data&mode=circles&circleCode="+document.forms[0].cmbCircle.value+"&divCode="+document.forms[0].cmbDivision.value+"&workId="+document.forms[0].cmbWorks.value+"&scheme="+document.forms[0].schemeName.value;
document.monitoringForm.submit();
}
}
function getContMgtForm1()
{
var message='';
		  if(document.getElementById('cmbCircle').value=='')
		  {
		  if(message!='')
		   {
		   message=message+',';
		   }
		   message='Circle';
		  }
		  if(document.getElementById('cmbDivision').value=='')
		  {
		  if(message!='')
		   {
		   message=message+',';
		   }
		   message=message+'Division';
		  }
//		  if(document.getElementById('program').value=='')
//		   {
//		   if(message!='')
//		   {
//		   message=message+',';
//		   }
//		     message=message+'Program';
//		   }
//		   if(document.getElementById('subprogram').value=='')
//		   {
//		   if(message!='')
//		   {
//		   message=message+',';
//		   }
//		     message=message+'SubProgram';
//		   }
		   if(document.getElementById('cmbWorks').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
		  else
		  {
document.forms[0].action="/pred/works/WorkStatus.do?workStage=04&conMode=data&circleCode="+document.forms[0].cmbCircle.value+"&divCode="+document.forms[0].cmbDivision.value+"&workId="+document.forms[0].cmbWorks.value+"&scheme="+document.forms[0].schemeName.value;//added for district login
document.monitoringForm.submit();
}

}

function getWorks()
	{
		document.monitoringForm.action="/pred/worksMonitoring/workStatus.do?mode=workscombo";
		document.monitoringForm.submit();
	}
function getSubDivisions()
	{
		document.monitoringForm.action="/pred/worksMonitoring/workStatus.do?mode=subdivisions";
		document.monitoringForm.submit();
	}
function getDivisions()
	{
		document.monitoringForm.action="/pred/worksMonitoring/workStatus.do?mode=divisions";
		document.monitoringForm.submit();

	}
	function winClose()
{
	location.href="/pred/home.jsp";
}
function main()
{
	window.location="main.jsp";
}
function getSubProgramme()
{
	//alert("aaaa");
	document.monitoringForm.action="/pred/worksMonitoring/workStatus.do?mode=subprogrammes";
	document.monitoringForm.submit();
	
}
function getProgramme()
{
	//alert("aaaa");
	document.monitoringForm.action="/pred/worksMonitoring/workStatus.do?mode=programmes";
	document.monitoringForm.submit();
	
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

function fnWorks()
{
	var radioGroup=document.forms[0].radgroup;
	if(getCheckedValue(radioGroup)=='Wexp')
	{
	document.monitoringForm.action="/pred/worksMonitoring/workStatus.do?mode=data";
	}
	document.monitoringForm.submit();
	
}

function insert()
{
    alert("Record Successfully Inserted");
	document.monitoringForm.flag.value="1";
	document.monitoringForm.action="/pred/worksMonitoring/workStatus.do";
	document.monitoringForm.submit();
}
function revinsert()
{
	alert("Record Successfully Inserted");
	document.monitoringForm.revflag.value="2";
	document.monitoringForm.action="/pred/worksMonitoring/workStatus.do";
	document.monitoringForm.submit();
	}
	function revupdate()
	{
		alert("Record Successfully Updated");
	document.monitoringForm.revflag.value="2";
	document.monitoringForm.action="/pred/worksMonitoring/workStatus.do";
	document.monitoringForm.submit();
   }
   function revfndelete()
   {
   alert("Record Successfully Deleted");
	document.monitoringForm.revdel.value="revdel";
	document.monitoringForm.action="/pred/worksMonitoring/workStatus.do";
	document.monitoringForm.submit();
	}
	function sinsert(elem)
   {
    
     
	//var index = elem.name.substr(5,1);
	 
	var sindex = "sindex";

	//alert("Record Successfully Inserted");
	document.monitoringForm.revflag.value="3";
	document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?sindex="+sindex;
	document.monitoringForm.submit();
	}
	
	function sinsertForSourceIdentification()
   {if(document.forms[0].codeExist.value=="Yes"){
         
        //alert("in this function");
        var hab=document.forms[0].sitehab.value;
        var subcomp=document.forms[0].subcompType.value;
             
           var scode = document.forms[0].oldsrcExist.value;
          if(document.forms[0].sitehab.value=="")
		 {
		 	alert("Select Source Habitation");
		 }
		 else if(document.forms[0].subcompType.value=="")
		 {
		 	alert("Select Source Type");
		 }
		 else if(document.forms[0].subSourceType.value=="")
		 {
		 	alert("Select Subsource Type");
		 }
         else if(!(document.forms[0].spradgroup[0].checked || document.forms[0].spradgroup[1].checked))
		 {
		 	alert("Select Existing Source or New Source");
		 }
		 else if(document.forms[0].spradgroup[0].checked)
		 {	
		 
		 	if(document.forms[0].srcCode.value=="")
		 	{
		 		alert("Select Source Code");
		 	}
		 else if(document.forms[0].spradgroup[0].checked && document.forms[0].srcName.value!="")
        { document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?mode=save";
          document.monitoringForm.submit();
        }
		 	}else if(document.forms[0].spradgroup[1].checked && document.forms[0].newsrcName.value=="")
		 	{
		 		alert("Enter Source Name");
		 	} 	 		
		// var val=confirm("Do you want to delete existing record - Source name: "+scode);
         
        // if(val){
        else if(document.forms[0].spradgroup[1].checked && document.forms[0].newsrcName.value!="")
        { document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?mode=save";
         document.monitoringForm.submit();
        }
        
        // }
         
          }
         else{
       
		 if(document.forms[0].mandalCode.value=="")
		 {
		 	alert("Select Mandal");
		 }
		 else if(document.forms[0].sitehab.value=="")
		 {
		 	alert("Select Source Habitation");
		 }
		 else if(document.forms[0].subcompType.value=="")
		 {
		 	alert("Select Source Type");
		 }
		 else if(document.forms[0].subSourceType.value=="")
		 {
		 	alert("Select Subsource Type");
		 }
		 else if(!(document.forms[0].spradgroup[0].checked || document.forms[0].spradgroup[1].checked))
		 {
		 	alert("Select Existing Source or New Source");
		 }
		 else if(document.forms[0].spradgroup[0].checked)
		 {
		 	if(document.forms[0].srcCode.value=="")
		 	{
		 		alert("Select Source Code");
		 	}
		 	else
		 	{
		 		document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?mode=save";
				document.monitoringForm.submit();
		 	}
		 }
		 else if(document.forms[0].spradgroup[1].checked)
		 {
		 	if(document.forms[0].newsrcName.value=="")
		 	{
		 		alert("Enter Source Name");
		 	}
		 	else
		 	{
		 		document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?mode=save";
				document.monitoringForm.submit();
		 	}
		 }
			} }
	
	function supdateForSourceIdentification()
	{
	
	var sindex = "sindex";
	//	alert("Record Successfully Updated");
	if(document.forms[0].sitehab.value!="" && document.forms[0].subcompType.value!="" && document.forms[0].schemeCode.value!="" && document.forms[0].slNo.value!="" &&  document.forms[0].newsrcCode.value!="")
		{
			if(document.forms[0].schemeCode.value.length==3 && document.forms[0].slNo.value.length==3 && document.forms[0].slNo.value!="000")
			{
			
				document.monitoringForm.revflag.value="3";
				document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?sindex="+sindex;
				document.monitoringForm.submit();
  			 }
			else if(document.forms[0].schemeCode.value.length!=3)
			{
				alert("Scheme Code should be of length 3");
			}
			else if(document.forms[0].slNo.value.length!=3)
			{
				alert("Sl No. should be of length 3");
			}
			else if(document.forms[0].slNo.value=="000")
			{
				alert("Sl No. should not be 000");
			}
		}
		else
		{
			if(document.forms[0].sitehab.value=="")
			{
				alert("Please Select Site Habitation");
			
			}
			else if(document.forms[0].subcompType.value=="")
			{
				alert("Please Select SubComponent Type");
			
			}
			else if(document.forms[0].schemeCode.value=="")
			{
				alert("Please Enter Scheme Code");
			
			}
			else if(document.forms[0].slNo.value=="")
			{
				alert("Please Enter Sl No.");
			
			}
			else if(document.forms[0].newsrcCode.value=="")
			{
				alert("Source Code should not be empty");
			
			}
		
		}
	}
	
	function supdate(index)
	{
	
	var sindex = "sindex";
	//	alert("Record Successfully Updated");
		
	document.monitoringForm.revflag.value="3";
	document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?sindex="+sindex;
	document.monitoringForm.submit();
   }
   function sfndelete()
   {
		if(document.forms[0].mandalCode.value=="")
		 {
		 	alert("Select Mandal");
		 }
		 else if(document.forms[0].sitehab.value=="")
		 {
		 	alert("Select Source Habitation");
		 }
		 else if(document.forms[0].subcompType.value=="")
		 {
		 	alert("Select Source Type");
		 }
		 else if(document.forms[0].subSourceType.value=="")
		 {
		 	alert("Select Subsource Type");
		 }
		 else if(!(document.forms[0].spradgroup[0].checked || document.forms[0].spradgroup[1].checked))
		 {
		 	alert("Select Existing Source or New Source");
		 }
		else if (document.forms[0].spradgroup[0].checked)
		{	
		   if(document.forms[0].srcCode.value == null || document.forms[0].srcCode.value == "")
		   {
		   alert("Select Source Code");
		   }
		   else
		   {
		   	document.monitoringForm.revdel.value="srevdel";
			document.monitoringForm.action="/pred/worksMonitoring/workStatus.do?mode=delete";
			document.monitoringForm.submit();
			}
		 }
		 else if(document.forms[0].spradgroup[1].checked)
		{	
		   if(document.forms[0].newsrcCode.value == null || document.forms[0].newsrcCode.value == "")
		   {
		   alert("Select Source Code");
		   }
			if(document.forms[0].newsrcName.value == null || document.forms[0].newsrcName.value == "")
		   {
		   alert("Enter Source Name");
		   }
		   else
		   {
		   	document.monitoringForm.revdel.value="srevdel";
			document.monitoringForm.action="/pred/worksMonitoring/workStatus.do?mode=delete";
			document.monitoringForm.submit();
			}
		 } 
	}
function update()
{
	alert("Record Successfully Updated1");
	document.monitoringForm.flag.value="1";
	document.monitoringForm.action="/pred/worksMonitoring/workStatus.do";
	document.monitoringForm.submit();
}
function fndelete()
{
	alert("Record Successfully Deleted");
	document.monitoringForm.del.value="del";
	document.monitoringForm.action="/pred/worksMonitoring/workStatus.do";
	document.monitoringForm.submit();
	}
function fnPickHabitations()
{
	
	 
	var coc = document.getElementById("cmbCircle").value;
	var doc = document.getElementById("cmbDivision").value;
	var workID=document.getElementById("cmbWorks").value;
	var soc = "00";
	 
	if(coc == '')
		alert("Please select circle, division and subdivision.");
	else
	if(doc == '')
		alert("Please select division and subdivision.");
	else
	if(soc == '')
		alert("Please select subdivision.");		
	else
	{			
		 
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		var url = "switch.do?prefix=/worksMonitoring&page=/PickHabitation.do&mode=pickhab"
				+ "&coc="+coc+"&doc="+doc+"&soc="+soc+"&workId="+workID;
				
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
		 
			newWindow = window.open(url,"", properties);
		 
			newWindow.focus();
		 
	}
}
function fnPickHabitationsForWorkCompletion()
{
	
	 
	var coc = document.getElementById("cmbCircle").value;
	var doc = document.getElementById("cmbDivision").value;
	var workID=document.getElementById("cmbWorks").value;
	var soc = "00";
	 
	if(coc == '')
		alert("Please select circle, division and subdivision.");
	else
	if(doc == '')
		alert("Please select division and subdivision.");
	else
	if(soc == '')
		alert("Please select subdivision.");		
	else
	{			
		 
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		var url = "switch.do?prefix=/worksMonitoring&page=/PickHabitation.do&mode=pickhab"
				+ "&coc="+coc+"&doc="+doc+"&soc="+soc+"&workId="+workID;
				
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
		 
			newWindow = window.open(url,"", properties);
		 
			newWindow.focus();
		 
	}
}
function revfnPickHabitations()
{
	
	//var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("cmbCircle").value;
	var doc = document.getElementById("cmbDivision").value;
	//var soc = document.getElementById("cmbSubDivision").value;
	var soc = "00";
	if(coc == '')
		alert("Please select circle, division and subdivision.");
	else
	if(doc == '')
		alert("Please select division and subdivision.");
	else
	if(soc == '')
		alert("Please select subdivision.");		
	else
	{			
		//var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	    var workID=document.getElementById("cmbWorks").value;
		var url = "switch.do?prefix=/worksMonitoring&page=/RevPickHabitation.do&mode=pickhab"
				+ "&coc="+coc+"&doc="+doc+"&soc="+soc+"&workId="+workID;
				
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=1,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
		//if( !newWindow || newWindow.closed)
		//{
			newWindow = window.open(url, "", properties);
		//}
		//else
		//{
			newWindow.focus();
		//}
	}
	
}
function addNew()
{
	document.monitoringForm.revflag.value="4";
	document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do?mode=addNew";
	document.monitoringForm.submit();
}
function remove()
{
   var ele=confirm("Do you want to remove ?");
   if(ele)
   {
	document.monitoringForm.revflag.value="remove";
	document.monitoringForm.action ="/pred/worksMonitoring/workStatus.do";
	document.monitoringForm.submit();
	}else
	{
	return;
	}
}

</script>
</head>
<!--  <body onload="hiderev();hideAdminRev();">-->
<body onload="checkMe();">
<html:form action="/workStatus"  >
<center>
</center>
<center>
 	<table cellpadding="0" cellspacing="0" align="center"  >
		<tr height="95%">
			<td>
	<table cellpadding="0" cellspacing="0" width="750" align="center" >
		<tr>
			<td>
 	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=900>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B>Work Status </B><font></td>
	    <td align=right><IMG SRC="/pred/resources/images/icon_help.gif" WIDTH="12" HEIGHT="12" >&nbsp;
		<IMG SRC="/pred/resources/images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_right1.gif" ALT=""></TD>
</TABLE>
<table width="100%"   bgcolor="#DEE3E0" cellpadding="2" cellspacing="2" border="1" bordercolor= "#8A9FCD" rules="none" style="border-collapse:collapse">
	<tr>
	<td>
<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>RWS Offices</b></font></legend>
<label>

	<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tbody class="formTBody">
	  
		<tr class="textborder">	
		<%String cirfi=(String)session.getAttribute("fixcircle");
		
		%>
	    <% if(cirfi==null||!cirfi.equals("yes"))
		 { 
	//getDivisions();getProgramme();getSubProgramme();fnWorks();
		 %>
		<logic:present name="circles">
		
		<td><bean:message key="app.circle"/><span class="mandatory">*</span></td>
		
		<td><html:select property="cmbCircle" style="width:183px" styleClass="mycombo" onchange="JavaScript:init();getDivisions();">
			<html:option value="">Select...</html:option>
			<html:options collection="circles"  property="value" labelProperty="label" />
			</html:select>
	 	</td>
		
		</logic:present>
		<logic:notPresent name="circles">
		<td  ><bean:message key="app.circle" /><span class="mandatory">*</span></td>
		
		<td><html:select property="cmbCircle" style="width:183px" styleClass="mycombo" >
			<html:option value="">Select...</html:option>
			</html:select>
		</td>
		</logic:notPresent>
		
	   <%} %>
		
		<logic:present name="fixcircle">
		<logic:present name="circles">
		
		<td  ><bean:message key="app.circle" />
		
		<td  ><html:select property="cmbCircle" disabled="true" style="width:183px" styleClass="mycombo" onchange="JavaScript:init();getDivisions();">
			<html:option value="">Select...</html:option>
			<html:options collection="circles"  property="value" labelProperty="label" />
			</html:select>
			
		</td>
		
		</logic:present>
	 	</logic:present>
	
		<td ><bean:message key="app.division" /><span class="mandatory">*</span></td>
		
		<td ><html:select property="cmbDivision" style="width:183px" styleClass="mycombo" onchange="JavaScript:init();getSubDivisions();">
			<html:option value="">Select...</html:option>
			<logic:present name="divisions"> 
			<html:options collection="divisions" name="division" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
		</td>
		 <td>SubDivision</td>
		 <td >
		 <html:select property="subdivisioncode" style="width:183px" styleClass="mycombo" onchange="JavaScript:init();getProgramme();">
			<html:option value="">Select...</html:option>
			<logic:present name="subdivisions"> 
			<html:options collection="subdivisions" name="subdivision" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
		
	</tr>
	<tr>
		<td class="textborder" colspan="4" nowrap>
		<html:radio property="plan" value="1" onclick="checkMe();getProgramme();">Plan</html:radio>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:radio property="plan" value="2" onclick="checkMe();getProgramme();">Non Plan</html:radio>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <html:radio property="wrktype" value="1" onclick="getProgramme();">MainScheme</html:radio>
        <html:radio property="wrktype" value="2" onclick="getProgramme();">Augmentation</html:radio>
        <html:radio property="wrktype" value="3" onclick="getProgramme();">Maintenance</html:radio>
		</td>
		<td class="textborder" nowrap>
		Work Category<span class="mandatory">*</span></td>
		<td>
		<html:select property="workCat" style="width:143px" styleClass="mycombo" onchange="getProgramme();">
		<html:option value="">Select...</html:option>
		<logic:present name="workCategory">
		<html:options collection="workCategory" property="value" labelProperty="label"/> 
		</logic:present>
		</html:select>
		</td>
		</tr>
	
	<tr>
	<td>Programme<span class="mandatory">*</span></td>
        <td>
		     <html:select property="program" style="width:183px" styleClass="mycombo" onchange="JavaScript:init();getSubProgramme();">
			<html:option value="">Select...</html:option>
			<logic:present name="programmes"> 
			<html:options collection="programmes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
	    <td>SubProgramme<span class="mandatory">*</span></td>
        <td>
		     <html:select property="subprogram" style="width:183px" styleClass="mycombo" onchange="JavaScript:init();getWorks();">
			<html:option value="">Select...</html:option>
			<logic:present name="subprogrammes"> 
			<html:options collection="subprogrammes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
	</tr>
	 
	 <tr >
		<logic:present name="works">
		 <td><bean:message key="app.work" /><span class="mandatory">*</span></td>
		
		<td  colspan=3><html:select property="cmbWorks" style="width:490px" styleClass="mycombo" onchange="JavaScript:init();fnWorks();">
		 	<html:option value="">Select...</html:option>
			<html:options collection="works"  property="workid" labelProperty="workname" />
			</html:select>
			
		</td>
		 
		<td>Scheme</td><td><html:text property="schemeName" readonly="true" styleClass="mytext" maxlength="10" style="width:80px" /></td>
		 
		</logic:present>
		<logic:notPresent name="works">
		 <td ><bean:message key="app.work" /></td>
	 	 <td ><html:select property="cmbWorks" style="width:500px" styleClass="mycombo" onchange="JavaScript:init();fnWorks();">
	 	 <html:option value="">Select...</html:option>
	    </html:select>
		</td>
		<td>Scheme</td><td><html:text property="schemeName" readonly="true" styleClass="mytext" maxlength="10"style="width:80px"/></td>
		</logic:notPresent>
	    </tr>
		</tbody>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		
		<!-- ------------- -------------------- -->
		   <!-- <tr>
			<td>
		    <fieldset>
		    <legend><font color=#871D0E face=verdana size=2><b>Work Details</b></font></legend>
		    <label>
			<table>
			<tbody class="formTBody">
			<tr>
			<td>Programme:<html:text property="programmeName" readonly="true" /></td>
			<td>Sub Programme:<html:text property="subprogrammeName" readonly="true"/></td>
			<td>Scheme :<html:text property="schemeName" readonly="true"/></td>
		 	</tr>
			</tbody>
			</table></label>
			</fieldset>
			</td>
			</tr>-->
			 
	   <!-- ------------- -->
		<tr>
	<td>
<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Work Stages</b></font></legend>
<label>
	<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tbody class="formTBody">
	
	<%
	String cirfix=(String)session.getAttribute("fixcircle");
	
	String s=request.getParameter("radgroup");
	
	if (s==null)
	s="";
	if (s=="")
	{
	
	%>
		
	<tr class="textborder">	
		
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=adSan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=adSan   onclick="includePageWK()" >
		 <%}%>
		<td>Admin Sanction</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=techsan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=techsan   onclick="includePageWK()" >
		 <%}%>
		<td>Technical Sanction</td>
		<td><input type="radio" name=radgroup value=sitePrep  onclick="getSourceIdentificationForm()" >
		<td>Source Identification</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=contMgnt   onclick="getContMgtForm1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=contMgnt    onclick="getContMgtForm()" >
		 <%}%>
		<td >Contractor Management</td>
		</tr>
		<tr class="textborder">	
		<!-- <td width="50"><input type="radio" name=radgroup value=workGnd class="comboFont" onclick="getForm()" >
		 <td width="160">   Work Grounded  </td> -->
		<td ><input type="radio" name=radgroup  value=wip  onclick="getForm()" > 
		<td >Program Schedule</td>
		<td ><input type="radio" name=radgroup  value=Wexp  onclick="getWorkExpForm()"> 
		<td >Work Expenditure</td>
		<td ><input type="radio" name=radgroup  value=workComp  onclick="getForm()" >
		<td >Work Completion</td>
		<td><input type="radio" name="radgroup" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
		<td>DDWS Data Entry </td>
		</tr>
		<%}
		
		if (s.equals("adSan"))
		{
		
			%>
			<tr class="textborder">	
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=adSan  checked="true" onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=adSan   checked="true" onclick="includePageWK()" >
		 <%}%>
		
		<td>Admin Sanction</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=techsan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=techsan   onclick="includePageWK()" >
		 <%}%>
		<td>Technical Sanction</td>
		<td><input type="radio" name=radgroup value=sitePrep  onclick="getSourceIdentificationForm()" >
		<td>Source Identification*</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=contMgnt   onclick="getContMgtForm1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=contMgnt    onclick="getContMgtForm()" >
		 <%}%>
		<td >Contractor Management</td>
		</tr>
		<tr class="textborder">	
		<!-- <td width="50"><input type="radio" name=radgroup value=workGnd class="comboFont" onclick="getForm()" >
		 <td width="160">   Work Grounded  </td> -->
		<td ><input type="radio" name=radgroup  value=wip  onclick="getForm()" > 
		<td >Program Schedule</td>
		<td ><input type="radio" name=radgroup  value=Wexp  onclick="getWorkExpForm()"> 
		<td >Work Expenditure</td>
		<td ><input type="radio" name=radgroup  value=workComp  onclick="getForm()" >
		<td >Work Completion</td>
		<!-- <td width="50"><input type="radio" name=radgroup  value=amStone class="comboFont"   >
		<td width="160">   All Stages  </td>-->
		<td><input type="radio" name="radgroup" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
		<td>DDWS Data Entry </td>
		</tr>
		<%}%>
		<%
				if (s.equals("techsan"))
		{
		
			%>
			<tr class="textborder">	
		   <%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=adSan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=adSan   onclick="includePageWK()" >
		 <%}%>
		
		<td>Admin Sanction</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=techsan checked="true"  onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=techsan checked="true"  onclick="includePageWK()" >
		 <%}%>
		<td>Technical Sanction</td>
		<td><input type="radio" name=radgroup value=sitePrep  onclick="getSourceIdentificationForm()" >
		<td>Source Identification</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=contMgnt   onclick="getContMgtForm1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=contMgnt    onclick="getContMgtForm()" >
		 <%}%>
		<td >Contractor Management</td>
		</tr>
		<tr class="textborder">	
		<!-- <td width="50"><input type="radio" name=radgroup value=workGnd class="comboFont" onclick="getForm()" >
		 <td width="160">   Work Grounded  </td> -->
		<td ><input type="radio" name=radgroup  value=wip  onclick="getForm()" > 
		<td >Program Schedule</td>
		<td ><input type="radio" name=radgroup  value=Wexp onclick="getWorkExpForm()"> 
		<td >Work Expenditure</td>
		<td ><input type="radio" name=radgroup  value=workComp  onclick="getForm()" >
		<td >Work Completion</td>
		<!-- <td width="50"><input type="radio" name=radgroup  value=amStone class="comboFont"   >
		<td width="160">   All Stages  </td>-->
		<td><input type="radio" name="radgroup" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
		<td>DDWS Data Entry </td>
		   </tr>
		
		    
			<%}%>	
			<%
				if (s.equals("sitePrep"))
		{
			
			
			%>
			<tr class="textborder">	
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=adSan  onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=adSan   onclick="includePageWK()" >
		 <%}%>
		<!-- <option value="adSan" selected></option></td> -->
		<td >   Admin Sanction </td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=techsan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=techsan   onclick="includePageWK()" >
		 <%}%>
		<td >   Technical Sanction </td>
		<td ><input type="radio" name=radgroup value=sitePrep  checked="true" onclick="getSourceIdentificationForm()" >
		<td >   Source Identification  </td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=contMgnt   onclick="getContMgtForm1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=contMgnt    onclick="getContMgtForm()" >
		 <%}%>
		<td >Contractor Management</td>
		</tr>
		<tr class="textborder">	
		<!-- <td width="50"><input type="radio" name=radgroup value=workGnd class="comboFont" onclick="getForm()" >
		 <td width="160">   Work Grounded  </td> -->
		<td ><input type="radio" name=radgroup  value=wip  onclick="getForm()" > 
		<td >   Program Schedule  </td>
		<td ><input type="radio" name=radgroup  value=Wexp   onclick="getWorkExpForm()"> 
		<td >   Work Expenditure  </td>
		
		<td ><input type="radio" name=radgroup  value=workComp  onclick="getForm()">
		<td >   Work Completion  </td>
		<!-- <td width="50"><input type="radio" name=radgroup  value=amStone class="comboFont" >
		<td width="160">   All Stages  </td>-->
		<td><input type="radio" name="radgroup" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
		<td>DDWS Data Entry </td>
		
		</tr>
			<%}%>	
			<%
				if (s.equals("contMgnt"))
		{
		
			%>
			<tr class="textborder">	
		
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=adSan  onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=adSan   onclick="includePageWK()" >
		 <%}%>
		<!-- <option value="adSan" selected></option></td> -->
		<td>Admin Sanction</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=techsan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=techsan   onclick="includePageWK()" >
		 <%}%>
		<td>Technical Sanction</td>
		<td><input type="radio" name=radgroup value=sitePrep  onclick="getSourceIdentificationForm()" >
		<td>Source Identification</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=contMgnt checked="true"  onclick="getContMgtForm1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=contMgnt  checked="true"   onclick="getContMgtForm()" >
		 <%}%>
		<td >Contractor Management</td>
		</tr>
		<tr class="textborder">	
		<!-- <td width="50"><input type="radio" name=radgroup value=workGnd class="comboFont" onclick="getForm()" >
		 <td width="160">   Work Grounded  </td> -->
		<td ><input type="radio" name=radgroup  value=wip  onclick="getForm()" > 
		<td >Program Schedule</td>
		<td ><input type="radio" name=radgroup  value=Wexp  onclick="getWorkExpForm()"> 
		<td >Work Expenditure</td>
		<td ><input type="radio" name=radgroup  value=workComp  onclick="getForm()" >
		<td >Work Completion</td>
		<!-- <td width="50"><input type="radio" name=radgroup  value=amStone class="comboFont"   >
		<td width="160">   All Stages  </td>-->
		<td><input type="radio" name="radgroup" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
		<td>DDWS Data Entry </td>
		</tr>
			<%}%>	
		
			<%
				if (s.equals("wip"))
		{
	
			%>
		<tr class="textborder">	
		
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=adSan  onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=adSan   onclick="includePageWK()" >
		 <%}%>
		<!-- <option value="adSan" selected></option></td> -->
		<td>Admin Sanction</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=techsan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=techsan   onclick="includePageWK()" >
		 <%}%>
		<td>Technical Sanction</td>
		<td><input type="radio" name=radgroup value=sitePrep  onclick="getSourceIdentificationForm()" >
		<td>Source Identification</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=contMgnt checked="true"  onclick="getContMgtForm1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=contMgnt  checked="true"   onclick="getContMgtForm()" >
		 <%}%>
		<td >Contractor Management</td>
		</tr>
		<tr class="textborder">	
		<!-- <td width="50"><input type="radio" name=radgroup value=workGnd class="comboFont" onclick="getForm()" >
		 <td width="160">   Work Grounded  </td> -->
		<td ><input type="radio" name=radgroup  value=wip  checked="true"  onclick="getForm()" > 
		<td >Program Schedule</td>
		<td ><input type="radio" name=radgroup  value=Wexp  onclick="getWorkExpForm()"> 
		<td >Work Expenditure</td>
		<td ><input type="radio" name=radgroup  value=workComp  onclick="getForm()" >
		<td >Work Completion</td>
		<!-- <td width="50"><input type="radio" name=radgroup  value=amStone class="comboFont"   >
		<td width="160">   All Stages  </td>-->
		<td><input type="radio" name="radgroup" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
		<td>DDWS Data Entry </td>
		</tr>
			<%}%>	
			<%
				if (s.equals("workComp"))
		{
		
			%>
			<tr class="textborder">	
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=adSan  onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=adSan   onclick="includePageWK()" >
		 <%}%>
		<!-- <option value="adSan" selected></option></td> -->
		<td>Admin Sanction</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=techsan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=techsan   onclick="includePageWK()" >
		 <%}%>
		<td>Technical Sanction</td>
		<td><input type="radio" name=radgroup value=sitePrep  onclick="getSourceIdentificationForm()" >
		<td>Source Identification</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=contMgnt checked="true"  onclick="getContMgtForm1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=contMgnt  checked="true"   onclick="getContMgtForm()" >
		 <%}%>
		<td >Contractor Management</td>
		</tr>
		<tr class="textborder">	
		<!-- <td width="50"><input type="radio" name=radgroup value=workGnd class="comboFont" onclick="getForm()" >
		 <td width="160">   Work Grounded  </td> -->
		<td ><input type="radio" name=radgroup  value=wip   onclick="getForm()" > 
		<td >Program Schedule</td>
		<td ><input type="radio" name=radgroup  value=Wexp  onclick="getWorkExpForm()"> 
		<td >Work Expenditure</td>
		<td ><input type="radio" name=radgroup  value=workComp  onclick="getForm()" checked="true" >
		<td >Work Completion</td>
		<!-- <td width="50"><input type="radio" name=radgroup  value=amStone class="comboFont"   >
		<td width="160">   All Stages  </td>-->
		<td><input type="radio" name="radgroup" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
		<td>DDWS Data Entry </td>
		
		</tr>
			<%}%>	
			<%
				if (s.equals("amStone"))
		{
		
			%>
			<tr class="textborder">	
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=adSan  onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=adSan   onclick="includePageWK()" >
		 <%}%>
		<!-- <option value="adSan" selected></option></td> -->
		<td width="160">   Admin Sanction  </td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=techsan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=techsan   onclick="includePageWK()" >
		 <%}%>
		<td width="160">   Technical Sanction  </td>
			<td width="50"><input type="radio" name=radgroup value=sitePrep class="comboFont" onclick="getSourceIdentificationForm()" >
		<td width="160">   Source Identification  </td>
		</tr>
	<tr class="textborder">	
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=contMgnt checked="true"  onclick="getContMgtForm1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=contMgnt  checked="true"   onclick="getContMgtForm()" >
		 <%}%>
		<td width="160">   Contractor Management  </td>
		<!-- <td width="50"><input type="radio" name=radgroup value=workGnd class="comboFont" onclick="getForm()" >
		 <td width="160">   Work Grounded  </td> -->
		<td width="50"><input type="radio" name=radgroup  value=wip class="comboFont" onclick="getForm()" > 
		<td width="160">   Program Schedule  </td>
		<td width="50"><input type="radio" name=radgroup  value=Wexp  class="comboFont" onclick="getWorkExpForm()"> 
		<td width="160">   Work Expenditure  </td>
		</tr>
		<tr class="textborder">	
		<td width="50"><input type="radio" name=radgroup  value=workComp class="comboFont" onclick="getForm()" >
		<td width="160">   Work Completion  </td>
		<!-- <td width="50"><input type="radio" name=radgroup  value=amStone class="comboFont"  checked="true">
		<td width="160">   All Stages  </td>-->
		<td><input type="radio" name="radgroup" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
		<td>DDWS Data Entry </td>
		</tr>
			<%}%>	
			
		<%
		if (s.equals("Wexp"))
		{
		
			%>
			<tr class="textborder">	
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=adSan  onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=adSan   onclick="includePageWK()" >
		 <%}%>
		<!-- <option value="adSan" selected></option></td> -->
		<td>Admin Sanction</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=techsan   onclick="includePageWK1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=techsan   onclick="includePageWK()" >
		 <%}%>
		<td>Technical Sanction</td>
		<td><input type="radio" name=radgroup value=sitePrep  onclick="getSourceIdentificationForm()">
		<td>Source Identification</td>
		<%if(session.getAttribute("fixcircle")!=null) 
		{
		%>
		<td ><input type="radio" name=radgroup value=contMgnt checked="true"  onclick="getContMgtForm1()">
		<%}
		else
		{%>
		<td><input type="radio" name=radgroup value=contMgnt  checked="true"   onclick="getContMgtForm()" >
		 <%}%>
		<td >Contractor Management</td>
		</tr>
		<tr class="textborder">	
		<!-- <td width="50"><input type="radio" name=radgroup value=workGnd class="comboFont" onclick="getForm()" >
		 <td width="160">   Work Grounded  </td> -->
		<td ><input type="radio" name=radgroup  value=wip  onclick="getForm()" > 
		<td >Program Schedule</td>
		<td ><input type="radio" name=radgroup  value=Wexp checked="true"  onclick="getWorkExpForm()"> 
		<td >Work Expenditure</td>
		<td ><input type="radio" name=radgroup  value=workComp  onclick="getForm()" >
		<td >Work Completion</td>
		<!-- <td width="50"><input type="radio" name=radgroup  value=amStone class="comboFont"   >
		<td width="160">   All Stages  </td>-->
		<td><input type="radio" name="radgroup" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
		<td>DDWS Data Entry </td>
		</tr>
			<%}%>	
		</tbody>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<%
     	if (request.getParameter("radgroup")!=null && request.getParameter("radgroup").equals("adSan"))
		{
		%>
		<%@ include file="/worksMonitoring/Work_Status_Admin_Form.jsp" %>
		<%}%>
		<%
		if (request.getParameter("radgroup")!=null && request.getParameter("radgroup").equals("techsan"))
		{
		%>
		<%@ include file="/worksMonitoring/Work_Status_Tech_Form.jsp" %>
				<%} %>
		
		<%
		if (request.getParameter("radgroup")!=null && request.getParameter("radgroup").equals("sitePrep"))
		{
		%>
		<%@ include file="/worksMonitoring/Work_Status_Source_Form.jsp" %>
		<%}%>
		 
		<%
		if (request.getParameter("radgroup")!=null && request.getParameter("radgroup").equals("contMgnt"))
		{
		%>
		<%@ include file="/worksMonitoring/Work_Status_ContMgnt_Form.jsp" %>
				<%}%>
	 	<%
		if (request.getParameter("radgroup")!=null && request.getParameter("radgroup").equals("wip"))
		{
		%>
		<%@ include file="/worksMonitoring/Work_Status_WIP_Form.jsp" %>
				<%}%>
		<%if (request.getParameter("radgroup")!=null && request.getParameter("radgroup").equals("Wexp"))
		{
		%>
		<%@ include file="/worksMonitoring/Work_Status_Work_Exp_Form.jsp" %>
				<%}%>
		<%
		if (request.getParameter("radgroup")!=null && request.getParameter("radgroup").equals("workComp"))
		{
		%>
				<%@ include file="/worksMonitoring/Work_Status_WorkComp_Form.jsp" %>
		<%}%>
	 	<%
		if (request.getParameter("radgroup")!=null && request.getParameter("radgroup").equals("amStone"))
		{
		%>
		<%@ include file="/worksMonitoring/Work_Status_All_Form.jsp" %>
	    <%}%>
	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
    <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_b_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=900>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_b_right1.gif" ALT=""></TD>
</TABLE>
</center>	
<br><br>
<center>				
		<div class="pageFooter">  Designed and Developed by National Informatics Centre, AP State Center</div></td>	
 </center>
  </body>
  </html:form>
 <%@ include file="/commons/rws_alert.jsp"%>